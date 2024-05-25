using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine
{
    public class CanceledPrijaveStipendijaState : BasePrijaveStipendijaState
    {
        public CanceledPrijaveStipendijaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
        public override async Task<Model.PrijaveStipendija> Approve(int id)
        {
            var set = _context.Set<Database.PrijaveStipendija>();

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == id);

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Odobrena"));

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.PrijaveStipendija>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Approve");
            return list;
        }
    }
}
