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
        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string Ime { get; set; } = null!;
        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string Prezime { get; set; } = null!;
        [Required]
        [EmailAddress]
        public string? Email { get; set; }
        [Required]
        public string KroisnickoIme { get; set; } = null!;
        [Required]
        // [RegularExpressionAttribute(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}$", ErrorMessage = "Password not strong enough")]
        public string Password { get; set; }
        [Required]
        [Compare("Password", ErrorMessage = "Passwords do not match.")]
        public string PasswordPotvrda { get; set; }
    }
}
