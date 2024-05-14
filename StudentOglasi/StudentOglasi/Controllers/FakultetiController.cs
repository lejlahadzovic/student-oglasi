using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class FakultetiController : BaseController<Fakulteti, BaseSearchObject>
    {
        public FakultetiController(ILogger<BaseController<Fakulteti, BaseSearchObject>> logger, IFakultetiService fakultetiService):base(logger, fakultetiService)
        {
            
        }
    }
}
