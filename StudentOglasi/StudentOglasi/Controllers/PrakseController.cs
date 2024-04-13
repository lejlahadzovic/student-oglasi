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
    public class PrakseController : BaseCRUDController<Prakse, PrakseSearchObject, PrakseInsertRequest, PrakseUpdateRequest>
    {
        public PrakseController(ILogger<BaseCRUDController<Prakse, PrakseSearchObject, PrakseInsertRequest, PrakseUpdateRequest>> logger, IPrakseService prakseService)
            :base(logger, prakseService)
        {

        }
    }
    
}
