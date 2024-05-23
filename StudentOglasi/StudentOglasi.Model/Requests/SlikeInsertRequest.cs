using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class SlikeInsertRequest
    {
        public IFormFile? Slika { get; set; }
        public int? SmjestajId { get; set; }
        public int? SmjestajnaJedinicaId { get; set; }
    }
}
