using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class KorisniciController : BaseCRUDController<Model.Korisnik, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        public KorisniciController(ILogger<BaseController<Korisnik, KorisniciSearchObject>> logger, IKorisniciService korisniciService) : base(logger, korisniciService)
        {
        }
    }
}
