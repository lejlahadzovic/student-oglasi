using AutoMapper;
using Azure.Core;
using Azure.Storage.Blobs.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.OglasiStateMachine;
using StudentOglasi.Services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace StudentOglasi.Services.StateMachine.StipendijeStateMachine
{
    public class DraftStipendijeState : BaseStipendijeState
    {
        public readonly FileService _fileService;
        public DraftStipendijeState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper, FileService fileService) : base(serviceProvider, context, mapper)
        {
            _fileService = fileService;
        }
        public override async Task<Model.Stipendije> Update(int id, StipendijeUpdateRequest request)
        {
            var set = _context.Set<Database.Stipendije>();

            var entity = await set.Include(p => p.IdNavigation).FirstOrDefaultAsync(e => e.Id == id);

            if (entity == null)
                throw new Exception("Objekat nije pronađen");

            if (request.Slika != null)
            {
                await HandleImageUpdateAsync(entity, request.Slika);
            }

            var state = await _context.StatusOglasis.FindAsync(request.StatusId);
            if(state.Naziv.Contains("Aktivan") && request.IdNavigation.RokPrijave<DateTime.Now)
            {
                throw new Exception("Oglas ne može biti aktiviran ako je rok prijave istekao. Datum roka prijave mora biti veći od trenutnog.");
            }
            else if(state.Naziv.Contains("Istekao") && request.IdNavigation.RokPrijave > DateTime.Now)
            {
                throw new Exception("Status ne može biti istekao ako je rok prijave stariji od današnjeg datuma.");
            }

            _mapper.Map(request, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Stipendije>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Update");
            return list;
        }

        private async Task HandleImageUpdateAsync(Database.Stipendije entity, IFormFile newImage)
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