using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Stipendije
    {
        public int Id { get; set; }

        public string Uslovi { get; set; } = null!;

        public double Iznos { get; set; }

        public string Kriterij { get; set; }

        public string PotrebnaDokumentacija { get; set; } = null!;

        public string Izvor { get; set; } = null!;

        public string NivoObrazovanja { get; set; } = null!;

        public int BrojStipendisata { get; set; }

        public int StatusId { get; set; }

        public virtual Oglasi IdNavigation { get; set; } = null!;

        public virtual StatusOglasi Status { get; set; } = null!;

        public virtual Stipenditori Stipenditor { get; set; } = null!;
    }
}
