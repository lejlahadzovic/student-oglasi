﻿using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Services
{
    public class SmjestajiService : BaseCRUDService<Model.Smjestaji, Database.Smjestaji, SmjestajiSearchObject, SmjestajiInsertRequest, SmjestajiUpdateRequest>, ISmjestajiService
    {
        private readonly RecommenderSystem _recommenderSystem;
        private readonly SlikeService _slikeService;

        public readonly ObavijestiService _obavijestiService;
        private readonly SmjestajnaJedinicaService _smjestajneJediniceService;
        public SmjestajiService(StudentoglasiContext context, IMapper mapper, SlikeService slikeService, SmjestajnaJedinicaService smjestajneJediniceService, ObavijestiService obavijestiService, RecommenderSystem recommenderSystem) : base(context, mapper)
        {
            _obavijestiService = obavijestiService;
            _recommenderSystem = recommenderSystem;
            _slikeService = slikeService;
            _smjestajneJediniceService = smjestajneJediniceService;
        }
        public override async Task<Model.Smjestaji> Insert(SmjestajiInsertRequest request)
        {
            var entity = await base.Insert(request);

            string title = entity.Naziv;
            await _obavijestiService.SendNotificationSmjestaj("Smještaj ", title, entity.Id,"success");

            return entity;
        }
        public override IQueryable<Database.Smjestaji> AddFilter(IQueryable<Database.Smjestaji> query, SmjestajiSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.Contains(search.Naziv));
            }
            if (search?.GradID != null)
            {
                filteredQuery = filteredQuery.Where(x => x.GradId == search.GradID);
            }
            if (search?.TipSmjestajaID != null)
            {
                filteredQuery = filteredQuery.Where(x => x.TipSmjestajaId == search.TipSmjestajaID);
            }
            return filteredQuery;
        }
        public override IQueryable<Database.Smjestaji> AddInclude(IQueryable<Database.Smjestaji> query, SmjestajiSearchObject? search = null)
        {
            query = query.Include(s=> s.Grad)
                 .Include(s=>s.TipSmjestaja)
                 .Include(s=>s.Slikes)
                 .Include(s => s.SmjestajnaJedinicas)
                    .ThenInclude(sj => sj.Slikes);
            return base.AddInclude(query, search);
        }
        public override async Task BeforeDelete(Database.Smjestaji smjestaj)
        {
            var smjestajWithRelations = await _context.Smjestajis
           .Include(s => s.Slikes)
           .Include(s=>s.SmjestajnaJedinicas)
           .ThenInclude(sj => sj.Slikes)
           .FirstOrDefaultAsync(s => s.Id == smjestaj.Id);

            if (smjestajWithRelations != null)
            {
                if (smjestajWithRelations != null)
                {
                    var relatedObavijesti = _context.Obavijestis.Where(o => o.SmjestajiId == smjestajWithRelations.Id);
                    _context.Obavijestis.RemoveRange(relatedObavijesti);

                }
                var slike = smjestajWithRelations.Slikes.ToList();
                if (slike != null)
                {
                    foreach (var slika in slike)
                    {
                        await _context.Slikes.FindAsync(slika.SlikaId);
                        _context.Slikes.Remove(slika);
                        await _context.SaveChangesAsync();
                    }
                }
                var smjestajneJedinice = smjestajWithRelations.SmjestajnaJedinicas.ToList();

                if(smjestajneJedinice!= null) { 
                foreach (var jedinica in smjestajneJedinice)
                {
                    await _smjestajneJediniceService.Delete(jedinica.Id);
                }
                }
               
            }
        }
        public async Task<List<Model.Smjestaji>> GetRecommendedSmjestaji(int studentId)
        {
            var recommendedPostIds = await _recommenderSystem.GetRecommendedPostIds(studentId, "accommodation");

            var recommendedSmjestaji = await _context.Smjestajis
                .Where(p => recommendedPostIds.Contains(p.Id))
                .Include(p => p.Slikes)
                .ToListAsync();

            return _mapper.Map<List<Model.Smjestaji>>(recommendedSmjestaji);
        }
    }
}