using AutoMapper;
using StudentOglasi.Model.Requests;
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
            CreateMap<Database.Korisnici, Model.Korisnik>();
            CreateMap<KorisniciInsertRequest, Database.Korisnici>();
            CreateMap<KorisniciUpdateRequest, Database.Korisnici>();
            CreateMap<Database.Uloge, Model.Uloge>();
            CreateMap<Database.Objave, Model.Objave>();
            CreateMap<Model.Requests.ObjaveInsertRequest, Database.Objave>();
            CreateMap<Model.Requests.ObjaveUpdateRequest, Database.Objave>()
                .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;
        }
    }
}
