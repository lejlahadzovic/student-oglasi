using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UniverzitetiController : BaseController<Univerziteti, BaseSearchObject>
    {
        public UniverzitetiController(ILogger<BaseController<Univerziteti, BaseSearchObject>> logger, IUniverzitetiService univerzitetiService):base(logger, univerzitetiService)
        {
            
        }
    }
}
