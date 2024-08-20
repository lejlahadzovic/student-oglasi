using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class KomentarInsertRequest
    {
        public int PostId { get; set; }
        public string PostType { get; set; } = null!;
        public int? ParentKomentarId { get; set; }
        public int KorisnikId { get; set; }
        public string Text { get; set; } = null!;
    }
}
