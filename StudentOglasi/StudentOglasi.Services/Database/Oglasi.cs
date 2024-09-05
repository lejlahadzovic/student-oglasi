using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Oglasi
{
    public int Id { get; set; }

    public string Naslov { get; set; } = null!;

    public DateTime RokPrijave { get; set; }

    public string Opis { get; set; } = null!;

    public DateTime VrijemeObjave { get; set; }

    public string? Slika { get; set; }

    public virtual ICollection<Obavijesti> Obavijestis { get; set; } = new List<Obavijesti>();

    public virtual Prakse? Prakse { get; set; }

    public virtual Stipendije? Stipendije { get; set; }
}
