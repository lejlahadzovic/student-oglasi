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
    public interface IPrijaveStipendijaService : ICRUDService<PrijaveStipendija, PrijaveStipendijaSearchObject,PrijaveStipendijaInsertRequest,PrijaveStipendijaUpdateRequest>
    {
        Task<Model.PrijaveStipendija> Approve(int studentId, int stipendijaId);
        Task<Model.PrijaveStipendija> Cancel(int studentId, int stipendijaId);
        Task<List<string>> AllowedActions(int studentId, int stipendijaId);
        Task<List<PrijaveStipendija>> GetByStudentIdAsync(int studentId);
    }
}
