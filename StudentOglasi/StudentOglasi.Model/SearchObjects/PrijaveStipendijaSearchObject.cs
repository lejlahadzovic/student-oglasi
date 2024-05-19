using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.SearchObjects
{
    public class PrijaveStipendijaSearchObject : BaseSearchObject
    {
        public string? Ime { get; set; }
        public string? BrojIndeksa { get; set; }
        public string? Status { get; set; }
    }
}