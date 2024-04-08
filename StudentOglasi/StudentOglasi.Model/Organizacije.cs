using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Organizacije
    {
        public int Id { get; set; }

        public string Naziv { get; set; } = null!;

        public string Telefon { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string Adresa { get; set; } = null!;

        public string Link { get; set; } = null!;

        public int GradId { get; set; }

        //public virtual Grad Grad { get; set; } = null!;
    }
}
