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

        public Model.Oglasi? IdNavigation { get; set; }

        public int StipenditorId { get; set; }
    }
}
