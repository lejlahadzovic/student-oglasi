using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Grad
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public virtual ICollection<Organizacije> Organizacijes { get; set; } = new List<Organizacije>();

    public virtual ICollection<Smjestaji> Smjestajis { get; set; } = new List<Smjestaji>();

    public virtual ICollection<Stipenditori> Stipenditoris { get; set; } = new List<Stipenditori>();

    public virtual ICollection<Univerziteti> Univerzitetis { get; set; } = new List<Univerziteti>();
}
