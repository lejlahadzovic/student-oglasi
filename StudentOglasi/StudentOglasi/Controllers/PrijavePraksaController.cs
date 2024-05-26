using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PrijavePraksaController : BaseController<PrijavePraksa, PrijavePraksaSearchObject>
    {
        public PrijavePraksaController(ILogger<BaseController<PrijavePraksa, PrijavePraksaSearchObject>> logger, IPrijavePraksaService prijavePraksaService) : base(logger, prijavePraksaService)
        {

        }
        [HttpPut("{studentId}/approve")]
        public virtual async Task<Model.PrijavePraksa> Approve(int studentId)
        {
            return await (_service as IPrijavePraksaService).Approve(studentId);
        }

        [HttpPut("{studentId}/cancel")]
        public virtual async Task<Model.PrijavePraksa> Cancel(int studentId)
        {
            return await (_service as IPrijavePraksaService).Cancel(studentId);
        }

        [HttpGet("{studentId}/allowedActions")]
        public async Task<List<string>> AllowedActions(int studentId)
        {
            return await (_service as IPrijavePraksaService).AllowedActions(studentId);
        }
    }
}
