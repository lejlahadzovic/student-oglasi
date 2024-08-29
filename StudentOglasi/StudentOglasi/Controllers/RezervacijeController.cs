using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class RezervacijeController : BaseController<Rezervacije, RezervacijeSearchObject>
    {
        public RezervacijeController(ILogger<BaseController<Rezervacije, RezervacijeSearchObject>> logger, IRezervacijeService rezervacijeService) : base(logger, rezervacijeService)
        {

        }

        [HttpPut("{studentId}/{smjestajnaJedinicaId}/approve")]
        public virtual async Task<Model.Rezervacije> Approve(int studentId, int smjestajnaJedinicaId)
        {
            return await (_service as IRezervacijeService).Approve(studentId, smjestajnaJedinicaId);
        }

        [HttpPut("{studentId}/{smjestajnaJedinicaId}/cancel")]
        public virtual async Task<Model.Rezervacije> Cancel(int studentId, int smjestajnaJedinicaId)
        {
            return await (_service as IRezervacijeService).Cancel(studentId, smjestajnaJedinicaId);
        }

        [HttpGet("{studentId}/{smjestajnaJedinicaId}/allowedActions")]
        public async Task<List<string>> AllowedActions(int studentId, int smjestajnaJedinicaId)
        {
            return await (_service as IRezervacijeService).AllowedActions(studentId, smjestajnaJedinicaId);
        }

        [HttpGet("student/{studentId}")]
        public async Task<List<Rezervacije>> GetByStudentId(int studentId)
        {
            return await (_service as IRezervacijeService).GetByStudentIdAsync(studentId);
        }
    }
}
