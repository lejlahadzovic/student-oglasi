using StudentOglasi.Model;
using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Like
{
    public int Id { get; set; }
    public int KorisnikId { get; set; }
    public int ItemId { get; set; }
    public string? ItemType { get; set; }
    public virtual Korisnici Korisnik { get; set; } = null!;
}
