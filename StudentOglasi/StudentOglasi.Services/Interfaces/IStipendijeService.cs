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
    public interface IStipendijeService : ICRUDService<Stipendije, StipendijeSearchObject, StipendijeInsertRequest, StipendijeUpdateRequest>
    {
        Task<Model.Stipendije> Hide(int id);
        Task<List<string>> AllowedActions(int id);
        Task<List<Model.Stipendije>> GetRecommendedStipendije(int studentId);
    }
}
