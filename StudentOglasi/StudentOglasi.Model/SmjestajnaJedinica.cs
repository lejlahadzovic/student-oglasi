﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model
{
    public partial class SmjestajnaJedinica
    {
        public int Id { get; set; }

        public string Naziv { get; set; } = null!;

        public decimal Cijena { get; set; }

        public int Kapacitet { get; set; }

        public string? Opis { get; set; }

        public string? DodatneUsluge { get; set; }

        public bool? Kuhinja { get; set; }

        public bool? Tv { get; set; }

        public bool? KlimaUredjaj { get; set; }

        public bool? Terasa { get; set; }

        public virtual ICollection<Slike> Slikes { get; set; } = new List<Slike>();
    }
}
