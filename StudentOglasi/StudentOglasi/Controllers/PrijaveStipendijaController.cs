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
        [HttpPut("{studentId}/approve")]
        public virtual async Task<Model.PrijaveStipendija> Approve(int studentId)
        {
            return await (_service as IPrijaveStipendijaService).Approve(studentId);
        }

        [HttpPut("{studentId}/cancel")]
        public virtual async Task<Model.PrijaveStipendija> Cancel(int studentId)
        {
            return await (_service as IPrijaveStipendijaService).Cancel(studentId);
        }

        [HttpGet("{studentId}/allowedActions")]
        public async Task<List<string>> AllowedActions(int studentId)
        {
            return await (_service as IPrijaveStipendijaService).AllowedActions(studentId);
        }
    }
}
