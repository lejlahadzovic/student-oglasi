using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TipSmjestajaController : BaseController<TipSmjestaja, BaseSearchObject>
    {
        public TipSmjestajaController(ILogger<BaseController<TipSmjestaja, BaseSearchObject>> logger, ITipSmjestajaService tipSmjestajaService):base(logger, tipSmjestajaService)
        {
            
        }
    }
}
