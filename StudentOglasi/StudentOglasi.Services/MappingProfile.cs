using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services
{
    public class MappingProfile: Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Objave, Model.Objave>();
            CreateMap<Model.Requests.ObjaveInsertRequest, Database.Objave>();
            CreateMap<Model.Requests.ObjaveUpdateRequest, Database.Objave>()
                .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;
        }
    }
}
