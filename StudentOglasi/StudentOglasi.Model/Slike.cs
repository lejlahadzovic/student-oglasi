using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Slike
    {
        public int SlikaId { get; set; }
        public string Naziv { get; set; } = null!;
        public int? SmjestajId { get; set; }
        public int? SmjestajnaJedinicaId { get; set; }
    }
}
