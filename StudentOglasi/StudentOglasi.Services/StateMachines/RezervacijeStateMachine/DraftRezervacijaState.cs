using AutoMapper;
using Microsoft.EntityFrameworkCore;
using RabbitMQ.Client;
using StudentOglasi.Model;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachines.RezervacijeStateMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.RezervacijeStateMachine
{
    public class DraftRezervacijaState : BaseRezervacijaState
    {
        public IMailService _service;
        public DraftRezervacijaState(IServiceProvider serviceProvider, IMailService service, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
            _service = service;
        }
        public override async Task<Model.Rezervacije> Approve(int studentId, int smjestajnaJedinicaId)
        {
            var set = _context.Set<Database.Rezervacije>().Include(p => p.Student.IdNavigation).Include(p => p.SmjestajnaJedinica);

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == studentId && e.SmjestajnaJedinicaId == smjestajnaJedinicaId);

            if (entity == null)
            {
                throw new Exception("Rezervacija nije pronađena.");
            }

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Odobrena"));

            await _context.SaveChangesAsync();
            var emailObj = new EmailObject
            {
                emailAdresa = entity.Student.IdNavigation.Email,
                tema = "Rezervacija smještaja: " + entity.SmjestajnaJedinica.Naziv,
                poruka = "Vaša rezervacija za " + entity.SmjestajnaJedinica.Naziv + " je prihvaćena/odobrena"
            };
            await _service.startConnection(emailObj);
            return _mapper.Map<Model.Rezervacije>(entity);
        }

        public override async Task<Model.Rezervacije> Cancel(int studentId, int smjestajnaJedinicaId)
        {
            var set = _context.Set<Database.Rezervacije>().Include(p => p.Student.IdNavigation).Include(p => p.SmjestajnaJedinica);

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == studentId && e.SmjestajnaJedinicaId == smjestajnaJedinicaId);

            if (entity == null)
            {
                throw new Exception("Rezervacija nije pronađena.");
            }

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Otkazana"));

            await _context.SaveChangesAsync();
            var emailObj = new EmailObject
            {
                emailAdresa = entity.Student.IdNavigation.Email,
                tema = "Rezervacija smještaja: " + entity.SmjestajnaJedinica.Naziv,
                poruka = "Vaša rezervacija za " + entity.SmjestajnaJedinica.Naziv + " je odbijena/otkazana."
            };
            await _service.startConnection(emailObj);
            return _mapper.Map<Model.Rezervacije>(entity);
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
