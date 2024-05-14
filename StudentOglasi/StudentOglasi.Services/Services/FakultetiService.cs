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
    public class FakultetiService : BaseService<Model.Fakulteti,Database.Fakulteti,BaseSearchObject>, IFakultetiService
    {
        public FakultetiService(StudentoglasiContext context, IMapper mapper):base(context,mapper) 
        { 
        }

    }
}
