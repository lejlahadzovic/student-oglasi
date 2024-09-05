using System;
using System.Collections.Generic;

namespace StudentOglasi.Services.Database;

public partial class Ocjene
{
    public int Id { get; set; }

    public int StudentId { get; set; }

    public int PostId { get; set; }

    public decimal Ocjena { get; set; }

    public string PostType { get; set; } = null!;

    public virtual Studenti Student { get; set; } = null!;
}
