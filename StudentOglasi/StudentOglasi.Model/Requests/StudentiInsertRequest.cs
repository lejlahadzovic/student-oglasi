using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class StudentiInsertRequest
    {
        [Required(ErrorMessage = "Korisnici details are required.")]
        public virtual KorisniciInsertRequest IdNavigation { get; set; } = null!;

        [Required(ErrorMessage = "Broj indeksa is required.")]
        [StringLength(20, ErrorMessage = "Broj indeksa can't be longer than 20 characters.")]
        public string BrojIndeksa { get; set; } = null!;

        [Range(1, int.MaxValue, ErrorMessage = "Godina studija must be at least 1.")]
        public int GodinaStudija { get; set; }

        [Range(6.0, 10.0, ErrorMessage = "Prosječna ocjena must be between 6.0 and 10.0.")]
        public decimal? ProsjecnaOcjena { get; set; }
        public bool Status { get; set; } = true;

        [Required(ErrorMessage = "FakultetId is required.")]
        public int FakultetId { get; set; }

        [Required(ErrorMessage = "SmjerId is required.")]
        public int SmjerId { get; set; }

        [Required(ErrorMessage = "NacinStudiranjaId is required.")]
        public int NacinStudiranjaId { get; set; }
        public IFormFile? Slika { get; set; }
    }
}
