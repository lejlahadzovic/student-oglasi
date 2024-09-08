using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class SmjestajnaJedinicaInsertRequest
    {
        [Required(ErrorMessage = "Naziv is required.")]
        [StringLength(100, ErrorMessage = "Naziv can't be longer than 100 characters.")]
        public string Naziv { get; set; } = null!;

        [Range(0.01, double.MaxValue, ErrorMessage = "Cijena must be a positive value.")]
        public decimal Cijena { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Kapacitet must be at least 1.")]
        public int Kapacitet { get; set; }

        [StringLength(1000, ErrorMessage = "Opis can't be longer than 1000 characters.")]
        public string? Opis { get; set; }

        [StringLength(500, ErrorMessage = "Dodatne usluge can't be longer than 500 characters.")]
        public string? DodatneUsluge { get; set; }

        public bool? Kuhinja { get; set; }

        public bool? Tv { get; set; }

        public bool? KlimaUredjaj { get; set; }

        public bool? Terasa { get; set; }
        public int SmjestajId { get; set; }
    }
}
