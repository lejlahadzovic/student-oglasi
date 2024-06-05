using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class PrijavePraksa
{
    public int StudentId { get; set; }

    public int PraksaId { get; set; }

    public string? PropratnoPismo { get; set; }

    public string Cv { get; set; } = null!;

    public string? Certifikati { get; set; }

    public int StatusId { get; set; }

    public virtual Prakse Praksa { get; set; } = null!;

    public virtual StatusPrijave Status { get; set; } = null!;

    public virtual Studenti Student { get; set; } = null!;
}
