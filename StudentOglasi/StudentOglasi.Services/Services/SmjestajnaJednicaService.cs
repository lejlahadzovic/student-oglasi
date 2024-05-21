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
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace StudentOglasi.Services.Services
{
    public class SmjestajnaJedinicaService:BaseCRUDService<Model.SmjestajnaJedinica, Database.SmjestajnaJedinica, BaseSearchObject, SmjestajnaJedinicaInsertRequest,SmjestajnaJedinicaUpdateRequest>, ISmjestajanaJedinicaService
    {
        public readonly FileService _fileService;
        public SmjestajnaJedinicaService(StudentoglasiContext context, IMapper mapper, FileService fileService) :base(context, mapper) 
        { 
            _fileService = fileService;
        }
        public override IQueryable<Database.SmjestajnaJedinica> AddInclude(IQueryable<Database.SmjestajnaJedinica> query, BaseSearchObject? search = null)
        {
            query = query.Include(sj => sj.Slikes);
            return base.AddInclude(query, search);
        }
    }
}
