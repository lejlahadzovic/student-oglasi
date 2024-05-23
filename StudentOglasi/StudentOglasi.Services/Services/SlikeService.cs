using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.BlobModels;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Services
{
    public class SlikeService : ISlikeService
    {
        private readonly FileService _fileService;
        private readonly StudentoglasiContext _context;
        private readonly IMapper _mapper;
        public SlikeService(FileService fileService, StudentoglasiContext context, IMapper mapper)
        {
            _fileService = fileService;
            _context = context;
            _mapper = mapper;
        }

        public async Task<bool> Delete(int id)
        {
            var slika = await _context.Slikes.FindAsync(id);
            if (slika == null)
            {
                return false;
            }

            var deleteResult = await _fileService.DeleteAsync(slika.Naziv);

            if (deleteResult.Error)
            {
                throw new Exception(deleteResult.Status);
            }

            _context.Slikes.Remove(slika);
            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<Model.Slike> Upload(SlikeInsertRequest image)
        {
            var uploadResult = await _fileService.UploadAsync(image.Slika);

            if (uploadResult.Error)
            {
                throw new Exception(uploadResult.Status);
            }

            var novaSlika = _mapper.Map<Database.Slike>(image);
            novaSlika.Naziv = uploadResult.Blob.Name;

            _context.Slikes.Add(novaSlika);
            await _context.SaveChangesAsync();

            await _context.Entry(novaSlika).ReloadAsync();
            return _mapper.Map<Model.Slike>(novaSlika);
        }
    }
}
