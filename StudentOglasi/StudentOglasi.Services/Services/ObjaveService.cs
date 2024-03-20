using AutoMapper;
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
        public ObjaveService(StudentoglasiContext context, IMapper mapper): base(context, mapper)
        {
        }
        public override async Task BeforeInsert(Database.Objave entity, ObjaveInsertRequest insert)
        {
            entity.VrijemeObjave = DateTime.Now;
        }

    }
}
