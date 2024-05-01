using AutoMapper;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace StudentOglasi.Services.Services
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
        public BaseCRUDService(StudentoglasiContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {
        }
        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _context.Set<TDb>();

            TDb entity = _mapper.Map<TDb>(insert);

            set.Add(entity);
            await BeforeInsert(entity, insert);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }
        public virtual async Task BeforeUpdate(TDb entity, TUpdate update)
        {
        }
        public virtual async Task<T> Update(int id, TUpdate update)
        {
            var set = _context.Set<TDb>();

            var entity = await set.FindAsync(id);

            await BeforeUpdate(entity, update);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }
        public virtual async Task BeforeDelete(TDb entity)
        {
        }
        public virtual async Task Delete(int id)
        {
            var set =  _context.Set<TDb>();
            var entity =await set.FindAsync(id);
            await BeforeDelete(entity);
            if (entity != null)
            {
                set.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
    }
}
