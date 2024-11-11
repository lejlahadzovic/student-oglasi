using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class StipendijeUpdateRequest
    {
        public string Uslovi { get; set; } = null!;

        public double Iznos { get; set; }

        public string? Kriterij { get; set; }

        public string PotrebnaDokumentacija { get; set; } = null!;

        public string Izvor { get; set; } = null!;

        public string NivoObrazovanja { get; set; } = null!;

        public int BrojStipendisata { get; set; }

        public IFormFile? Slika { get; set; }

        public OglasiRequest IdNavigation { get; set; } = null!;

        public int StipenditorId { get; set; }
        public int StatusId { get; set; }
    }
}
