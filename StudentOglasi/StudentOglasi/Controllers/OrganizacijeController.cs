using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class OrganizacijeController : BaseController<Organizacije, BaseSearchObject>
    {
        public OrganizacijeController(ILogger<BaseController<Organizacije, BaseSearchObject>> logger, IOrganizacijeService organizacijeService):base(logger, organizacijeService)
        {
            
        }
    }
}
