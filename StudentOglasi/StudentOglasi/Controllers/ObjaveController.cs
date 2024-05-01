using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ObjaveController : BaseCRUDController<Model.Objave,ObjaveSearchObject,ObjaveInsertRequest,ObjaveUpdateRequest>
    {
        public ObjaveController(ILogger<BaseCRUDController<Model.Objave, ObjaveSearchObject, ObjaveInsertRequest, ObjaveUpdateRequest>> logger, IObjaveService objaveService)
            :base(logger, objaveService)
        {

        }

        public override async Task<Objave> Insert([FromForm] ObjaveInsertRequest insert)
        {
            return await _service.Insert(insert);
        }
        public override async Task<Objave> Update(int id, [FromForm] ObjaveUpdateRequest update)
        {
            return await _service.Update(id, update);
        }
    }
}
