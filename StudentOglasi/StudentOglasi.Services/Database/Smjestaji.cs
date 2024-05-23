using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Smjestaji
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string Adresa { get; set; } = null!;

    public string? Opis { get; set; }

    public int GradId { get; set; }

    public string? DodatneUsluge { get; set; }

    public int? TipSmjestajaId { get; set; }

    public bool? WiFi { get; set; }

    public bool? Parking { get; set; }

    public bool? FitnessCentar { get; set; }

    public bool? Restoran { get; set; }

    public bool? UslugePrijevoza { get; set; }

    public virtual Grad Grad { get; set; } = null!;

    public virtual ICollection<Ocjene> Ocjenes { get; set; } = new List<Ocjene>();

    public virtual ICollection<Slike> Slikes { get; set; } = new List<Slike>();

    public virtual ICollection<SmjestajnaJedinica> SmjestajnaJedinicas { get; set; } = new List<SmjestajnaJedinica>();

    public virtual TipSmjestaja? TipSmjestaja { get; set; }
}
