using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class PrijaveStipendijaInsertRequest
    {
        public int StipendijaId { get; set; }

        public IFormFile? Dokumentacija { get; set; }

        public IFormFile? Cv { get; set; }

        [Range(6, 10, ErrorMessage = "ProsjekOcjena must be between 6 and 10.")]
        public decimal? ProsjekOcjena { get; set; }

    }
}
