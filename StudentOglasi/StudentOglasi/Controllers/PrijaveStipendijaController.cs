using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PrijaveStipendijaController : BaseController<PrijaveStipendija, PrijaveStipendijaSearchObject>
    {
        public PrijaveStipendijaController(ILogger<BaseController<PrijaveStipendija, PrijaveStipendijaSearchObject>> logger, IPrijaveStipendijaService prijaveStipendijaService) : base(logger, prijaveStipendijaService)
        {

        }
    }
}
