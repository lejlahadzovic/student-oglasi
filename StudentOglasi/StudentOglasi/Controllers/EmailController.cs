using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class EmailController : ControllerBase
    {
        public IMailService _service;
        public EmailController(IMailService service)
        {
            _service = service;

        }
        [HttpPost]
        public async Task sendMail([FromBody] EmailObject obj)
        {
            await _service.startConnection(obj);
        }
    }
}