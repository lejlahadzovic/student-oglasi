using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.Services;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PrijaveStipendijaController : BaseCRUDController<PrijaveStipendija, PrijaveStipendijaSearchObject,PrijaveStipendijaInsertRequest,PrijaveStipendijaUpdateRequest>
    {
        private readonly IPrijaveStipendijaService _prijaveStipendijeService;
        public PrijaveStipendijaController(ILogger<BaseController<PrijaveStipendija, PrijaveStipendijaSearchObject>> logger, IPrijaveStipendijaService prijaveStipendijaService) : base(logger, prijaveStipendijaService)
        {
            _prijaveStipendijeService = prijaveStipendijaService;
        }

        public override Task<IActionResult> Insert([FromForm] PrijaveStipendijaInsertRequest insert)
        {
            return base.Insert(insert);
        }
        public override Task<IActionResult> Update(int id, [FromForm] PrijaveStipendijaUpdateRequest update)
        {
            return base.Update(id, update);
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

        [HttpGet("student/{studentId}")]
        public async Task<List<PrijaveStipendija>> GetByStudentId(int studentId)
        {
            return await (_service as IPrijaveStipendijaService).GetByStudentIdAsync(studentId);
        }
    }
}
