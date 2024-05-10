using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class StipenditoriController : BaseController<Stipenditori, BaseSearchObject>
    {
        public StipenditoriController(ILogger<BaseController<Stipenditori, BaseSearchObject>> logger, IStipenditoriService stipenditoriService) : base(logger, stipenditoriService)
        {

        }
    }
}
