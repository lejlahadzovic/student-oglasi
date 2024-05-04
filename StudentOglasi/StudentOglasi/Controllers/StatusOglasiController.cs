using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class StatusOglasiController : BaseController<StatusOglasi, BaseSearchObject>
    {
        public StatusOglasiController(ILogger<BaseController<StatusOglasi, BaseSearchObject>> logger, IStatusOglasiService statusOglasiService) : base(logger, statusOglasiService)
        {

        }
    }
}
