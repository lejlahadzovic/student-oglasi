using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Model;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine;
using StudentOglasi.Model.Requests;
using PrijaveStipendija = StudentOglasi.Model.PrijaveStipendija;
using iTextSharp.text.pdf;
using iTextSharp.text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Azure;
using Stripe;

namespace StudentOglasi.Services.Services
{
    public class PrijaveStipendijaService : BaseCRUDService<Model.PrijaveStipendija, Database.PrijaveStipendija, PrijaveStipendijaSearchObject,PrijaveStipendijaInsertRequest,PrijaveStipendijaUpdateRequest>, IPrijaveStipendijaService
    {
        public BasePrijaveStipendijaState _baseState { get; set; }
        public PrijaveStipendijaService(StudentoglasiContext context, IMapper mapper, BasePrijaveStipendijaState baseState) : base(context, mapper)
        {
            _baseState = baseState;
        }
        public override Task<Model.PrijaveStipendija> Insert(PrijaveStipendijaInsertRequest insert)
        {
            var state = _baseState.CreateState("Initial");
            return state.Insert(insert);
        }
        public override IQueryable<Database.PrijaveStipendija> AddFilter(IQueryable<Database.PrijaveStipendija> query, PrijaveStipendijaSearchObject? search = null)
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
            if (search?.Stipendija != null)
            {
                filteredQuery = filteredQuery.Where(x => x.StipendijaId == search.Stipendija);
            }

            return filteredQuery;
        }
        public override IQueryable<Database.PrijaveStipendija> AddInclude(IQueryable<Database.PrijaveStipendija> query, PrijaveStipendijaSearchObject? search = null)
        {
            query = _context.Set<Database.PrijaveStipendija>()
                .Include(p => p.Student)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status)
                .Include(p => p.Stipendija.IdNavigation).AsQueryable();

            return base.AddInclude(query, search);
        }
        public async Task<Model.PrijaveStipendija> Cancel(int studentId, int stipendijaId)
        {
            var set = _context.Set<Database.PrijaveStipendija>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.StipendijaId == stipendijaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Cancel(studentId, stipendijaId);
        }

        public async Task<Model.PrijaveStipendija> Approve(int studentId, int stipendijaId)
        {
            var set = _context.Set<Database.PrijaveStipendija>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.StipendijaId == stipendijaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv);

            return await state.Approve(studentId, stipendijaId);
        }
        public async Task<List<string>> AllowedActions(int studentId, int stipendijaId)
        {
            var set = _context.Set<Database.PrijaveStipendija>();

            var entity = await set.FirstOrDefaultAsync(p => p.StudentId == studentId && p.StipendijaId == stipendijaId);
            entity.Status = await _context.StatusPrijaves.FindAsync(entity.StatusId);
            var state = _baseState.CreateState(entity.Status.Naziv ?? "Na cekanju");
            return await state.AllowedActions();
        }

        public async Task<List<PrijaveStipendija>> GetByStudentIdAsync(int studentId)
        {
            var entity = _context.PrijaveStipendijas.Where(x => x.StudentId == studentId)
                .Include(p => p.Stipendija)
                .Include(p => p.Stipendija.IdNavigation)
                .Include(p => p.Stipendija.Stipenditor)
                .Include(p => p.Stipendija.Status)
                .Include(p => p.Student)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.NacinStudiranja)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Status).ToList();


            return _mapper.Map<List<Model.PrijaveStipendija>>(entity);

        }
        public async Task<byte[]> DownloadReportAsync(int stipendijaId)
        {
            var prijave = await _context.PrijaveStipendijas
                .Include(p => p.Student)
                .Include(p => p.Student.IdNavigation)
                .Include(p => p.Student.Fakultet)
                .Include(p => p.Student.Smjer)
                .Include(p => p.Status)
                .Include(p => p.Stipendija)
                .Include(p => p.Stipendija.IdNavigation)
                .Where(p => p.StipendijaId == stipendijaId)
                .ToListAsync();

            var stipendija = await _context.Stipendijes
                .Include(s => s.IdNavigation)
                .Include(s => s.Stipenditor)
                .FirstOrDefaultAsync(s => s.Id == stipendijaId);

            if (prijave == null || !prijave.Any())
            {
                throw new Exception("No applications found for the scholarship.");
            }

            var prijaveDto = _mapper.Map<List<Model.PrijaveStipendija>>(prijave);
            var stipendijaDto = _mapper.Map<Model.Stipendije>(stipendija);

            return GeneratePDFReport(prijaveDto, stipendijaDto);
        }
        public byte[] GeneratePDFReport(List<PrijaveStipendija> prijave, Model.Stipendije stipendija)
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

                var subtitle = new Paragraph($"Naziv stipendije:{stipendija.IdNavigation.Naslov}", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12))
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 5f
                };
                document.Add(subtitle);
                var stipenditor = new Paragraph($"Naziv stipenditora:{stipendija.Stipenditor.Naziv}", FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12))
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
                table.AddCell("Dokumentacija");
                table.AddCell("Prosjek ocjena");

                foreach (var prijava in prijave)
                {
                    table.AddCell(prijava.Student.BrojIndeksa);
                    table.AddCell($"{prijava.Student.IdNavigation.Ime} {prijava.Student.IdNavigation.Prezime}");
                    table.AddCell(prijava.Cv ?? "N/A");
                    table.AddCell(prijava.Dokumentacija?.ToString() ?? "N/A");
                    table.AddCell(prijava.ProsjekOcjena.ToString() ?? "N/A");
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



