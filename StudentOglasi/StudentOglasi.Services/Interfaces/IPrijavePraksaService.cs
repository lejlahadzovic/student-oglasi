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
    public interface IPrijavePraksaService : ICRUDService<PrijavePraksa, PrijavePraksaSearchObject, PrijavePrakseInsertRequest, PrijavePrakseUpdateRequest>
    {
        Task<Model.PrijavePraksa> Approve(int studentId, int praksaId);
        Task<Model.PrijavePraksa> Cancel(int studentId, int praksaId);
        Task<List<string>> AllowedActions(int studentId, int praksaId);
        Task<List<PrijavePraksa>> GetByStudentIdAsync(int studentId);
        byte[] GeneratePDFReport(List<PrijavePraksa> prijave, Model.Prakse praksa);
        Task<byte[]> DownloadReportAsync(int praksaId);
    }
}
