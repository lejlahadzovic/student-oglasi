using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.SearchObjects
{
    public class SmjestajiSearchObject:BaseSearchObject
    {
        public string? Naziv { get; set; }
        public int? GradID { get; set; }
        public int? TipSmjestajaID { get; set; }
    }
}