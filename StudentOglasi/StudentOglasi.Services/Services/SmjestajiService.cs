using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
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
    public class SmjestajiService : BaseCRUDService<Model.Smjestaji, Database.Smjestaji, SmjestajiSearchObject, SmjestajiInsertRequest, SmjestajiUpdateRequest>, ISmjestajiService
    {
        public SmjestajiService(StudentoglasiContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.Smjestaji> AddFilter(IQueryable<Database.Smjestaji> query, SmjestajiSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.Contains(search.Naziv));
            }
            if (search?.GradID != null)
            {
                filteredQuery = filteredQuery.Where(x => x.GradId == search.GradID);
            }
            if (search?.TipSmjestajaID != null)
            {
                filteredQuery = filteredQuery.Where(x => x.TipSmjestajaId == search.TipSmjestajaID);
            }
            return filteredQuery;
        }
        public override IQueryable<Database.Smjestaji> AddInclude(IQueryable<Database.Smjestaji> query, SmjestajiSearchObject? search = null)
        {
            query = query.Include(s=> s.Grad)
                 .Include(s=>s.TipSmjestaja)
                 .Include(s=>s.Slikes)
                 .Include(s => s.SmjestajnaJedinicas)
                    .ThenInclude(sj => sj.Slikes);
            return base.AddInclude(query, search);
        }
    }
}