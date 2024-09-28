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
    public class DraftPrijaveStipendijaState : BasePrijaveStipendijaState
    {
        public IMailService _service;
        public DraftPrijaveStipendijaState(IServiceProvider serviceProvider, IMailService service, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
            _service = service;
        }
        public override async Task<Model.PrijaveStipendija> Approve(int studentId, int stipendijaId)
        {
            var set = _context.Set<Database.PrijaveStipendija>().Include(p => p.Student.IdNavigation).Include(p=>p.Stipendija.IdNavigation);

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == studentId && e.StipendijaId == stipendijaId);

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Odobrena"));

            await _context.SaveChangesAsync();
            var emailObj = new EmailObject
            {
                emailAdresa = entity.Student.IdNavigation.Email,
                tema = "Prijava na stipendiju: " + entity.Stipendija.IdNavigation.Naslov,
                poruka = "Vaša prijava na stipendiju: " + entity.Stipendija.IdNavigation.Naslov+ " je odobrena/prihvaćena"
            };
            await _service.startConnection(emailObj);
            return _mapper.Map<Model.PrijaveStipendija>(entity);
        }

        public override async Task<Model.PrijaveStipendija> Cancel(int studentId, int stipendijaId)
        {
            var set = _context.Set<Database.PrijaveStipendija>().Include(p => p.Student.IdNavigation).Include(p => p.Stipendija.IdNavigation);

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == studentId && e.StipendijaId == stipendijaId);

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Otkazana"));

            await _context.SaveChangesAsync();
            var emailObj = new EmailObject
            {
                emailAdresa = entity.Student.IdNavigation.Email,
                tema = "Prijava na stipendiju: " + entity.Stipendija.IdNavigation.Naslov,
                poruka = "Vaša prijava na stipendiju: " + entity.Stipendija.IdNavigation.Naslov + " je odbijena/otkazana"
            };
            await _service.startConnection(emailObj);
            return _mapper.Map<Model.PrijaveStipendija>(entity);
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
