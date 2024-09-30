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
    public interface IStudentiService : ICRUDService<Studenti,StudentiSearchObject,StudentiInsertRequest,StudentiUpdateRequest>
    {
        Task<Studenti> GetStudentByUsername(string username);
        Task<bool> ChangePassword(int id, ChangePasswordRequest request);
        Task<bool> IsUsernameTaken(string username);
    }
}
