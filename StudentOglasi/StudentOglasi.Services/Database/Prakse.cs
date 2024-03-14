using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Prakse
{
    public int Id { get; set; }

    public DateTime PocetakPrakse { get; set; }

    public DateTime KrajPrakse { get; set; }

    public string Kvalifikacije { get; set; } = null!;

    public string Benefiti { get; set; } = null!;

    public bool Placena { get; set; }

    public int StatusId { get; set; }

    public int OrganizacijaId { get; set; }

    public virtual Oglasi IdNavigation { get; set; } = null!;

    public virtual Organizacije Organizacija { get; set; } = null!;

    public virtual ICollection<PrijavePraksa> PrijavePraksas { get; set; } = new List<PrijavePraksa>();

    public virtual StatusOglasi Status { get; set; } = null!;
}
