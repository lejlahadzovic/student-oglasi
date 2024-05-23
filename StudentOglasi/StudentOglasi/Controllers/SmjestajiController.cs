using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class SmjestajiController : BaseCRUDController<Smjestaji, SmjestajiSearchObject, SmjestajiInsertRequest, SmjestajiUpdateRequest>
    {
        public SmjestajiController(ILogger<BaseCRUDController<Smjestaji, SmjestajiSearchObject, SmjestajiInsertRequest, SmjestajiUpdateRequest>> logger, ISmjestajiService smjestajiService)
            :base(logger, smjestajiService)
        {

        }
    }
    
}
