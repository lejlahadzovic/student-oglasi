using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.OglasiStateMachine;

namespace StudentOglasi.Services.StateMachine.StipendijeStateMachine
{
    public class InactiveStipendijeState : BaseStipendijeState
    {
        public InactiveStipendijeState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Model.Stipendije> Hide(int id)
        {
            var set = _context.Set<Database.Stipendije>();

            var entity = await set.Include(p => p.IdNavigation).FirstOrDefaultAsync(e => e.Id == id);

            entity.Status = await _context.StatusOglasis.FirstOrDefaultAsync(e => e.Naziv.Contains("Skica"));

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Stipendije>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Hide");
            return list;
        }
    }
}
