using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PrijavePraksaController : BaseController<PrijavePraksa, PrijavePraksaSearchObject>
    {
        public PrijavePraksaController(ILogger<BaseController<PrijavePraksa, PrijavePraksaSearchObject>> logger, IPrijavePraksaService prijavePraksaService) : base(logger, prijavePraksaService)
        {

        }
    }
}
