﻿using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.StateMachines.PrakseStateMachine;

namespace StudentOglasi.Services.Services
{
    public class PrakseService : BaseCRUDService<Model.Prakse, Database.Prakse, PrakseSearchObject, PrakseInsertRequest, PrakseUpdateRequest>, IPrakseService
    {
        private readonly RecommenderSystem _recommenderSystem;
        public readonly FileService _fileService;
        public BasePrakseState _baseState { get; set; }
        public PrakseService(StudentoglasiContext context, IMapper mapper, FileService fileService, RecommenderSystem recommenderSystem, BasePrakseState baseState) : base(context, mapper)
        {
            _recommenderSystem = recommenderSystem;
            _fileService = fileService;
            _baseState = baseState;
        }

        public async Task<List<Model.Prakse>> GetRecommendedPrakse(int studentId)
        {
            var recommendedPostIds = await _recommenderSystem.GetRecommendedPostIds(studentId, "internship");

            var recommendedPrakse = await _context.Prakses
                .Include(p => p.IdNavigation)
                .Where(p => recommendedPostIds.Contains(p.Id))
                .ToListAsync();

            return _mapper.Map<List<Model.Prakse>>(recommendedPrakse);
        }

        public override Task<Model.Prakse> Insert(PrakseInsertRequest insert)
        {
            var state = _baseState.CreateState("Initial");
            return state.Insert(insert);
        }
        public override IQueryable<Database.Prakse> AddFilter(IQueryable<Database.Prakse> query, PrakseSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naslov))
            {
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.Naslov.Contains(search.Naslov));
            }
            if (search?.Organizacija!=null)
            {
                filteredQuery = filteredQuery.Where(x=>x.Organizacija.Id == search.Organizacija);
            }
            if (search?.Status != null)
            {
                filteredQuery = filteredQuery.Where(x => x.StatusId == search.Status);
            }
            return filteredQuery;
        }
        public override async Task<PagedResult<Model.Prakse>> Get(PrakseSearchObject? search = null)
        {
            var query = _context.Set<Database.Prakse>().Include(p => p.IdNavigation).Include(p=>p.Organizacija).Include(p => p.Status).AsQueryable();

            PagedResult<Model.Prakse> result = new PagedResult<Model.Prakse>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Model.Prakse>>(list);
            result.Result = tmp;
            return result;
        }

        public override async Task<Model.Prakse> GetById(int id)
        {
            var entity = await _context.Set<Database.Prakse>().Include(p => p.Organizacija).Include(p => p.Status).FirstOrDefaultAsync(p => p.Id == id);

            return _mapper.Map<Model.Prakse>(entity);
        }

        public override async Task Delete(int id)
        {
            var query = _context.Set<Database.Prakse>().Include(p => p.IdNavigation);
            var entity = await query.FirstOrDefaultAsync(p => p.Id == id);

            if (entity == null)
                throw new Exception("Objekat nije pronađen");


            if (entity.IdNavigation.Slika != null)
            {
                try
                {
                    await _fileService.DeleteAsync(entity.IdNavigation.Slika);
                }
                catch (Exception ex)
                {
                    throw new Exception("Greška pri brisanju slike.", ex);
                }
            }
            _context.Oglasis.Remove(entity.IdNavigation);

            _context.Prakses.Remove(entity);
            await _context.SaveChangesAsync();
        }
        public override async Task<Model.Prakse> Update(int id, PrakseUpdateRequest update)
        {
            var set = _context.Set<Database.Prakse>();

            var entity = await set.Include(p => p.IdNavigation).FirstOrDefaultAsync(e => e.Id == id);
            entity.Status = await _context.StatusOglasis.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

           return await state.Update(id, update);
        }
        public async Task<Model.Prakse> Activate(int id)
        {
            var set = _context.Set<Database.Prakse>();

            var entity = await set.FindAsync(id);
            entity.Status = await _context.StatusOglasis.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Activate(id);
        }
        public async Task<Model.Prakse> Hide(int id)
        {
            var set = _context.Set<Database.Prakse>();

            var entity = await set.FindAsync(id);
            entity.Status = await _context.StatusOglasis.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Hide(id);
        }
        public async Task<List<string>> AllowedActions(int id)
        {
            var set = _context.Set<Database.Prakse>();

            var entity = await set.FindAsync(id);
            entity.Status = await _context.StatusOglasis.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv??"Initial");
            return await state.AllowedActions();
        }
    }
}