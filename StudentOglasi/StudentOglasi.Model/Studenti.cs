using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Studenti
    {
        public int Id { get; set; }

        public string BrojIndeksa { get; set; } = null!;

        public int GodinaStudija { get; set; }

        public decimal? ProsjecnaOcjena { get; set; }

        public bool Status { get; set; }

        public virtual Fakulteti Fakultet { get; set; } = null!;

        public virtual Korisnik IdNavigation { get; set; } = null!;

        public virtual NacinStudiranja NacinStudiranja { get; set; } = null!;

        //public virtual ICollection<Ocjene> Ocjenes { get; set; } = new List<Ocjene>();

        //public virtual ICollection<PrijavePraksa> PrijavePraksas { get; set; } = new List<PrijavePraksa>();

        //public virtual ICollection<PrijaveStipendija> PrijaveStipendijas { get; set; } = new List<PrijaveStipendija>();

        //public virtual ICollection<Rezervacije> Rezervacijes { get; set; } = new List<Rezervacije>();

        public virtual Smjerovi Smjer { get; set; } = null!;
    }
}
