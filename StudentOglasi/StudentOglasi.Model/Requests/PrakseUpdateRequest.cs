using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class PrakseUpdateRequest
    {
        public DateTime PocetakPrakse { get; set; }

        public DateTime KrajPrakse { get; set; }

        public string Kvalifikacije { get; set; } = null!;

        public string Benefiti { get; set; } = null!;

        public bool Placena { get; set; }

        public Model.Oglasi? IdNavigation { get; set; }

        public int StatusId { get; set; }

        public int OrganizacijaId { get; set; }
    }
}
