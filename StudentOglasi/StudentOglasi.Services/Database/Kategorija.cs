using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Kategorija
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public virtual ICollection<Objave> Objaves { get; set; } = new List<Objave>();
}
