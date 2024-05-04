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
    public class StatusOglasiService : BaseService<Model.StatusOglasi,Database.StatusOglasi, BaseSearchObject>, IStatusOglasiService
    {
        public StatusOglasiService(StudentoglasiContext context, IMapper mapper):base(context,mapper) { }
    }
}
