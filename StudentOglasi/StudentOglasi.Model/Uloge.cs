using System;
using System.Collections.Generic;

namespace StudentOglasi.Model
{
    public partial class Uloge
    {
        public int Id { get; set; }
        public string Naziv { get; set; } = null!;
        public string? Opis { get; set; }
    }
}