using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class TipSmjestaja
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public virtual ICollection<Smjestaji> Smjestajis { get; set; } = new List<Smjestaji>();
}
