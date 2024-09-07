using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class RezervacijaInsertRequest
    {
        public int SmjestajnaJedinicaId { get; set; }

        public int StudentId { get; set; }

        public DateTime DatumPrijave { get; set; }

        public DateTime DatumOdjave { get; set; }

        public int? BrojOsoba { get; set; }

        public string? Napomena { get; set; }

        public decimal Cijena { get; set; }

    }
}
