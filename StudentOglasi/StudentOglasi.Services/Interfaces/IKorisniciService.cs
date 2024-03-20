using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Interfaces
{
    public interface IKorisniciService : ICRUDService<Model.Korisnik, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        public Task<Model.Korisnik> Login(string username, string password);
    }
}
