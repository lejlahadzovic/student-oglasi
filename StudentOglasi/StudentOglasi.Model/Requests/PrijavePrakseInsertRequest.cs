using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class PrijavePrakseInsertRequest
    {
        public int PraksaId { get; set; }

        public string? PropratnoPismo { get; set; }

        public string Cv { get; set; } = null!;

        public string? Certifikati { get; set; }

    }
}
