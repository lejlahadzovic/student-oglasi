using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class SmjestajiBasic
    {
        public int Id { get; set; }

        public string Naziv { get; set; } = null!;

        public string Adresa { get; set; } = null!;

        public string? Opis { get; set; }

        public string? Grad{ get; set; }
        public string? TipSmjestaja { get; set; }

    }
}
