using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class StipendijeController : BaseCRUDController<Stipendije, StipendijeSearchObject, StipendijeInsertRequest, StipendijeUpdateRequest>
    {
        public StipendijeController(ILogger<BaseCRUDController<Stipendije, StipendijeSearchObject, StipendijeInsertRequest, StipendijeUpdateRequest>> logger, IStipendijeService stipendijeService)
            :base(logger, stipendijeService)
        {

        }

        public override Task<IActionResult> Insert([FromForm] StipendijeInsertRequest insert)
        {
            return base.Insert(insert);
        }
        public override Task<IActionResult> Update(int id, [FromForm] StipendijeUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [HttpPut("{id}/hide")]
        public virtual async Task<Model.Stipendije> Hide(int id)
        {
            return await (_service as IStipendijeService).Hide(id);
        }

        [HttpGet("{id}/allowedActions")]
        public async Task<List<string>> AllowedActions(int id)
        {
            return await (_service as IStipendijeService).AllowedActions(id);
        }

        [HttpGet("recommendations/{studentId}")]
        public async Task<IActionResult> GetRecommendations(int studentId)
        {
            var stipendije = await (_service as IStipendijeService).GetRecommendedStipendije(studentId);

            if (stipendije == null || !stipendije.Any())
            {
                return NotFound("No recommendations available.");
            }

            return Ok(stipendije);
        }

    }

}
