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
    public interface IRezervacijeService : IService<Rezervacije, RezervacijeSearchObject>
    {
        Task<Model.Rezervacije> Approve(int studentId, int smjestajnaJedinicaId);
        Task<Model.Rezervacije> Cancel(int studentId, int smjestajnaJedinicaId);
        Task<List<string>> AllowedActions(int studentId, int smjestajnaJedinicaId);
        Task<List<Rezervacije>> GetByStudentIdAsync(int studentId);
        Task<Model.Rezervacije> Insert(RezervacijaInsertRequest request);
        byte[] GeneratePDFReport(List<Rezervacije> prijave, Model.SmjestajnaJedinica smjestaj);
        Task<byte[]> DownloadReportAsync(int smjestajId, int? smjestajnaJedinicaId, DateTime? pocetniDatum, DateTime? krajnjiDatum);
    }
}
