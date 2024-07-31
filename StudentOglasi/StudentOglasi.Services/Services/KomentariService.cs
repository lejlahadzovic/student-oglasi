using AutoMapper;
using Azure.Core;
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
    public class KomentariService : IKomentariService
    {
        protected StudentoglasiContext _context;
        protected IMapper _mapper { get; set; }
        public KomentariService(StudentoglasiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Komentari> Insert(KomentarInsertRequest insert)
        {
            var komentar = _mapper.Map<Database.Komentari>(insert);
            komentar.VrijemeObjave = DateTime.Now;

            _context.Komentaris.Add(komentar);
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Komentari>(komentar);
        }

        public async Task<List<Model.Komentari>> GetCommentsByPost(int postId, string postType)
        {
            var komentari = await _context.Komentaris
            .Where(c => c.PostId == postId && c.PostType == postType)
            .Include(c => c.Korisnik)
            .Include(c => c.InverseParentKomentar)
            .ToListAsync();

            var rootKomentari = komentari
                .Where(c => !c.ParentKomentarId.HasValue)
                .ToList();

            return _mapper.Map<List<Model.Komentari>>(rootKomentari);
        }
    }
}
