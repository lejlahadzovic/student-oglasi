using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Interfaces
{
    public interface IPrijavePraksaService : IService<PrijavePraksa, PrijavePraksaSearchObject>
    {
        Task<Model.PrijavePraksa> Approve(int id);
        Task<Model.PrijavePraksa> Cancel(int id);
        Task<List<string>> AllowedActions(int id);
    }
}
