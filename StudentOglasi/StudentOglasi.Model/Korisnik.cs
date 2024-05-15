using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Korisnik
    {
        public int Id { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string KorisnickoIme { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? Slika { get; set; }
        public int RoleId { get; set; }
        public virtual Uloge Uloga { get; set; } = null!;
    }
}
