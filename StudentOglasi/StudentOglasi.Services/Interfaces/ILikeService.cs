using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Interfaces
{
    public interface ILikeService
    {
        Task<Like> LikeItem(Like likeDto);
        Task UnlikeItem(Like likeDto);
        Task<bool> IsLiked(int userId, int itemId, string itemType);
        Task<List<Like>> GetUserLikes(string username);
        Task<List<LikeCount>> GetAllLikesCount();
    }
}
