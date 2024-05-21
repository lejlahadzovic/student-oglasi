using Microsoft.AspNetCore.Http;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Interfaces
{
    public interface ISlikeService
    {
        Task<Slike> Upload(SlikeInsertRequest image);
        Task<bool> Delete(int id);
    }
}
