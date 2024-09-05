using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]

    public class ObavijestiController : BaseController<Obavijesti, BaseSearchObject>
    {
        public ObavijestiController(ILogger<BaseController<Obavijesti, BaseSearchObject>> logger, IObavijestiService obavijestiService) : base(logger, obavijestiService)
        {
        }
    }
}
