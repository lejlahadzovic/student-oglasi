using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class StudentiInsertRequest
    {
        public virtual KorisniciInsertRequest IdNavigation { get; set; } = null!;
        public string BrojIndeksa { get; set; } = null!;
        public int GodinaStudija { get; set; }
        public decimal? ProsjecnaOcjena { get; set; }
        public bool Status { get; set; } = true;
        public int FakultetId { get; set; }
        public int SmjerId { get; set; }
        public int NacinStudiranjaId { get; set; }
        public IFormFile? Slika { get; set; }
    }
}
