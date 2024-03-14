using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Smjestaji
{
    public int Id { get; set; }

    public string DodatneUsluge { get; set; } = null!;

    public bool Parking { get; set; }

    public string NacinGrijanja { get; set; } = null!;

    public int GradId { get; set; }

    public virtual Grad Grad { get; set; } = null!;

    public virtual Oglasi IdNavigation { get; set; } = null!;

    public virtual ICollection<Ocjene> Ocjenes { get; set; } = new List<Ocjene>();

    public virtual ICollection<Rezervacije> Rezervacijes { get; set; } = new List<Rezervacije>();

    public virtual ICollection<SmjestajnaJedinica> SmjestajnaJedinicas { get; set; } = new List<SmjestajnaJedinica>();
}
