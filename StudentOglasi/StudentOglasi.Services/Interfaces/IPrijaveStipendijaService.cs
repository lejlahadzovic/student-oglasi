using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Interfaces
{
    public interface IPrijaveStipendijaService : IService<PrijaveStipendija, PrijaveStipendijaSearchObject>
    {
        Task<Model.PrijaveStipendija> Approve(int id);
        Task<Model.PrijaveStipendija> Cancel(int id);
        Task<List<string>> AllowedActions(int id);
    }
}
