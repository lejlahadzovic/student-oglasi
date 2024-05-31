using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.SearchObjects
{
    public class RezervacijeSearchObject : BaseSearchObject
    {
        public string? Ime { get; set; }
        public string? BrojIndeksa { get; set; }
        public int? Status { get; set; }

        public int? SmjestajId { get; set; }
        public int? SmjestajnaJedinicaId { get; set; }
        public DateTime? PocetniDatum { get; set; }
        public DateTime? KrajnjiDatum { get; set; }
    }
}