using StudentOglasi.Model.Requests;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public class Oglasi
    {
        public int Id { get; set; }
        public string Naslov { get; set; } = null!;

        [DateMustBeAfter(nameof(VrijemeObjave), nameof(RokPrijave))]
        public DateTime RokPrijave { get; set; }

        public string Opis { get; set; } = null!;

        public DateTime VrijemeObjave { get; set; }

        public string? Slika { get; set; }
    }
}
