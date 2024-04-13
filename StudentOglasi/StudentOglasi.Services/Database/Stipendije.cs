using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Stipendije
{
    public int Id { get; set; }

    public string Uslovi { get; set; } = null!;

    public double Iznos { get; set; }

    public string Kriterij { get; set; } = null!;

    public string PotrebnaDokumentacija { get; set; } = null!;

    public string Izvor { get; set; } = null!;

    public string NivoObrazovanja { get; set; } = null!;

    public int BrojStipendisata { get; set; }

    public int StatusId { get; set; }

    public int StipenditorId { get; set; }

    public virtual Oglasi IdNavigation { get; set; } = null!;

    public virtual ICollection<PrijaveStipendija> PrijaveStipendijas { get; set; } = new List<PrijaveStipendija>();

    public virtual StatusOglasi Status { get; set; } = null!;

    public virtual Stipenditori Stipenditor { get; set; } = null!;
}
