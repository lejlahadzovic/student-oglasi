using AutoMapper;
using Azure.Core;
using Microsoft.EntityFrameworkCore;
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
    public class OcjeneService : IOcjeneService
    {
        protected StudentoglasiContext _context;
        protected IMapper _mapper { get; set; }
        public OcjeneService(StudentoglasiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Ocjene> Insert(Model.Ocjene insert)
        {
            var ocjena = await _context.Ocjenes
                .FirstOrDefaultAsync(o => o.PostId == insert.PostId && o.PostType == insert.PostType && o.StudentId == insert.StudentId);

            if (ocjena != null)
            {
                ocjena.Ocjena = insert.Ocjena;
                _context.Ocjenes.Update(ocjena);
            }
            else
            {
                ocjena = _mapper.Map<Database.Ocjene>(insert);
                _context.Ocjenes.Add(ocjena);
            }

            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Ocjene>(ocjena);
        }

        public async Task<decimal> GetAverageOcjena(int postId, string postType)
        {
            var averageOcjena = await _context.Ocjenes
                .Where(o => o.PostId == postId && o.PostType == postType)
                .AverageAsync(o => (decimal?)o.Ocjena);

            return averageOcjena ?? 0; 
        }

        public async Task<List<OcjenaAverage>> GetAverageOcjenaByPostType(string postType)
        {
            var averages = await _context.Ocjenes
                .Where(o => o.PostType == postType)
                .GroupBy(o => o.PostId)
                .Select(g => new OcjenaAverage
                {
                    PostId = g.Key,
                    AverageOcjena = g.Average(o => o.Ocjena)
                })
                .ToListAsync();

            return averages;
        }

        public async Task<Model.Ocjene> GetUserOcjena(int postId, string postType, int userId)
        {
            var ocjena = await _context.Ocjenes
                .FirstOrDefaultAsync(o => o.PostId == postId && o.PostType == postType && o.StudentId == userId);

            if (ocjena == null)
            {
                return new Model.Ocjene
                {
                    PostId = postId,
                    PostType = postType,
                    StudentId = userId,
                    Ocjena = 0
                };
            }

            return _mapper.Map<Model.Ocjene>(ocjena);
        }
    }
}
