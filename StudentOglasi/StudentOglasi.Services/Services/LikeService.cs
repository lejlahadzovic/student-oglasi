using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
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
    public class LikeService : ILikeService
    {
        protected StudentoglasiContext _context;
        protected IMapper _mapper { get; set; }
        public LikeService(StudentoglasiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Like> LikeItem(Model.Like likeRequest)
        {
            var like = _mapper.Map<Database.Like>(likeRequest);

            _context.Likes.Add(like);
            await _context.SaveChangesAsync();

            return likeRequest;
        }

        public async Task UnlikeItem(Model.Like likeRequest)
        {
            var like = await _context.Likes
                .FirstOrDefaultAsync(l => l.KorisnikId == likeRequest.KorisnikId && l.ItemId == likeRequest.ItemId && l.ItemType == likeRequest.ItemType);

            if (like != null)
            {
                _context.Likes.Remove(like);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> IsLiked(int userId, int itemId, string itemType)
        {
            var like = await _context.Likes
                .FirstOrDefaultAsync(l => l.KorisnikId == userId && l.ItemId == itemId && l.ItemType == itemType);

            return like != null;
        }

        public async Task<List<Model.Like>> GetUserLikes(string username)
        {
            var user = await _context.Korisnicis
                .FirstOrDefaultAsync(u => u.KorisnickoIme == username);

            if (user == null)
            {
                throw new Exception("User not found");
            }

            var likes = await _context.Likes
                .Where(l => l.KorisnikId == user.Id)
                .ToListAsync();

            return _mapper.Map<List<Model.Like>>(likes);
        }

        public async Task<List<LikeCount>> GetAllLikesCount()
        {
            var likesCount = await _context.Likes
                .GroupBy(l => new { l.ItemId, l.ItemType })
                .Select(group => new LikeCount
                {
                    ItemId = group.Key.ItemId,
                    ItemType = group.Key.ItemType,
                    Count = group.Count()
                })
                .ToListAsync();

            return likesCount;
        }
    }
}
