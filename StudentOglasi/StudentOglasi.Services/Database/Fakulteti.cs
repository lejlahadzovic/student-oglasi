using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Fakulteti
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string Adresa { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Telefon { get; set; } = null!;

    public string? Opis { get; set; }

    public string? Logo { get; set; }

    public string? Slika { get; set; }

    public string Link { get; set; } = null!;

    public int UniverzitetId { get; set; }

    public virtual ICollection<Ocjene> Ocjenes { get; set; } = new List<Ocjene>();

    public virtual ICollection<SmjeroviFakulteti> SmjeroviFakultetis { get; set; } = new List<SmjeroviFakulteti>();

    public virtual ICollection<Studenti> Studentis { get; set; } = new List<Studenti>();

    public virtual Univerziteti Univerzitet { get; set; } = null!;
}
