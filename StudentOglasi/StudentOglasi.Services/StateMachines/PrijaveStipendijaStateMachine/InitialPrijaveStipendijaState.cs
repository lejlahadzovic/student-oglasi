using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.Services.Users;
using Microsoft.AspNetCore.Http;

namespace StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine
{
    public class InitialPrijaveStipendijaState : BasePrijaveStipendijaState
    {
        
        private readonly IPrijaveStipendijaService _prijaveStipendijaService;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public InitialPrijaveStipendijaState(IHttpContextAccessor httpContextAccessor,IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper, IPrijaveStipendijaService prijaveStipendijaService) : base(serviceProvider, context, mapper)
        {
            
            _prijaveStipendijaService = prijaveStipendijaService;
            _httpContextAccessor = httpContextAccessor;
        }

        public override async Task<Model.PrijaveStipendija> Insert(PrijaveStipendijaInsertRequest request)
        {
            try
            {
                var user = _httpContextAccessor.HttpContext.User;
            var username = user.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var set = _context.Set<PrijaveStipendija>();
            var entity = _mapper.Map<PrijaveStipendija>(request);

            entity.Status = await _context.StatusPrijaves.FirstOrDefaultAsync(e => e.Naziv.Contains("Na cekanju"));
            entity.StatusId = entity.Status.Id;
            entity.Stipendija = await _context.Stipendijes.FirstOrDefaultAsync(e => e.Id == request.StipendijaId);
            entity.StipendijaId = entity.Stipendija.Id;
            var student = await GetStudentByUsername(username);
            if (student == null)
            {
                throw new Exception("Student not found");
            }
                entity.Student = student;
            entity.StudentId = entity.Student.Id;  
            set.Add(entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.PrijaveStipendija>(entity);
            }
            catch (AutoMapperMappingException ex)
            {
                // Log the detailed information
                throw new Exception($"Mapping failed: {ex.Message}, Inner Exception: {ex.InnerException?.Message}", ex);
            }
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Insert");
            return list;
        }
        public async Task<Studenti> GetStudentByUsername(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                throw new Exception("User is not authorized");
            }

            var student = await _context.Studentis
                .Include(s => s.IdNavigation)
                .Include(s => s.NacinStudiranja)
                .Include(s => s.Fakultet)
                .Include(s => s.Smjer)
                .FirstOrDefaultAsync(s => s.IdNavigation.KorisnickoIme == username);

            if (student == null)
            {
                throw new Exception("Student not found");
            }

            return student;
        }
    }
}
