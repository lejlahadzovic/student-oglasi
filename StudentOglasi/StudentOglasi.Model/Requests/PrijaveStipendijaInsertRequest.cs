using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class PrijaveStipendijaInsertRequest
    {
        public int StipendijaId { get; set; }

        public string? Dokumentacija { get; set; }

        public string? Cv { get; set; }

        public decimal ProsjekOcjena { get; set; }

    }
}
