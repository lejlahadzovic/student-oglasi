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
    public interface IOcjeneService
    {
        Task<Model.Ocjene> Insert(Model.Ocjene insert);
        Task<decimal> GetAverageOcjena(int postId, string postType);
        Task<List<OcjenaAverage>> GetAverageOcjenaByPostType(string postType);
        Task<Model.Ocjene> GetUserOcjena(int postId, string postType, int userId);
    }
}
