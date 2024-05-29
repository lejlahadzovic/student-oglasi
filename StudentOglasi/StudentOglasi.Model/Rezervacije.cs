using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Rezervacije
    {
        public int SmjestajnaJedinicaId { get; set; }

        public int StudentId { get; set; }

        public DateTime DatumPrijave { get; set; }

        public DateTime DatumOdjave { get; set; }

        public int? BrojOsoba { get; set; }

        public string? Napomena { get; set; }

        public int? StatusId { get; set; }

        public decimal Cijena { get; set; }

        public virtual SmjestajnaJedinica SmjestajnaJedinica { get; set; } = null!;

        public virtual SmjestajiBasic? Smjestaj { get; set; }

        public virtual StatusPrijave? Status { get; set; }

        public virtual Studenti Student { get; set; } = null!;
    }
}
