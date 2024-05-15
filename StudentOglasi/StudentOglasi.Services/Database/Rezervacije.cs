using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Rezervacije
{
    public int SmjestajId { get; set; }

    public int StudentId { get; set; }

    public DateOnly DatumPrijave { get; set; }

    public DateOnly DatumOdjave { get; set; }

    public int? BrojOsoba { get; set; }

    public string? Napomena { get; set; }

    public int? StatusId { get; set; }

    public virtual StatusPrijave? Status { get; set; }

    public virtual Studenti Student { get; set; } = null!;
}
