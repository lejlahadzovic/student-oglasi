using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class StudentiController : BaseCRUDController<Studenti, StudentiSearchObject, StudentiInsertRequest,StudentiUpdateRequest>
    {
        public StudentiController(ILogger<BaseCRUDController<Studenti, StudentiSearchObject, StudentiInsertRequest, StudentiUpdateRequest>> logger, IStudentiService service):base(logger, service) 
        { 
        }

        public override Task<IActionResult> Insert([FromForm] StudentiInsertRequest insert)
        {
            return base.Insert(insert);
        }

        public override Task<IActionResult> Update(int id, [FromForm] StudentiUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
