using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Services
{
    public class TipSmjestajaService : BaseService<Model.TipSmjestaja,Database.TipSmjestaja, BaseSearchObject>, ITipSmjestajaService
    {
        public TipSmjestajaService(StudentoglasiContext context, IMapper mapper):base(context,mapper) { }
       
    }
}
