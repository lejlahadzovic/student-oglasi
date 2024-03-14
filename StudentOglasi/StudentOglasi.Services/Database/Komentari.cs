using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Komentari
{
    public int Id { get; set; }

    public int? ObjavaId { get; set; }

    public int? OglasId { get; set; }

    public int? KomentarId { get; set; }

    public int KorisnikId { get; set; }

    public DateTime VrijemeObjave { get; set; }

    public string Text { get; set; } = null!;

    public virtual ICollection<Komentari> InverseKomentar { get; set; } = new List<Komentari>();

    public virtual Komentari? Komentar { get; set; }

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual Objave? Objava { get; set; }

    public virtual Oglasi? Oglas { get; set; }
}
