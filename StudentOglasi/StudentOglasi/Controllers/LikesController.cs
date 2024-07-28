using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.Services;
using System.Security.Claims;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class LikesController : ControllerBase
    {
        private readonly ILikeService _likeService;
        public LikesController(ILikeService likeService)
        {
            _likeService = likeService;
        }

        [HttpPost]
        public async Task<IActionResult> LikeItem([FromBody] Like likeRequest)
        {
            var like = await _likeService.LikeItem(likeRequest);
            return Ok(like);
        }

        [HttpDelete]
        public async Task<IActionResult> UnlikeItem([FromBody] Like likeDto)
        {
            await _likeService.UnlikeItem(likeDto);
            return Ok();
        }

        [HttpGet("userLikes")]
        public async Task<IActionResult> GetUserLikes()
        {
            var username = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(username))
            {
                return Unauthorized();
            }

            var likes = await _likeService.GetUserLikes(username);
            return Ok(likes);
        }

        [HttpGet("allLikesCount")]
        public async Task<IActionResult> GetAllLikesCount()
        {
            var likesCount = await _likeService.GetAllLikesCount();
            return Ok(likesCount);
        }
    }
}
