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
    public class SmjestajiController : BaseCRUDController<Smjestaji, SmjestajiSearchObject, SmjestajiInsertRequest, SmjestajiUpdateRequest>
    {
        public SmjestajiController(ILogger<BaseCRUDController<Smjestaji, SmjestajiSearchObject, SmjestajiInsertRequest, SmjestajiUpdateRequest>> logger, ISmjestajiService smjestajiService)
            :base(logger, smjestajiService)
        {

        }

        [HttpGet("recommendations/{studentId}")]
        public async Task<IActionResult> GetRecommendations(int studentId)
        {
            var smjestaji = await (_service as ISmjestajiService).GetRecommendedSmjestaji(studentId);

            if (smjestaji == null || !smjestaji.Any())
            {
                return NotFound("No recommendations available.");
            }

            return Ok(smjestaji);
        }

    }

}
