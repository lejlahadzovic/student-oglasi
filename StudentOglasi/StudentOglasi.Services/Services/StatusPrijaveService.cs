using AutoMapper;
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
    public class StatusPrijaveService : BaseService<Model.StatusPrijave,Database.StatusPrijave, BaseSearchObject>, IStatusPrijaveService
    {
        public StatusPrijaveService(StudentoglasiContext context, IMapper mapper):base(context,mapper) { }
    }
}
