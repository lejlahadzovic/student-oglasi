using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.PrijavePrakseStateMachine
{
    public class DraftPrijavePraksaState : BasePrijavePrakseState
    {
        public DraftPrijavePraksaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
        public override async Task<Model.PrijavePraksa> Approve(int id)
        {
            var set = _context.Set<Database.PrijavePraksa>();

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == id);

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Odobrena"));

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.PrijavePraksa>(entity);
        }

        public override async Task<Model.PrijavePraksa> Cancel(int id)
        {
            var set = _context.Set<Database.PrijavePraksa>();

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == id);

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Otkazana"));

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.PrijavePraksa>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Approve");
            list.Add("Cancel");
            return list;
        }
    }
}
