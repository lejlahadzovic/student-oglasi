using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Komentari
{
    public int Id { get; set; }

    public int PostId { get; set; }

    public string PostType { get; set; } = null!;

    public int? ParentKomentarId { get; set; }

    public int KorisnikId { get; set; }

    public DateTime? VrijemeObjave { get; set; }

    public string Text { get; set; } = null!;

    public virtual ICollection<Komentari> InverseParentKomentar { get; set; } = new List<Komentari>();

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual Komentari? ParentKomentar { get; set; }
}
