using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Slike
{
    public int SlikaId { get; set; }

    public string Naziv { get; set; } = null!;

    public int? SmjestajId { get; set; }

    public int? SmjestajnaJedinicaId { get; set; }

    public virtual Smjestaji? Smjestaj { get; set; }

    public virtual SmjestajnaJedinica? SmjestajnaJedinica { get; set; }
}
