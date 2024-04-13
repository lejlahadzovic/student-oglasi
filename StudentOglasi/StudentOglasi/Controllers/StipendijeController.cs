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
    public class StipendijeController : BaseCRUDController<Stipendije, StipendijeSearchObject, StipendijeInsertRequest, StipendijeUpdateRequest>
    {
        public StipendijeController(ILogger<BaseCRUDController<Stipendije, StipendijeSearchObject, StipendijeInsertRequest, StipendijeUpdateRequest>> logger, IStipendijeService stipendijeService)
            :base(logger, stipendijeService)
        {

        }

    }
    
}
