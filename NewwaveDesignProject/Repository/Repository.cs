using Microsoft.EntityFrameworkCore;
using NewwaveDesignProject.Cores.MVVM.Data;
using NewwaveDesignProject.Cores.MVVM.Models;
using System.Linq.Expressions;

namespace NewwaveDesignProject.Repository
{
    public class Repository<T> : IRepository<T> where T : Entity
    {
        protected readonly DashBankDbContext _context;
        public Repository(DashBankDbContext context)
        {
            _context = context;
        }
        public void BeginTransaction()
        {
            throw new NotImplementedException();
        }

        public void CommitTransaction()
        {
            throw new NotImplementedException();
        }

        public Task<bool> DeleteAsync(long id)
        {
            throw new NotImplementedException();
        }

        public async Task<T> Get(long id)
        {
            return await _context.Set<T>().SingleOrDefaultAsync(p => p.Id == id);
        }

        public async Task<IEnumerable<T>> GetAll(Expression<Func<T, bool>> filter = null)
        {
            var query = _context.Set<T>().AsNoTracking();
            query = filter != null ? query.Where(filter) : query;
            return await query.ToListAsync();
        }

        public async Task<IEnumerable<T>> GetAllIncludeDeleted(Expression<Func<T, bool>> filter = null)
        {
            var query = filter != null ? _context.Set<T>().Where(filter) : _context.Set<T>();
            return await query.ToListAsync();
        }

        public DbContext GetContext()
        {
            throw new NotImplementedException();
        }

        public Task<T> GetFirstItem(Expression<Func<T, bool>> filter = null)
        {
            throw new NotImplementedException();
        }

        public async Task<T> InsertAsync(T entity)
        {
            _context.Set<T>().Add(entity);
            var rowCount = await _context.SaveChangesAsync();

            return rowCount > 0 ? entity : null;
        }

        public Task<bool> InsertManyAsync(IEnumerable<T> entities)
        {
            throw new NotImplementedException();
        }

        public DbContext ReloadContext()
        {
            throw new NotImplementedException();
        }

        public void RollbackTransaction()
        {
            throw new NotImplementedException();
        }

        public Task<bool> UpdateAsync(T entity)
        {
            throw new NotImplementedException();
        }
    }
}
