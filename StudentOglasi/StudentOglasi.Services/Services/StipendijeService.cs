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
    public class StipendijeService : BaseCRUDService<Model.Stipendije, Database.Stipendije, StipendijeSearchObject, StipendijeInsertRequest, StipendijeUpdateRequest>, IStipendijeService
    {
        public StipendijeService(StudentoglasiContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.Stipendije> AddFilter(IQueryable<Database.Stipendije> query, StipendijeSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naslov))
            {
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.Naslov.Contains(search.Naslov));
            }
           
            return filteredQuery;
        }
        public override async Task<PagedResult<Model.Stipendije>> Get(StipendijeSearchObject? search = null)
        {
            var query = _context.Set<Database.Stipendije>().Include(p => p.IdNavigation).Include(p => p.Status).Include(p=>p.Stipenditor).AsQueryable();

            PagedResult<Model.Stipendije> result = new PagedResult<Model.Stipendije>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Model.Stipendije>>(list);
            result.Result = tmp;
            return result;
        }
    }
}