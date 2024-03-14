using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Univerziteti
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Telefon { get; set; } = null!;

    public string? Logo { get; set; }

    public string? Slika { get; set; }

    public string Link { get; set; } = null!;

    public int GradId { get; set; }

    public virtual ICollection<Fakulteti> Fakultetis { get; set; } = new List<Fakulteti>();

    public virtual Grad Grad { get; set; } = null!;

    public virtual ICollection<Ocjene> Ocjenes { get; set; } = new List<Ocjene>();
}
