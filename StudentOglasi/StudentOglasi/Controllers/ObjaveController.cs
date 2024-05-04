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

        public override async Task<IActionResult> Insert([FromForm] ObjaveInsertRequest insert)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _service.Insert(insert);
            return Ok(result);
        }
        public override async Task<IActionResult> Update(int id, [FromForm] ObjaveUpdateRequest update)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _service.Update(id, update);
            return Ok(result);
        }
    }
}
