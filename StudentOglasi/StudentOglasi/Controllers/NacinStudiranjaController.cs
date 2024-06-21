using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [AllowAnonymous]
    public class NacinStudiranjaController : BaseController<NacinStudiranja, BaseSearchObject>
    {
        public NacinStudiranjaController(ILogger<BaseController<NacinStudiranja, BaseSearchObject>> logger, INacinStudiranjaService nacinStudiranjaService):base(logger, nacinStudiranjaService)
        {
            
        }
    }
}
