using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Objave
    {
        public int Id { get; set; }

        public string Naslov { get; set; } = null!;

        public string Sadrzaj { get; set; } = null!;

        public DateTime VrijemeObjave { get; set; }

        public string Slika { get; set; } = null!;
        public virtual Kategorija Kategorija { get; set; } = null!;
    }
}
