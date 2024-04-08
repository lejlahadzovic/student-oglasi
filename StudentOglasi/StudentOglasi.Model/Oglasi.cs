using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public class Oglasi
    {
        public int Id { get; set; }
        public string Naslov { get; set; } = null!;

        public DateTime RokPrijave { get; set; }

        public string Opis { get; set; } = null!;

        public DateTime VrijemeObjave { get; set; }

        public string Slika { get; set; } = null!;
    }
}
