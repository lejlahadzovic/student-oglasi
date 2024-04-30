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
        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string Ime { get; set; } = null!;
        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string Prezime { get; set; } = null!;
        [Required]
        [EmailAddress]
        public string? Email { get; set; }
    }
}
