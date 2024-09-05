using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.Services;

namespace StudentOglasi.Services.StateMachines.PrakseStateMachine
{
    public class InitialPraksaState : BasePrakseState
    {
        public readonly FileService _fileService;

        public readonly ObavijestiService _obavijestiService;
        public InitialPraksaState(IServiceProvider serviceProvider, StudentoglasiContext context, FileService fileService, IMapper mapper, ObavijestiService obavijestiService) : base(serviceProvider, context, mapper)
        {
            _obavijestiService = obavijestiService;
            _fileService = fileService;
        }
        public override async Task<Model.Prakse> Insert(PrakseInsertRequest request)
        {
            var set = _context.Set<Prakse>();

            var entity = _mapper.Map<Prakse>(request);

            if (request.Slika != null)
            {
                var uploadResponse = await _fileService.UploadAsync(request.Slika);
                if (!uploadResponse.Error)
                {
                    entity.IdNavigation.Slika = uploadResponse.Blob.Name;
                }
                else
                {
                    throw new Exception("Greška pri uploadu slike");
                }
            }

            entity.Status = await _context.StatusOglasis.FirstOrDefaultAsync(e => e.Naziv.Contains("Draft"));
            entity.StatusId = entity.Status.Id;
            set.Add(entity);

            await _context.SaveChangesAsync();
            string title = entity.IdNavigation.Naslov;
            await _obavijestiService.SendNotificationOglasi("Novosti: Stipendije", title, entity.IdNavigation.Id, "success");
            return _mapper.Map<Model.Prakse>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Insert");
            return list;
        }
    }
}