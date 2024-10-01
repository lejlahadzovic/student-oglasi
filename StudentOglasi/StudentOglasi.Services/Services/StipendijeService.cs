using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.OglasiStateMachine;

namespace StudentOglasi.Services.Services
{
    public class StipendijeService : BaseCRUDService<Model.Stipendije, Database.Stipendije, StipendijeSearchObject, StipendijeInsertRequest, StipendijeUpdateRequest>, IStipendijeService
    {
        private readonly RecommenderSystem _recommenderSystem;
        public readonly FileService _fileService;
        public BaseStipendijeState _baseState { get; set; }
        public StipendijeService(StudentoglasiContext context, IMapper mapper, FileService fileService, RecommenderSystem recommenderSystem, BaseStipendijeState baseState) : base(context, mapper)
        {
            _recommenderSystem = recommenderSystem;
            _fileService = fileService;
            _baseState = baseState;
        }
        public override Task<Model.Stipendije> Insert(StipendijeInsertRequest insert)
        {
            var state = _baseState.CreateState("Initial");
            return state.Insert(insert);
        }
        public override IQueryable<Database.Stipendije> AddFilter(IQueryable<Database.Stipendije> query, StipendijeSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naslov))
            {
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.Naslov.Contains(search.Naslov));
            }
            if (search?.Stipenditor != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Stipenditor.Id == search.Stipenditor);
            }
            return filteredQuery;
        }
        public override async Task<PagedResult<Model.Stipendije>> Get(StipendijeSearchObject? search = null)
        {
            var query = _context.Set<Database.Stipendije>().Include(p => p.IdNavigation).Include(p => p.Status).Include(p=>p.Stipenditor).AsQueryable();

            PagedResult<Model.Stipendije> result = new PagedResult<Model.Stipendije>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Model.Stipendije>>(list);
            result.Result = tmp;
            return result;
        }
        public override async Task<Model.Stipendije> GetById(int id)
        {
            var entity = await _context.Set<Database.Stipendije>().Include(p => p.Stipenditor).Include(p => p.Status).FirstOrDefaultAsync(p => p.Id == id);

            return _mapper.Map<Model.Stipendije>(entity);
        }
        public override async Task<Model.Stipendije> Update(int id, StipendijeUpdateRequest update)
        {
            var set = _context.Set<Database.Stipendije>();

            var entity = await set.Include(p => p.IdNavigation).FirstOrDefaultAsync(e => e.Id == id);
            entity.Status = await _context.StatusOglasis.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Update(id, update);
        }
        public override async Task Delete(int id)
        {
            var query = _context.Set<Database.Stipendije>().Include(s => s.IdNavigation);
            var entity = await query.FirstOrDefaultAsync(s => s.Id == id);

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

            _context.Stipendijes.Remove(entity);
            await _context.SaveChangesAsync();
        }
        public async Task<Model.Stipendije> Activate(int id)
        {
            var set = _context.Set<Database.Stipendije>();

            var entity = await set.FindAsync(id);
            entity.Status = await _context.StatusOglasis.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Activate(id);
        }
        public async Task<Model.Stipendije> Hide(int id)
        {
            var set = _context.Set<Database.Stipendije>();

            var entity = await set.FindAsync(id);
            entity.Status = await _context.StatusOglasis.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Hide(id);
        }
        public async Task<List<string>> AllowedActions(int id)
        {
            var set = _context.Set<Database.Stipendije>();

            var entity = await set.FindAsync(id);
            entity.Status = await _context.StatusOglasis.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv ?? "Initial");
            return await state.AllowedActions();
        }
        public async Task<List<Model.Stipendije>> GetRecommendedStipendije(int studentId)
        {
            var recommendedPostIds = await _recommenderSystem.GetRecommendedPostIds(studentId, "scholarship");

            var recommendedStipendije = await _context.Stipendijes
                .Include(p => p.IdNavigation)
                .Where(p => recommendedPostIds.Contains(p.Id))
                .ToListAsync();

            return _mapper.Map<List<Model.Stipendije>>(recommendedStipendije);
        }
    }
}