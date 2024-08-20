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
    public interface IKomentariService
    {
        Task<Komentari> Insert(KomentarInsertRequest dto);
        Task<List<Komentari>> GetCommentsByPost(int postId, string postType);
    }
}
