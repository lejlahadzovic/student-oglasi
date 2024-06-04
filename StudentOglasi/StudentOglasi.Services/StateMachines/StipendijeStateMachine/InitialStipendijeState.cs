using AutoMapper;
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

namespace StudentOglasi.Services.StateMachine.StipendijeStateMachine
{
    public class InitialStipendijeState : BaseStipendijeState
    {
        public readonly FileService _fileService;
        public InitialStipendijeState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper, FileService fileService) : base(serviceProvider, context, mapper)
        {
            _fileService = fileService;
        }
        public override async Task<Model.Stipendije> Insert(StipendijeInsertRequest request)
        {
            var set = _context.Set<Database.Stipendije>();

            var entity = _mapper.Map<Database.Stipendije>(request);

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
            return _mapper.Map<Model.Stipendije>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Insert");
            return list;
        }
    }
}