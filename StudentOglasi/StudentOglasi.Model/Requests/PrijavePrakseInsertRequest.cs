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

        public IFormFile? PropratnoPismo { get; set; }

        public IFormFile? Cv { get; set; }

        public IFormFile? Certifikati { get; set; }

    }
}
