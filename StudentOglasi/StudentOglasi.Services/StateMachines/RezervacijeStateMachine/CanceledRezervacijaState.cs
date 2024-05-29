using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachines.RezervacijeStateMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.RezervacijeStateMachine
{
    public class CanceledRezervacijaState : BaseRezervacijaState
    {
        public CanceledRezervacijaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
        public override async Task<Model.Rezervacije> Approve(int studentId, int smjestajnaJedinicaId)
        {
            var set = _context.Set<Database.Rezervacije>();

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == studentId && e.SmjestajnaJedinicaId == smjestajnaJedinicaId);

            if (entity == null)
            {
                throw new Exception("Rezervacija nije pronađena.");
            }

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Odobrena"));

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Rezervacije>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Approve");
            return list;
        }
    }
}
