using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class SmjestajneJediniceController : BaseCRUDController<SmjestajnaJedinica, BaseSearchObject, SmjestajnaJedinicaInsertRequest, SmjestajnaJedinicaUpdateRequest>
    {
        public SmjestajneJediniceController(ILogger<BaseCRUDController<SmjestajnaJedinica, BaseSearchObject, SmjestajnaJedinicaInsertRequest, SmjestajnaJedinicaUpdateRequest>> logger, ISmjestajanaJedinicaService service):base(logger, service) 
        { 
        }
    }
}
