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
        [Required(ErrorMessage = "Naziv is required.")]
        [StringLength(100, ErrorMessage = "Naziv can't be longer than 100 characters.")]
        public string Naziv { get; set; } = null!;

        [Required(ErrorMessage = "Adresa is required.")]
        [StringLength(200, ErrorMessage = "Adresa can't be longer than 200 characters.")]
        public string Adresa { get; set; } = null!;

        public string? DodatneUsluge { get; set; }

        public string? Opis { get; set; }

        public bool? WiFi { get; set; }

        public bool? Parking { get; set; }

        public bool? FitnessCentar { get; set; }

        public bool? Restoran { get; set; }

        public bool? UslugePrijevoza { get; set; }

        [Required(ErrorMessage = "GradId is required.")]
        public int GradId { get; set; }

        public int? TipSmjestajaId { get; set; }
    }
}
