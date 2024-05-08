using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.OglasiStateMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachine.StipendijeStateMachine
{
    public class InitialStipendijeState : BaseStipendijeState
    {
        public InitialStipendijeState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
        public override async Task<Model.Stipendije> Insert(StipendijeInsertRequest request)
        {
            var set = _context.Set<Database.Stipendije>();

            var entity = _mapper.Map<Database.Stipendije>(request);

            entity.Status = await _context.StatusOglasis.FirstOrDefaultAsync(e => e.Naziv.Contains("Draft"));
            entity.StatusId = entity.Status.Id;
            set.Add(entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Stipendije>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Insert");
            return list;
        }
    }
}