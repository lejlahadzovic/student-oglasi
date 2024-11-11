using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Services;
using StudentOglasi.Services.StateMachines.PrakseStateMachine;

namespace StudentOglasi.Services.StateMachine.PrakseStateMaachine
{
    public class DraftPrakseState : BasePrakseState
    {
        public readonly FileService _fileService;
        public DraftPrakseState(IServiceProvider serviceProvider, StudentoglasiContext context, FileService fileService, IMapper mapper) : base(serviceProvider, context, mapper)
        {
            _fileService = fileService;
        }
        public override async Task<Model.Prakse> Update(int id, PrakseUpdateRequest request)
        {
            var set = _context.Set<Database.Prakse>();

            var entity = await set.Include(p => p.IdNavigation).FirstOrDefaultAsync(e => e.Id == id);

            if (entity == null)
                throw new Exception("Objekat nije pronađen");

            if (request.Slika != null)
            {
                await HandleImageUpdateAsync(entity, request.Slika);
            }

            var state = await _context.StatusOglasis.FindAsync(request.StatusId);
            if (state.Naziv.Contains("Aktivan") && request.IdNavigation.RokPrijave < DateTime.Now)
            {
                throw new Exception("Oglas ne može biti aktiviran ako je rok prijave istekao. Datum roka prijave mora biti veći od trenutnog.");
            }
            else if (state.Naziv.Contains("Istekao") && request.IdNavigation.RokPrijave > DateTime.Now)
            {
                throw new Exception("Status ne može biti istekao ako je rok prijave stariji od današnjeg datuma.");
            }

            entity.Status = await _context.StatusOglasis.FindAsync(request.StatusId);

            _mapper.Map(request, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Prakse>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Update");
            return list;
        }

        private async Task HandleImageUpdateAsync(Database.Prakse entity, IFormFile newImage)
        {
            if (entity.IdNavigation.Slika != null)
            {
                await _fileService.DeleteAsync(entity.IdNavigation.Slika);
            }

            var uploadResponse = await _fileService.UploadAsync(newImage);

            if (uploadResponse.Error)
            {
                throw new Exception("Greška pri uploadu slike");
            }

            entity.IdNavigation.Slika = uploadResponse.Blob.Name;
        }
    }
}