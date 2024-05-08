using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;

namespace StudentOglasi.Services.StateMachines.PrakseStateMachine
{
    public class InitialPraksaState : BasePrakseState
    {
        public InitialPraksaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
        public override async Task<Model.Prakse> Insert(PrakseInsertRequest request)
        {
            var set = _context.Set<Prakse>();

            var entity = _mapper.Map<Prakse>(request);

            entity.Status = await _context.StatusOglasis.FirstOrDefaultAsync(e => e.Naziv.Contains("Draft"));
            entity.StatusId = entity.Status.Id;
            set.Add(entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Prakse>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Insert");
            return list;
        }
    }
}