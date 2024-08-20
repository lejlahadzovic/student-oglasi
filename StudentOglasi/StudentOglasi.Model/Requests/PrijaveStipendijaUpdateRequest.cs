using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class PrijaveStipendijaUpdateRequest
    {
        public int StudentId { get; set; }

        public int StipendijaId { get; set; }

        public string Dokumentacija { get; set; } = null!;

        public string? Cv { get; set; }

        public decimal ProsjekOcjena { get; set; }

        public int StatusId { get; set; }
    }
}
