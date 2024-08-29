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
using StudentOglasi.Services.StateMachines.PrakseStateMachine;
using StudentOglasi.Services.StateMachines.PrijavePrakseStateMachine;
using System.Drawing.Printing;
using PrijavePraksa = StudentOglasi.Model.PrijavePraksa;
using Microsoft.VisualStudio.Services.Identity;

namespace StudentOglasi.Services.Services
{
    public class PrijavePraksaService : BaseCRUDService<Model.PrijavePraksa, Database.PrijavePraksa, PrijavePraksaSearchObject, PrijavePrakseInsertRequest, PrijavePrakseUpdateRequest>, IPrijavePraksaService
    {
        public BasePrijavePrakseState _baseState { get; set; }
        public PrijavePraksaService(StudentoglasiContext context, IMapper mapper, BasePrijavePrakseState baseState) : base(context, mapper)
        {
            _baseState = baseState;
        }
        public override Task<Model.PrijavePraksa> Insert(PrijavePrakseInsertRequest insert)
        {
            var state = _baseState.CreateState("Initial");
            return state.Insert(insert);
        }
        public async Task<List<PrijavePraksa>> GetByStudentIdAsync(int studentId)
        {
            var entity =await _context.PrijavePraksas.Where(x => x.StudentId == studentId)
                .Include(p=>p.Praksa)
                .Include(p => p.Praksa.IdNavigation)
                .Include(p => p.Praksa.Organizacija)
                .Include(p => p.Praksa.Status)
                .Include(p=>p.Student)
                .Include(p=>p.Student.Fakultet)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status).ToListAsync();

            return _mapper.Map<List<Model.PrijavePraksa>>(entity);
           
        }
        public override IQueryable<Database.PrijavePraksa> AddFilter(IQueryable<Database.PrijavePraksa> query, PrijavePraksaSearchObject? search = null)
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
            if (search?.Praksa != null)
            {
                filteredQuery = filteredQuery.Where(x => x.PraksaId == search.Praksa);
            }

            return filteredQuery;
        }
        public override async Task<PagedResult<Model.PrijavePraksa>> Get(PrijavePraksaSearchObject? search = null)
        {
            var query = _context.Set<Database.PrijavePraksa>()
                .Include(p => p.Praksa)
                .Include(p=>p.Praksa.IdNavigation)
                .Include(p => p.Student)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status).AsQueryable();

            PagedResult<Model.PrijavePraksa> result = new PagedResult<Model.PrijavePraksa>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Model.PrijavePraksa>>(list);
            result.Result = tmp;
            return result;
        }
        public async Task<Model.PrijavePraksa> Cancel(int studentId, int praksaId)
        {
            var set = _context.Set<Database.PrijavePraksa>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.PraksaId == praksaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Cancel(studentId, praksaId);
        }

        public async Task<Model.PrijavePraksa> Approve(int studentId, int praksaId)
        {
            var set = _context.Set<Database.PrijavePraksa>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.PraksaId == praksaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Approve(studentId, praksaId);
        }
        public async Task<List<string>> AllowedActions(int studentId, int praksaId)
        {
            var set = _context.Set<Database.PrijavePraksa>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.PraksaId == praksaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv ?? "Na cekanju");
            return await state.AllowedActions();
        }


    }
}
