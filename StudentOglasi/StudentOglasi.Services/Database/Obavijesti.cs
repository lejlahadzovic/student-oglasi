using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Obavijesti
{
    public int Id { get; set; }

    public int? SmjestajiId { get; set; }

    public int? OglasiId { get; set; }

    public int? ObjaveId { get; set; }

    public string Naziv { get; set; } = null!;

    public string Opis { get; set; } = null!;

    public DateTime? DatumKreiranja { get; set; }

    public virtual Oglasi? Oglasi { get; set; }

    public virtual Smjestaji? Smjestaji { get; set; }

    public virtual Objave? Objave { get; set; }
}
