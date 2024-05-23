using AutoMapper;
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
    public class SlikeController : ControllerBase
    {
        private readonly ISlikeService _slikeService;
        private readonly ILogger<SlikeController> _logger;

        public SlikeController(ISlikeService slikeService, ILogger<SlikeController> logger)
        {
            _slikeService = slikeService;
            _logger = logger;
        }

        [HttpPost]
        public async Task<IActionResult> UploadImage([FromForm] SlikeInsertRequest request)
        {
            try
            {
                var result = await _slikeService.Upload(request);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);
            }
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteImage(int id)
        {
            try
            {
                var success = await _slikeService.Delete(id);
                if (success)
                    return Ok($"Slika sa ID {id} je uspješno obrisana.");
                else
                    return NotFound($"Slika sa ID {id} nije pronađena.");
            }
            catch (Exception ex)
            {
                throw new Exception("Došlo je do greške prilikom obrade zahtjeva.", ex);
            }
        }
    }
}
