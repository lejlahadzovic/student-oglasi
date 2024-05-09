using AutoMapper;
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
        public BasePrakseState _baseState { get; set; }
        public PrakseService(StudentoglasiContext context, IMapper mapper, BasePrakseState baseState) : base(context, mapper)
        {
            _baseState = baseState;
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
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.Naslov.Contains(search.Naslov) || x.Organizacija.Naziv.Contains(search.Organizacija));
            }
            if (!string.IsNullOrWhiteSpace(search?.Organizacija))
            {
                filteredQuery = filteredQuery.Where(x => x.Organizacija.Naziv.Contains(search.Organizacija));
            }
            if (!string.IsNullOrWhiteSpace(search?.Status))
            {
                filteredQuery = filteredQuery.Where(x => x.Status.Naziv.Contains(search.Status));
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