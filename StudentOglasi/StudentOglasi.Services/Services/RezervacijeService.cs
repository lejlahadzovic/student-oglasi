using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Model;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Azure.Storage.Blobs.Models;
using StudentOglasi.Services.StateMachines.RezervacijeStateMachine;

namespace StudentOglasi.Services.Services
{
    public class RezervacijeService : BaseService<Model.Rezervacije, Database.Rezervacije, RezervacijeSearchObject>, IRezervacijeService
    {
        public BaseRezervacijaState _baseState { get; set; }
        public RezervacijeService(StudentoglasiContext context, IMapper mapper, BaseRezervacijaState baseState) : base(context, mapper)
        {
            _baseState = baseState;
        }
        public override IQueryable<Database.Rezervacije> AddFilter(IQueryable<Database.Rezervacije> query, RezervacijeSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Ime))
            {
                filteredQuery = filteredQuery.Where(x => x.Student.IdNavigation.Ime.Contains(search.Ime) || x.Student.IdNavigation.Prezime.Contains(search.Ime));
            }
            if (!string.IsNullOrWhiteSpace(search?.BrojIndeksa))
            {
                filteredQuery = filteredQuery.Where(x => x.Student.BrojIndeksa.Contains(search.BrojIndeksa));
            }
            if (search?.Status != null)
            {
                filteredQuery = filteredQuery.Where(x => x.StatusId == search.Status);
            }
            if (search?.SmjestajId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.SmjestajnaJedinica.SmjestajId == search.SmjestajId);
            }

            if (search?.SmjestajnaJedinicaId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.SmjestajnaJedinicaId == search.SmjestajnaJedinicaId);
            }

            if (search?.PocetniDatum != null)
            {
                filteredQuery = filteredQuery.Where(x => x.DatumPrijave >= search.PocetniDatum);
            }

            if (search?.KrajnjiDatum != null)
            {
                filteredQuery = filteredQuery.Where(x => x.DatumPrijave <= search.KrajnjiDatum);
            }
            return filteredQuery;
        }
        public override async Task<PagedResult<Model.Rezervacije>> Get(RezervacijeSearchObject? search = null)
        {
            var query = _context.Set<Database.Rezervacije>()
                .Include(r => r.SmjestajnaJedinica)
                    .ThenInclude(sj => sj.Smjestaj)
                        .ThenInclude(s => s.Grad)
                 .Include(r => r.SmjestajnaJedinica)
                    .ThenInclude(sj => sj.Smjestaj)
                        .ThenInclude(s => s.TipSmjestaja)
                .Include(r => r.Student)
                .Include(r => r.Student.Fakultet)
                .Include(r => r.Student.Smjer)
                .Include(r => r.Student.NacinStudiranja)
                .Include(r => r.Student.IdNavigation)
                .Include(r => r.Status).AsQueryable();

            PagedResult<Model.Rezervacije> result = new PagedResult<Model.Rezervacije>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Model.Rezervacije>>(list);
            result.Result = tmp;
            return result;
        }
        public async Task<Model.Rezervacije> Cancel(int studentId, int smjestajnaJedinicaId)
        {
            var set = _context.Set<Database.Rezervacije>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.SmjestajnaJedinicaId == smjestajnaJedinicaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Cancel(studentId, smjestajnaJedinicaId);
        }

        public async Task<Model.Rezervacije> Approve(int studentId, int smjestajnaJedinicaId)
        {
            var set = _context.Set<Database.Rezervacije>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.SmjestajnaJedinicaId == smjestajnaJedinicaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Approve(studentId, smjestajnaJedinicaId);
        }
        public async Task<List<string>> AllowedActions(int studentId, int smjestajnaJedinicaId)
        {
            var set = _context.Set<Database.Rezervacije>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.SmjestajnaJedinicaId == smjestajnaJedinicaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv ?? "Na cekanju");

            return await state.AllowedActions();
        }

        public async Task<Model.Rezervacije> Insert(RezervacijaInsertRequest request)
        {
            var state = _baseState.CreateState("Initial");
            return await state.Insert(request);
        }

        public async Task<List<Model.Rezervacije>> GetByStudentIdAsync(int studentId)
        {
            var entity = _context.Rezervacijes.Where(x => x.StudentId == studentId)
                .Include(p=>p.SmjestajnaJedinica)
                .Include(p => p.SmjestajnaJedinica.Smjestaj)
                .Include(p => p.Student)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status).ToList();


            return _mapper.Map<List<Model.Rezervacije>>(entity);

        }
    }
}
