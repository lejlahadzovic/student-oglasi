using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Model;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace StudentOglasi.Services.Services
{
    public class PrijavePraksaService : BaseService<Model.PrijavePraksa, Database.PrijavePraksa, PrijavePraksaSearchObject>, IPrijavePraksaService
    {
        public PrijavePraksaService(StudentoglasiContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.PrijavePraksa> AddFilter(IQueryable<Database.PrijavePraksa> query, PrijavePraksaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Ime))
            {
                filteredQuery = filteredQuery.Where(x => x.Student.IdNavigation.Ime.Contains(search.Ime) || x.Student.IdNavigation.Prezime.Contains(search.Ime));
            }
            if (!string.IsNullOrWhiteSpace(search?.BrojIndeksa))
            {
                filteredQuery = filteredQuery.Where(x => x.Student.BrojIndeksa.Contains(search.BrojIndeksa));
            }
            if (!string.IsNullOrWhiteSpace(search?.Status))
            {
                filteredQuery = filteredQuery.Where(x => x.Status.Naziv.Contains(search.Status));
            }
            return filteredQuery;
        }
        public override async Task<PagedResult<Model.PrijavePraksa>> Get(PrijavePraksaSearchObject? search = null)
        {
            var query = _context.Set<Database.PrijavePraksa>()
                .Include(p => p.Praksa)
                .Include(p=>p.Praksa.IdNavigation)
                .Include(p => p.Student)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status).AsQueryable();

            PagedResult<Model.PrijavePraksa> result = new PagedResult<Model.PrijavePraksa>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Model.PrijavePraksa>>(list);
            result.Result = tmp;
            return result;
        }
    }
}
