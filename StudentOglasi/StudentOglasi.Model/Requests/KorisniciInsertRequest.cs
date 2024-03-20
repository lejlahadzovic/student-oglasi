using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class KorisniciInsertRequest
    {
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Email { get; set; }
        public string KroisnickoIme { get; set; } = null!;
        public string Password { get; set; }
        [Compare("Password", ErrorMessage = "Passwords do not match.")]
        public string PasswordPotvrda { get; set; }
    }
}
