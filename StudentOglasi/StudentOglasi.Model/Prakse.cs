using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Prakse
    {
        public int Id { get; set; }

        public DateTime PocetakPrakse { get; set; }

        public DateTime KrajPrakse { get; set; }

        public string Kvalifikacije { get; set; } = null!;

        public string Benefiti { get; set; } = null!;

        public bool Placena { get; set; }

        public virtual Oglasi IdNavigation { get; set; } = null!;

        public virtual Organizacije Organizacija { get; set; } = null!;

        public virtual StatusOglasi Status { get; set; } = null!;
    }
}
