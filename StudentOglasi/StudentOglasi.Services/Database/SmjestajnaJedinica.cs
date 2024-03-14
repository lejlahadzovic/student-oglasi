using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class SmjestajnaJedinica
{
    public int Id { get; set; }

    public decimal Cijena { get; set; }

    public int Kapacitet { get; set; }

    public int BrojKreveta { get; set; }

    public string? Opis { get; set; }

    public string? DodatneUsluge { get; set; }

    public int SmjestajId { get; set; }

    public virtual Smjestaji Smjestaj { get; set; } = null!;
}
