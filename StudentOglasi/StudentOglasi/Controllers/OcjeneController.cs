using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.Services;
using System.Security.Claims;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class OcjeneController : ControllerBase
    {
        private readonly IOcjeneService _ocjeneService;
        public OcjeneController(IOcjeneService ocjeneService)
        {
            _ocjeneService = ocjeneService;
        }

        [HttpPost]
        public async Task<IActionResult> InsertOcjena([FromBody] Model.Ocjene request)
        {
            var insertedOcjena = await _ocjeneService.Insert(request);

            return insertedOcjena != null ? Ok(insertedOcjena) : BadRequest("Failed to insert ocjena");
        }

        [HttpGet("{postId}/{postType}")]
        public async Task<IActionResult> GetAverageOcjena(int postId, string postType)
        {
            var average = await _ocjeneService.GetAverageOcjena(postId, postType);
            return Ok(average);
        }

        [HttpGet("average/{postType}")]
        public async Task<IActionResult> GetAverageOcjenaByPostType(string postType)
        {
            var averages = await _ocjeneService.GetAverageOcjenaByPostType(postType);
            return Ok(averages);
        }

        [HttpGet("{postId}/{postType}/{studentId}")]
        public async Task<IActionResult> GetUserOcjena(int postId, string postType, int studentId)
        {
            var ocjena = await _ocjeneService.GetUserOcjena(postId, postType, studentId);
            return Ok(ocjena);
        }
    }
}
