using Microsoft.AspNetCore.Mvc;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class KategorijeController : BaseController<Kategorija, KategorijaSearchObject>
    {
        public KategorijeController(ILogger<BaseController<Kategorija, KategorijaSearchObject>> logger, IKategorijeService kategorijeService):base(logger,kategorijeService)
        {
            
        }
    }
}
