using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
  
    public class OglasiController : BaseController<Oglasi, BaseSearchObject>
    {
        public OglasiController(ILogger<BaseController<Oglasi, BaseSearchObject>> logger, IOglasiService oglasiService) : base(logger, oglasiService)
        {

        }
    }
}
