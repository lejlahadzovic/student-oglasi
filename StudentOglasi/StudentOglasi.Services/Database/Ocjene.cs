using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Ocjene
{
    public int Id { get; set; }

    public int StudentId { get; set; }

    public int Vrijednost { get; set; }

    public string? Komentar { get; set; }

    public int? FakultetId { get; set; }

    public int? FirmaId { get; set; }

    public int? StipenditorId { get; set; }

    public int? UniverzitetId { get; set; }

    public int? SmjestajId { get; set; }

    public virtual Fakulteti? Fakultet { get; set; }

    public virtual Organizacije? Firma { get; set; }

    public virtual Smjestaji? Smjestaj { get; set; }

    public virtual Stipenditori? Stipenditor { get; set; }

    public virtual Studenti Student { get; set; } = null!;

    public virtual Univerziteti? Univerzitet { get; set; }
}
