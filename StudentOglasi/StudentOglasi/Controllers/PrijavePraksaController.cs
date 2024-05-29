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
        [HttpPut("{studentId}/{praksaId}/approve")]
        public virtual async Task<Model.PrijavePraksa> Approve(int studentId, int praksaId)
        {
            return await (_service as IPrijavePraksaService).Approve(studentId, praksaId);
        }

        [HttpPut("{studentId}/{praksaId}/cancel")]
        public virtual async Task<Model.PrijavePraksa> Cancel(int studentId, int praksaId)
        {
            return await (_service as IPrijavePraksaService).Cancel(studentId, praksaId);
        }

        [HttpGet("{studentId}/{praksaId}/allowedActions")]
        public async Task<List<string>> AllowedActions(int studentId, int praksaId)
        {
            return await (_service as IPrijavePraksaService).AllowedActions(studentId, praksaId);
        }
    }
}
