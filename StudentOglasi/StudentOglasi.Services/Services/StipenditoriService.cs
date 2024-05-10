using AutoMapper;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;

namespace StudentOglasi.Services.Services
{
    public class StipenditoriService : BaseService<Model.Stipenditori,Database.Stipenditori, BaseSearchObject>, IStipenditoriService
    {
        public StipenditoriService(StudentoglasiContext context, IMapper mapper):base(context,mapper) { }
    }
}
