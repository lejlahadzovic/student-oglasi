using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Rezervacije
{
    public int SmjestajId { get; set; }

    public int StudentId { get; set; }

    public DateTime DatumPrijave { get; set; }

    public DateTime DatumOdjave { get; set; }

    public int BrojOsoba { get; set; }

    public string Napomena { get; set; } = null!;

    public int StatusId { get; set; }

    public virtual Smjestaji Smjestaj { get; set; } = null!;

    public virtual StatusPrijave Status { get; set; } = null!;

    public virtual Studenti Student { get; set; } = null!;
}
