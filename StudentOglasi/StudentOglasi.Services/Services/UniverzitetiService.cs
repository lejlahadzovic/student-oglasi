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
    public class UniverzitetiService : BaseService<Model.Univerziteti,Database.Univerziteti, BaseSearchObject>, IUniverzitetiService
    {
        public UniverzitetiService(StudentoglasiContext context, IMapper mapper):base(context,mapper) { }
        public override IQueryable<Database.Univerziteti> AddInclude(IQueryable<Database.Univerziteti> query, BaseSearchObject? search = null)
        {
            query = query.Include(u => u.Fakultetis)
                 .ThenInclude(f => f.SmjeroviFakultetis)
                 .ThenInclude(fs => fs.Smjer);
            return base.AddInclude(query.Include("Fakultetis"), search);
        }
    }
}
