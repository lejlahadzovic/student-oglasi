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
            CreateMap<Database.Stipenditori, Model.Stipenditori>();
            CreateMap<Database.Organizacije, Model.Organizacije>();
            CreateMap<Database.StatusOglasi, Model.StatusOglasi>();
            CreateMap<Database.Prakse, Model.Prakse>();
            CreateMap<PrakseInsertRequest, Database.Prakse>();
            CreateMap<PrakseUpdateRequest, Database.Prakse>();
            CreateMap<Database.Oglasi, Model.Oglasi>();
            CreateMap<Model.Oglasi, Database.Oglasi>();
            CreateMap<Database.Stipendije, Model.Stipendije>();
            CreateMap<StipendijeInsertRequest, Database.Stipendije>();
            CreateMap<StipendijeUpdateRequest, Database.Stipendije>();
            CreateMap<Database.Objave, Model.Objave>();
            CreateMap<Database.Kategorija, Model.Kategorija>();
            CreateMap<Model.Requests.ObjaveInsertRequest, Database.Objave>();
            CreateMap<Model.Requests.ObjaveUpdateRequest, Database.Objave>()
                .ForMember(dest => dest.Slika, opt => opt.Ignore())
                .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;
        }
    }
}
