using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.Services;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PrijavePraksaController : BaseCRUDController<PrijavePraksa, PrijavePraksaSearchObject,PrijavePrakseInsertRequest,PrijavePrakseUpdateRequest>
    {
        private readonly IPrijavePraksaService _prijavePraksaService;

        public PrijavePraksaController(ILogger<BaseController<PrijavePraksa, PrijavePraksaSearchObject>> logger, IPrijavePraksaService prijavePraksaService) : base(logger, prijavePraksaService)
        {
            _prijavePraksaService = prijavePraksaService;

        }
        public override Task<IActionResult> Insert([FromForm] PrijavePrakseInsertRequest insert)
        {
            return base.Insert(insert);
        }
        public override Task<IActionResult> Update(int id, [FromForm] PrijavePrakseUpdateRequest update)
        {
            return base.Update(id, update);
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

        [HttpGet("student/{studentId}")]
        public async Task<List<PrijavePraksa>> GetByStudentId(int studentId)
        {
            return await (_service as IPrijavePraksaService).GetByStudentIdAsync(studentId);
        }
    }
}
