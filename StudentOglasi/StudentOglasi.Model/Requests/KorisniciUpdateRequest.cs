using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class KorisniciUpdateRequest
    {
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Email { get; set; }
    }
}
