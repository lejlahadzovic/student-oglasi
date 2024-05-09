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
            : base(logger, prakseService)
        {

        }

        [HttpPut("{id}/activate")]
        public virtual async Task<Model.Prakse> Activate(int id)
        {
            return await (_service as IPrakseService).Activate(id);
        }

        [HttpPut("{id}/hide")]
        public virtual async Task<Model.Prakse> Hide(int id)
        {
            return await (_service as IPrakseService).Hide(id);
        }

        [HttpGet("{id}/allowedActions")]
        public async Task<List<string>> AllowedActions(int id)
        {
            return await (_service as IPrakseService).AllowedActions(id);
        }
    }
}
