using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class ObjaveUpdateRequest
    {
        public string? Naslov { get; set; }
        public string? Sadrzaj { get; set; }
        public string? Slika { get; set; }
        public int? KategorijaId { get; set; }
    }
}
