using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Model;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Azure.Storage.Blobs.Models;
using StudentOglasi.Services.StateMachines.PrakseStateMachine;
using StudentOglasi.Services.StateMachines.PrijavePrakseStateMachine;
using System.Drawing.Printing;
using PrijavePraksa = StudentOglasi.Model.PrijavePraksa;
using Microsoft.VisualStudio.Services.Identity;
using iTextSharp.text.pdf;
using iTextSharp.text;

namespace StudentOglasi.Services.Services
{
    public class PrijavePraksaService : BaseCRUDService<Model.PrijavePraksa, Database.PrijavePraksa, PrijavePraksaSearchObject, PrijavePrakseInsertRequest, PrijavePrakseUpdateRequest>, IPrijavePraksaService
    {
        public BasePrijavePrakseState _baseState { get; set; }
        public PrijavePraksaService(StudentoglasiContext context, IMapper mapper, BasePrijavePrakseState baseState) : base(context, mapper)
        {
            _baseState = baseState;
        }
        public override Task<Model.PrijavePraksa> Insert(PrijavePrakseInsertRequest insert)
        {
            var state = _baseState.CreateState("Initial");
            return state.Insert(insert);
        }
        public async Task<List<PrijavePraksa>> GetByStudentIdAsync(int studentId)
        {
            var entity = await _context.PrijavePraksas.Where(x => x.StudentId == studentId)
                .Include(p => p.Praksa)
                .Include(p => p.Praksa.IdNavigation)
                .Include(p => p.Praksa.Organizacija)
                .Include(p => p.Praksa.Status)
                .Include(p => p.Student)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status).ToListAsync();

            return _mapper.Map<List<Model.PrijavePraksa>>(entity);

        }
        public override IQueryable<Database.PrijavePraksa> AddFilter(IQueryable<Database.PrijavePraksa> query, PrijavePraksaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Ime))
            {
                filteredQuery = filteredQuery.Where(x => x.Student.IdNavigation.Ime.Contains(search.Ime) || x.Student.IdNavigation.Prezime.Contains(search.Ime));
            }
            if (!string.IsNullOrWhiteSpace(search?.BrojIndeksa))
            {
                filteredQuery = filteredQuery.Where(x => x.Student.BrojIndeksa.Contains(search.BrojIndeksa));
            }
            if (search?.Status != null)
            {
                filteredQuery = filteredQuery.Where(x => x.StatusId == search.Status);
            }
            if (search?.Praksa != null)
            {
                filteredQuery = filteredQuery.Where(x => x.PraksaId == search.Praksa);
            }

            return filteredQuery;
        }
        public override IQueryable<Database.PrijavePraksa> AddInclude(IQueryable<Database.PrijavePraksa> query, PrijavePraksaSearchObject? search = null)
        {
            query = query.Include(p => p.Praksa)
                .Include(p => p.Praksa.IdNavigation)
                .Include(p => p.Student)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status).AsQueryable();

            return base.AddInclude(query, search);
        }
        public async Task<Model.PrijavePraksa> Cancel(int studentId, int praksaId)
        {
            var set = _context.Set<Database.PrijavePraksa>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.PraksaId == praksaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Cancel(studentId, praksaId);
        }

        public async Task<Model.PrijavePraksa> Approve(int studentId, int praksaId)
        {
            var set = _context.Set<Database.PrijavePraksa>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.PraksaId == praksaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Approve(studentId, praksaId);
        }
        public async Task<List<string>> AllowedActions(int studentId, int praksaId)
        {
            var set = _context.Set<Database.PrijavePraksa>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.PraksaId == praksaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv ?? "Na cekanju");
            return await state.AllowedActions();
        }

        public async Task<byte[]> DownloadReportAsync(int praksaId)
        {
            var prijave = await _context.PrijavePraksas
                .Include(p => p.Student)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Status)
                .Include(p => p.Praksa)
                .Include(p => p.Praksa.IdNavigation)
                .Where(p => p.PraksaId == praksaId)
                .ToListAsync();

            var praksa = await _context.Prakses
                .Include(s => s.IdNavigation)
                .Include(s => s.Organizacija)
                .FirstOrDefaultAsync(s => s.Id == praksaId);

            if (prijave == null || !prijave.Any())
            {
                throw new Exception("No applications found for the internship.");
            }

            var prijaveDto = _mapper.Map<List<Model.PrijavePraksa>>(prijave);
            var praksaDto = _mapper.Map<Model.Prakse>(praksa);

            return GeneratePDFReport(prijaveDto, praksaDto);
        }

        public byte[] GeneratePDFReport(List<PrijavePraksa> prijave, Model.Prakse praksa)
        {
            using (var stream = new MemoryStream())
            {
                var document = new iTextSharp.text.Document();
                var writer = PdfWriter.GetInstance(document, stream);
                document.Open();

                var title = new Paragraph("Izvještaj", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 18))
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 10f
                };
                document.Add(title);

                var subtitle = new Paragraph($"Naziv prakse:{praksa.IdNavigation.Naslov}", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12))
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 5f
                };
                document.Add(subtitle);
                var stipenditor = new Paragraph($"Naziv organizacije:{praksa.Organizacija.Naziv}", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12))
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 15f
                };
                document.Add(stipenditor);

                var table = new PdfPTable(5)
                {
                    WidthPercentage = 100,
                    SpacingBefore = 10f,
                    SpacingAfter = 15f
                };

                table.AddCell("Broj indeksa");
                table.AddCell("Ime i prezime");
                table.AddCell("CV");
                table.AddCell("Certifikati");
                table.AddCell("Propratno pismo");

                foreach (var prijava in prijave)
                {
                    table.AddCell(prijava.Student.BrojIndeksa);
                    table.AddCell($"{prijava.Student.IdNavigation.Ime} {prijava.Student.IdNavigation.Prezime}");
                    table.AddCell(prijava.Cv ?? "N/A");
                    table.AddCell(prijava.Certifikati?.ToString() ?? "N/A");
                    table.AddCell(prijava.PropratnoPismo?.ToString() ?? "N/A");
                }

                document.Add(table);

                int ukupnoPrijava = prijave.Count;
                int prihvacenihPrijava = prijave.Count(p => p.Status.Naziv == "Odobrena");
                int odbijenihPrijava = prijave.Count(p => p.Status.Naziv == "Otkazana");
                int naCekanjuPrijava = prijave.Count(p => p.Status.Naziv == "Na cekanju");
                string datumKreiranja = DateTime.Now.ToString("dd.MM.yyyy");

                var footer = new Paragraph($"Ukupan broj prijava: {ukupnoPrijava}\n"
                                           + $"Ukupan broj odobrenih prijava: {prihvacenihPrijava}\n"
                                           + $"Ukupan broj odbijenih prijava: {odbijenihPrijava}\n"
                                           + $"Ukupan broj prijava na cekanju: {naCekanjuPrijava}\n"
                                           + $"Datum kreiranja izvještaja: {datumKreiranja}", FontFactory.GetFont(FontFactory.HELVETICA, 10))
                {
                    Alignment = Element.ALIGN_LEFT,
                    SpacingBefore = 20f
                };
                document.Add(footer);

                document.Close();

                return stream.ToArray();
            }
        }
    }
}
