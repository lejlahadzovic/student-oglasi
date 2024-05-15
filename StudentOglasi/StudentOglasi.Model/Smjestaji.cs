using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Smjestaji
    {
        public int Id { get; set; }

        public string Naziv { get; set; } = null!;

        public string Adresa { get; set; } = null!;

        public string? DodatneUsluge { get; set; }

        public string? Opis { get; set; }

        public bool? WiFi { get; set; }

        public bool? Parking { get; set; }

        public bool? FitnessCentar { get; set; }

        public bool? Restoran { get; set; }

        public bool? UslugePrijevoza { get; set; }

        public virtual Gradovi Grad { get; set; } = null!;

        public virtual TipSmjestaja? TipSmjestaja { get; set; }

        public virtual ICollection<SmjestajnaJedinica> SmjestajnaJedinicas { get; set; } = new List<SmjestajnaJedinica>();
    }
}
