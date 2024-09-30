using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.Services.Users;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;
using System.Security.Claims;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]
    public class StudentiController : BaseCRUDController<Studenti, StudentiSearchObject, StudentiInsertRequest,StudentiUpdateRequest>
    {
        private readonly IStudentiService _studentiService;
        public StudentiController(ILogger<BaseCRUDController<Studenti, StudentiSearchObject, StudentiInsertRequest, StudentiUpdateRequest>> logger, IStudentiService service):base(logger, service) 
        {
            _studentiService = service;
        }

        [AllowAnonymous]
        public override Task<IActionResult> Insert([FromForm] StudentiInsertRequest insert)
        {
            return base.Insert(insert);
        }
        public override Task<IActionResult> Update(int id, [FromForm] StudentiUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [HttpGet("currentStudent")]
        public async Task<IActionResult> GetLoggedInStudent()
        {
            var username = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(username))
            {
                return Unauthorized();
            }

            var student = await _studentiService.GetStudentByUsername(username);
            if (student == null)
            {
                return NotFound();
            }

            return Ok(student);
        }

        [HttpPut("{id}/change-password")]
        public async Task<IActionResult> ChangePassword(int id, [FromBody] ChangePasswordRequest request)
        {
            var result = await _studentiService.ChangePassword(id, request);
            if (!result)
            {
                return BadRequest(new { message = "Password change failed. Please check your current password and try again." });
            }
            return Ok(new { message = "Password changed successfully." });
        }

        [AllowAnonymous]
        [HttpGet("check-username/{username}")]
        public async Task<IActionResult> CheckUsername(string username)
        {
            var isUsernameTaken = await _studentiService.IsUsernameTaken(username);

            if (isUsernameTaken)
            {
                return BadRequest(new { message = "Korisničko ime je zauzeto." });
            }

            return Ok(new { message = "Korisničko ime je dostupno." });
        }
    }
}
