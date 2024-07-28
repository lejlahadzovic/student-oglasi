using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Korisnici
{
    public int Id { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string KorisnickoIme { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string? BrojTelefona { get; set; }

    public string? Slika { get; set; }

    public string LozinkaHash { get; set; } = null!;

    public string LozinkaSalt { get; set; } = null!;

    public int UlogaId { get; set; }

    public virtual ICollection<Komentari> Komentaris { get; set; } = new List<Komentari>();

    public virtual ICollection<Like> Likes { get; set; } = new List<Like>();

    public virtual Studenti? Studenti { get; set; }

    public virtual Uloge Uloga { get; set; } = null!;
}
