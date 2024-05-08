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
    public interface IPrakseService : ICRUDService<Prakse, PrakseSearchObject, PrakseInsertRequest, PrakseUpdateRequest>
    {
        Task<Model.Prakse> Activate(int id);
        Task<Model.Prakse> Hide(int id);
        Task<List<string>> AllowedActions(int id);
    }
}
