using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.SearchObjects
{
    public class PrakseSearchObject:BaseSearchObject
    {
        public string? Naslov { get; set; }
        public string? Organizacija { get; set; }
        public string? Status { get; set; }
    }
}