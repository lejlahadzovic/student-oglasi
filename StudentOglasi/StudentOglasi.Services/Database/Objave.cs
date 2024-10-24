﻿using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Objave
{
    public int Id { get; set; }

    public string Naslov { get; set; } = null!;

    public string Sadrzaj { get; set; } = null!;

    public DateTime VrijemeObjave { get; set; }

    public string? Slika { get; set; }

    public virtual ICollection<Obavijesti> Obavijestis { get; set; } = new List<Obavijesti>();

    public int KategorijaId { get; set; }

    public virtual Kategorija Kategorija { get; set; } = null!;
}
