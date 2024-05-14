using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class Fakulteti
    {
        public int Id { get; set; }
        public string Naziv { get; set; } = null!;
        public virtual ICollection<Smjerovi> Smjerovi { get; set; } = new List<Smjerovi>();
        public int UniverzitetId { get; set; }
    }
}
