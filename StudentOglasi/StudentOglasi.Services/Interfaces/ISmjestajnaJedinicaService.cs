using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Interfaces
{
    public interface ISmjestajanaJedinicaService : ICRUDService<SmjestajnaJedinica,BaseSearchObject,SmjestajnaJedinicaInsertRequest,SmjestajnaJedinicaUpdateRequest>
    {
    }
}
