using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class SmjestajiUpdateRequest
    {
        public string Naziv { get; set; } = null!;

        public string Adresa { get; set; } = null!;

        public string? DodatneUsluge { get; set; }

        public string? Opis { get; set; }

        public bool? WiFi { get; set; }

        public bool? Parking { get; set; }

        public bool? FitnessCentar { get; set; }

        public bool? Restoran { get; set; }

        public bool? UslugePrijevoza { get; set; }

        public int GradId { get; set; }

        public int? TipSmjestajaId { get; set; }
    }
}
