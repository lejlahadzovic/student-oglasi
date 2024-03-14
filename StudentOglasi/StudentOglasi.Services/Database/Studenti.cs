using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Studenti
{
    public int Id { get; set; }

    public string BrojIndeksa { get; set; } = null!;

    public int GodinaStudija { get; set; }

    public decimal? ProsjecnaOcjena { get; set; }

    public bool Status { get; set; }

    public int FakultetId { get; set; }

    public int SmjerId { get; set; }

    public int NacinStudiranjaId { get; set; }

    public virtual Fakulteti Fakultet { get; set; } = null!;

    public virtual Korisnici IdNavigation { get; set; } = null!;

    public virtual NacinStudiranja NacinStudiranja { get; set; } = null!;

    public virtual ICollection<Ocjene> Ocjenes { get; set; } = new List<Ocjene>();

    public virtual ICollection<PrijavePraksa> PrijavePraksas { get; set; } = new List<PrijavePraksa>();

    public virtual ICollection<PrijaveStipendija> PrijaveStipendijas { get; set; } = new List<PrijaveStipendija>();

    public virtual ICollection<Rezervacije> Rezervacijes { get; set; } = new List<Rezervacije>();

    public virtual Smjerovi Smjer { get; set; } = null!;
}
