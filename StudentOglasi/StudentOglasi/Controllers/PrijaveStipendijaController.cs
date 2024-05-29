using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PrijaveStipendijaController : BaseController<PrijaveStipendija, PrijaveStipendijaSearchObject>
    {
        public PrijaveStipendijaController(ILogger<BaseController<PrijaveStipendija, PrijaveStipendijaSearchObject>> logger, IPrijaveStipendijaService prijaveStipendijaService) : base(logger, prijaveStipendijaService)
        {

        }
        [HttpPut("{studentId}/{stipendijaId}/approve")]
        public virtual async Task<Model.PrijaveStipendija> Approve(int studentId, int stipendijaId)
        {
            return await (_service as IPrijaveStipendijaService).Approve(studentId, stipendijaId);
        }

        [HttpPut("{studentId}/{stipendijaId}/cancel")]
        public virtual async Task<Model.PrijaveStipendija> Cancel(int studentId, int stipendijaId)
        {
            return await (_service as IPrijaveStipendijaService).Cancel(studentId, stipendijaId);
        }

        [HttpGet("{studentId}/{stipendijaId}/allowedActions")]
        public async Task<List<string>> AllowedActions(int studentId, int stipendijaId)
        {
            return await (_service as IPrijaveStipendijaService).AllowedActions(studentId, stipendijaId);
        }
    }
}
