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
    public class PrakseService : BaseCRUDService<Model.Prakse, Database.Prakse, PrakseSearchObject, PrakseInsertRequest, PrakseUpdateRequest>, IPrakseService
    {
        public PrakseService(StudentoglasiContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.Prakse> AddFilter(IQueryable<Database.Prakse> query, PrakseSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naslov))
            {
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.Naslov.Contains(search.Naslov) || x.Organizacija.Naziv.Contains(search.Organizacija));
            }
            if (!string.IsNullOrWhiteSpace(search?.Organizacija))
            {
                filteredQuery = filteredQuery.Where(x => x.Organizacija.Naziv.Contains(search.Organizacija));
            }
            if (!string.IsNullOrWhiteSpace(search?.Status))
            {
                filteredQuery = filteredQuery.Where(x => x.Status.Naziv.Contains(search.Status));
            }
            return filteredQuery;
        }
        public override async Task<PagedResult<Model.Prakse>> Get(PrakseSearchObject? search = null)
        {
            var query = _context.Set<Database.Prakse>().Include(p => p.IdNavigation).Include(p=>p.Organizacija).Include(p => p.Status).AsQueryable();

            PagedResult<Model.Prakse> result = new PagedResult<Model.Prakse>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Model.Prakse>>(list);
            result.Result = tmp;
            return result;
        }
        public override async Task<Model.Prakse> Update(int id, PrakseUpdateRequest update)
        {
            var set = _context.Set<Database.Prakse>();

            var entity = await set.Include(p => p.IdNavigation).FirstOrDefaultAsync(e => e.Id == id);

            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Prakse>(entity);
        }
    }
}