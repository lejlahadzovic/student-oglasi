using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Stipenditori
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string Adresa { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Link { get; set; } = null!;

    public string TipUstanove { get; set; } = null!;

    public int GradId { get; set; }

    public virtual Grad Grad { get; set; } = null!;

    public virtual ICollection<Ocjene> Ocjenes { get; set; } = new List<Ocjene>();
}
