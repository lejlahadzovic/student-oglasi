using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class StatusPrijave
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public virtual ICollection<PrijavePraksa> PrijavePraksas { get; set; } = new List<PrijavePraksa>();

    public virtual ICollection<PrijaveStipendija> PrijaveStipendijas { get; set; } = new List<PrijaveStipendija>();

    public virtual ICollection<Rezervacije> Rezervacijes { get; set; } = new List<Rezervacije>();
}
