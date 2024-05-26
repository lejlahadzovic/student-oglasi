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
                .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));
            CreateMap<Database.Studenti, Model.Studenti>();
            CreateMap<Database.Fakulteti, Model.Fakulteti>()
                .ForMember(dest => dest.Smjerovi, opt => opt.MapFrom(src => src.SmjeroviFakultetis.Select(sf => sf.Smjer).ToList()));
            CreateMap<Database.NacinStudiranja, Model.NacinStudiranja>();
            CreateMap<Database.Smjerovi, Model.Smjerovi>();
            CreateMap<Model.Requests.StudentiInsertRequest, Database.Studenti>();
            CreateMap<Model.Requests.StudentiUpdateRequest, Database.Studenti>();
            CreateMap<Database.Univerziteti, Model.Univerziteti>();
            CreateMap<Database.Smjestaji, Model.Smjestaji>();
            CreateMap<Model.Requests.SmjestajiInsertRequest, Database.Smjestaji>();
            CreateMap<Model.Requests.SmjestajiUpdateRequest, Database.Smjestaji>();
            CreateMap<Database.SmjestajnaJedinica, Model.SmjestajnaJedinica>();
            CreateMap<Model.Requests.SmjestajnaJedinicaInsertRequest, Database.SmjestajnaJedinica>();
            CreateMap<Model.Requests.SmjestajnaJedinicaUpdateRequest, Database.SmjestajnaJedinica>();
            CreateMap<Database.Grad, Model.Gradovi>();
            CreateMap<Database.TipSmjestaja, Model.TipSmjestaja>();
            CreateMap<Database.Slike, Model.Slike>();
            CreateMap<Model.Requests.SlikeInsertRequest, Database.Slike>()
                .ForMember(dest => dest.Naziv, opt => opt.Ignore()); ;
            CreateMap<Database.PrijaveStipendija, Model.PrijaveStipendija>();
            CreateMap<Database.PrijavePraksa, Model.PrijavePraksa>();
            CreateMap<Database.StatusPrijave, Model.StatusPrijave>();
        }
    }
}
