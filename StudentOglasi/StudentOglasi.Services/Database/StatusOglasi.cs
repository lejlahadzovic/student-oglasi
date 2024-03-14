using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class StatusOglasi
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public virtual ICollection<Prakse> Prakses { get; set; } = new List<Prakse>();

    public virtual ICollection<Stipendije> Stipendijes { get; set; } = new List<Stipendije>();
}
