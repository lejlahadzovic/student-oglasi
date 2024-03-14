﻿using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class NacinStudiranja
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public virtual ICollection<Studenti> Studentis { get; set; } = new List<Studenti>();
}
