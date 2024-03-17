using Microsoft.EntityFrameworkCore.Metadata.Internal;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services
{
    public interface IObjaveService : ICRUDService<Objave,ObjaveSearchObject,ObjaveInsertRequest,ObjaveUpdateRequest>
    {

    }
}
