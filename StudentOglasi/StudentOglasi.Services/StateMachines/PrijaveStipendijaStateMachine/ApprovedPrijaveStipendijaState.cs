using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine
{
    public class ApprovedPrijaveStipendijaState : BasePrijaveStipendijaState
    {
        public ApprovedPrijaveStipendijaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Model.PrijaveStipendija> Cancel(int studentId, int stipendijaId)
        {
            var set = _context.Set<Database.PrijaveStipendija>();

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == studentId && e.StipendijaId == stipendijaId);

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Otkazana"));

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.PrijaveStipendija>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Cancel");
            return list;
        }
    }
}
