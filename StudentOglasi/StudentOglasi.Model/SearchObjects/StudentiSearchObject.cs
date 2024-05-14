using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.SearchObjects
{
    public class StudentiSearchObject:BaseSearchObject
    {
        public string? BrojIndeksa { get; set; }
        public string? ImePrezime { get; set; }
        public int? FakuletID { get; set; }
        public int? GodinaStudija { get; set; }
    }
}
