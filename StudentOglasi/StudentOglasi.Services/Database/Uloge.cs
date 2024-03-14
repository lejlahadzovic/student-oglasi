using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Uloge
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public virtual ICollection<Korisnici> Korisnicis { get; set; } = new List<Korisnici>();
}
