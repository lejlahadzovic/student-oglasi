using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
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
    public class ObjaveService : BaseCRUDService<Model.Objave, Database.Objave, ObjaveSearchObject, ObjaveInsertRequest, ObjaveUpdateRequest>, IObjaveService
    {
        public readonly FileService _fileService;
        public ObjaveService(StudentoglasiContext context, IMapper mapper, FileService fileService) : base(context, mapper)
        {
            _fileService = fileService;
        }
        public override async Task BeforeInsert(Database.Objave entity, ObjaveInsertRequest insert)
        {
            entity.VrijemeObjave = DateTime.Now;
            if (insert.Slika != null)
            {
                var uploadResponse = await _fileService.UploadAsync(insert.Slika);
                if (!uploadResponse.Error)
                {
                    entity.Slika = uploadResponse.Blob.Name;
                }
                else
                {
                    throw new Exception("Greška pri uploadu slike");
                }
            }
        }
        public override async Task BeforeDelete(Database.Objave entity)
        {
            if (entity.Slika != null)
            {
                try
                {
                    await _fileService.DeleteAsync(entity.Slika);
                }
                catch (Exception ex)
                {
                    throw new Exception("Greška pri brisanju slike.", ex);
                }
            }
        }
        public override async Task BeforeUpdate(Database.Objave entity, ObjaveUpdateRequest update)
        {
            if(update.Slika != null)
            {
                if (entity.Slika != null)
                {
                    await _fileService.DeleteAsync(entity.Slika);
                }

                var uploadResponse = await _fileService.UploadAsync(update.Slika);

                if (!uploadResponse.Error)
                {
                    entity.Slika = uploadResponse.Blob.Name;
                }
                else
                {
                    throw new Exception("Greška pri uploadu slike");
                }
            }
        }
        public override IQueryable<Database.Objave> AddFilter(IQueryable<Database.Objave> query, ObjaveSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naslov))
            {
                filteredQuery = filteredQuery.Where(x => x.Naslov.Contains(search.Naslov));
            }
            if(search?.KategorijaID!= null)
            {
                filteredQuery = filteredQuery.Where(x => x.KategorijaId == search.KategorijaID);
            }

            return filteredQuery;
        }
        public override IQueryable<Database.Objave> AddInclude(IQueryable<Database.Objave> query, ObjaveSearchObject? search = null)
        {
            return base.AddInclude(query.Include("Kategorija"), search);
        }
    }
}
