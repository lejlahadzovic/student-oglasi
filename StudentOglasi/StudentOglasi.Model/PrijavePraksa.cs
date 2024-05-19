using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public class PrijavePraksa
    {
        public int StudentId { get; set; }

        public int PraksaId { get; set; }

        public string PropratnoPismo { get; set; } = null!;

        public string Cv { get; set; } = null!;

        public string Certifikati { get; set; } = null!;

        public int StatusId { get; set; }

        public virtual Prakse Praksa { get; set; } = null!;

        public virtual StatusPrijave Status { get; set; } = null!;

        public virtual Studenti Student { get; set; } = null!;
    }
}
