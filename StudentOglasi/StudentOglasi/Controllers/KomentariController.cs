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
    public class KomentariController : ControllerBase
    {
        private readonly IKomentariService _komentariService;
        public KomentariController(IKomentariService komentariService)
        {
            _komentariService = komentariService;
        }

        [HttpPost]
        public async Task<IActionResult> InsertComment(KomentarInsertRequest insert)
        {
            var komentar = await _komentariService.Insert(insert);
            return Ok(komentar);
        }

        [HttpGet("{postId}/{postType}")]
        public async Task<ActionResult<List<Model.Komentari>>> GetCommentsByPost(int postId, string postType)
        {
            var comments = await _komentariService.GetCommentsByPost(postId, postType);
            return Ok(comments);
        }
    }
}
