using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.PrijavePrakseStateMachine
{
    public class ApprovedPrijavePraksaState : BasePrijavePrakseState
    {
        public IMailService _service;
        public ApprovedPrijavePraksaState(IServiceProvider serviceProvider, IMailService service, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
            _service = service;
        }

        public override async Task<Model.PrijavePraksa> Cancel(int studentId, int praksaId)
        { 
            var set = _context.Set<Database.PrijavePraksa>().Include(p => p.Student.IdNavigation).Include(p => p.Praksa.IdNavigation);

            var entity = await set.FirstOrDefaultAsync(e => e.StudentId == studentId && e.PraksaId == praksaId);

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Otkazana"));

            await _context.SaveChangesAsync();
            var emailObj = new EmailObject
            {
                emailAdresa = entity.Student.IdNavigation.Email,
                tema = "Prijava na praksu: " + entity.Praksa.IdNavigation.Naslov,
                poruka = "Vaša prijava na praksu: " + entity.Praksa.IdNavigation.Naslov + " je odbijena/otkazana"
            };
            await _service.startConnection(emailObj);
            return _mapper.Map<Model.PrijavePraksa>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Cancel");
            return list;
        }
    }
}
