using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class PrijaveStipendija
{
    public int StudentId { get; set; }

    public int StipendijaId { get; set; }

    public string Dokumentacija { get; set; } = null!;

    public string Cv { get; set; } = null!;

    public decimal ProsjekOcjena { get; set; }

    public int StatusId { get; set; }

    public virtual StatusPrijave Status { get; set; } = null!;

    public virtual Stipendije Stipendija { get; set; } = null!;

    public virtual Studenti Student { get; set; } = null!;
}
