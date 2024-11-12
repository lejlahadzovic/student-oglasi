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
            var state = _baseState.CreateState("Kreiran");
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
        public override IQueryable<Database.Stipendije> AddInclude(IQueryable<Database.Stipendije> query, StipendijeSearchObject? search = null)
        {
            query = query.Include(p => p.IdNavigation).Include(p => p.Status).Include(p => p.Stipenditor).AsQueryable();

            return base.AddInclude(query, search);
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

            if (!entity.Status.Naziv.Contains("Skica"))
            {
                await state.Hide(id);

                state = _baseState.CreateState(entity.Status.Naziv);
                return await state.Update(id, update);
            }

            return await state.Update(id, update);
        }
        public override async Task Delete(int id)
        {
            var query = _context.Set<Database.Stipendije>().Include(s => s.IdNavigation);
            var entity = await query.FirstOrDefaultAsync(s => s.Id == id);

            if (entity == null)
                throw new Exception("Objekat nije pronađen");

            var oglasi = entity.IdNavigation;
            if (oglasi != null)
            {
                var relatedObavijesti = _context.Obavijestis.Where(o => o.OglasiId == oglasi.Id);
                _context.Obavijestis.RemoveRange(relatedObavijesti);

                _context.Oglasis.Remove(oglasi);
            }

            _context.Stipendijes.Remove(entity);
            await _context.SaveChangesAsync();
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
            var state = _baseState.CreateState(entity.Status.Naziv ?? "Kreiran");
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