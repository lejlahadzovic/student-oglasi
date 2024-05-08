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

        [HttpPut("{id}/activate")]
        public virtual async Task<Model.Stipendije> Activate(int id)
        {
            return await (_service as IStipendijeService).Activate(id);
        }

        [HttpPut("{id}/hide")]
        public virtual async Task<Model.Stipendije> Hide(int id)
        {
            return await (_service as IStipendijeService).Hide(id);
        }

        [HttpGet("{id}/allowedActions")]
        public async Task<List<string>> AllowedActions(int id)
        {
            return await (_service as IStipendijeService).AllowedActions(id);
        }

    }
    
}
