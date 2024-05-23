using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class GradoviController : BaseController<Gradovi, BaseSearchObject>
    {
        public GradoviController(ILogger<BaseController<Gradovi, BaseSearchObject>> logger, IGradoviService gradoviService):base(logger, gradoviService)
        {
            
        }
    }
}
