using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Services
{
    public class KorisniciService : BaseCRUDService<Korisnik, Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>,IKorisniciService
    {
        public KorisniciService(StudentoglasiContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override async Task BeforeInsert(Korisnici entity, KorisniciInsertRequest insert)
        {
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.Password);

            entity.Uloga = _context.Uloges.SingleOrDefault(x => x.Naziv == "Student")!;

            if (entity.Uloga == null)
            {
                throw new Exception("Uloga 'Student' ne postoji u bazi podataka.");
            }

            entity.UlogaId = entity.Uloga.Id; 
        }
        public override Task<Korisnik> Insert(KorisniciInsertRequest insert)
        {
            return base.Insert(insert);
        }
        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);
            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];
            Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);
            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public override IQueryable<Korisnici> AddInclude(IQueryable<Korisnici> query, KorisniciSearchObject? search = null)
        {
            if (search?.IsUlogeIncluded == true)
            {
                query = query.Include("Uloga");
            }
            return base.AddInclude(query, search);
        }
        public async Task<Korisnik> Login(string username, string password)
        {
            var entity = await _context.Korisnicis.Include("Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == username);
            if (entity == null)
            {
                return null;
            }
            var hash = GenerateHash(entity.LozinkaSalt, password);
            if (hash != entity.LozinkaHash)
            {
                return null;
            }
            return _mapper.Map<Korisnik>(entity);
        }
        public bool VerifyPassword(string inputPassword, string storedHash, string storedSalt)
        {
            var hash = GenerateHash(storedSalt, inputPassword);
            return hash == storedHash;
        }
    }
}
