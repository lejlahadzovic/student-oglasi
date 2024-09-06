using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.RezervacijeStateMachine
{
    public class InitialRezervacijaState : BaseRezervacijaState
    {
        public InitialRezervacijaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Model.Rezervacije> Insert(RezervacijaInsertRequest request)
        {
            var entity = new Database.Rezervacije
            {
                StudentId = request.StudentId,
                SmjestajnaJedinicaId = request.SmjestajnaJedinicaId,
                DatumPrijave = request.DatumPrijave,
                DatumOdjave = request.DatumOdjave,
                BrojOsoba= request.BrojOsoba,
                Napomena=request.Napomena,
                Cijena=request.Cijena
            };

            var onHoldStatus = await _context.StatusPrijaves
                .Where(x => x.Naziv == "Na cekanju")
                .Select(x => x.Id)
                .FirstOrDefaultAsync();

            entity.StatusId = onHoldStatus;

            _context.Rezervacijes.Add(entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Rezervacije>(entity);
        }
    }
}
