using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class StatusPrijaveController : BaseController<StatusPrijave, BaseSearchObject>
    {
        public StatusPrijaveController(ILogger<BaseController<StatusPrijave, BaseSearchObject>> logger, IStatusPrijaveService statusPrijaveService) : base(logger, statusPrijaveService)
        {

        }
    }
}
