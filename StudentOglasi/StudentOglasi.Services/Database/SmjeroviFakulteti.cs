using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class SmjeroviFakulteti
{
    public int Id { get; set; }

    public int SmjerId { get; set; }

    public int FakultetId { get; set; }

    public virtual Fakulteti Fakultet { get; set; } = null!;

    public virtual Smjerovi Smjer { get; set; } = null!;
}
