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
    public class PrijaveStipendijaService : BaseService<Model.PrijaveStipendija, Database.PrijaveStipendija, PrijaveStipendijaSearchObject>, IPrijaveStipendijaService
    {
        public PrijaveStipendijaService(StudentoglasiContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.PrijaveStipendija> AddFilter(IQueryable<Database.PrijaveStipendija> query, PrijaveStipendijaSearchObject? search = null)
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
        public override async Task<PagedResult<Model.PrijaveStipendija>> Get(PrijaveStipendijaSearchObject? search = null)
        {
            var query = _context.Set<Database.PrijaveStipendija>()
                .Include(p=>p.Student)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status)
                .Include(p=>p.Stipendija.IdNavigation).AsQueryable();

            PagedResult<Model.PrijaveStipendija> result = new PagedResult<Model.PrijaveStipendija>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Model.PrijaveStipendija>>(list);
            result.Result = tmp;
            return result;
        }
    }
}
