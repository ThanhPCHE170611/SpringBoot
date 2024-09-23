using Microsoft.EntityFrameworkCore;
using NewwaveDesignProject.Cores.MVVM.Data;
using NewwaveDesignProject.Cores.MVVM.Models;
using System.Linq.Expressions;

namespace NewwaveDesignProject.Cores.MVVM.Repository
{
    public class Repository<T> : IRepository<T> where T : Entity
    {
        public DashBankDbContext _dbContext;

        public Repository(DashBankDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<T> InsertAsync(T entity)
        {
            //entity.CreatedDate = DateTime.Now;
            //entity.LastModifiedDate = DateTime.Now;
            //entity.IsDeleted = false;
            //entity.DeletedDate = null;

            _dbContext.Set<T>().Add(entity);
            var rowCount = await _dbContext.SaveChangesAsync();

            return rowCount > 0 ? entity : null;
        }

        public async Task<bool> InsertManyAsync(IEnumerable<T> entities)
        {
            //foreach (var entity in entities)
            //{
            //	entity.CreatedDate = DateTime.Now;
            //	entity.LastModifiedDate = DateTime.Now;
            //	entity.IsDeleted = false;
            //	entity.DeletedDate = null;
            //}

            _dbContext.Set<T>().AddRange(entities);
            var rowCount = await _dbContext.SaveChangesAsync();
            return rowCount > 0;
        }

        public async Task<T> Get(int id)
        {
            return await _dbContext.Set<T>().SingleOrDefaultAsync(p => p.Id == id);
        }

        public async Task<bool> UpdateAsync(T entity)
        {
            var dbEntity = await _dbContext.Set<T>().FindAsync(entity.Id);
            if (dbEntity == null)
                return false;

            //entity.LastModifiedDate = DateTime.Now;
            _dbContext.Entry(dbEntity).CurrentValues.SetValues(entity);
            var rowCount = await _dbContext.SaveChangesAsync();
            return rowCount > 0;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var entity = await Get(id);
            if (entity != null)
            {
                //entity.IsDeleted = true;
                //entity.DeletedDate = DateTime.Now;
                var rowCount = await _dbContext.SaveChangesAsync();
                return rowCount > 0;
            }

            return true;
        }

        public async Task<IEnumerable<T>> GetAll(Expression<Func<T, bool>> filter = null)
        {
            //var query = _dbContext.Set<T>().Where(i => !i.IsDeleted).AsNoTracking();
            var query = _dbContext.Set<T>().AsNoTracking();
            query = filter != null ? query.Where(filter) : query;
            return await query.ToListAsync();
        }
        public async Task<IEnumerable<T>> GetAllIncludeProperty(Expression<Func<T, bool>> filter = null, string includeProperties = "")
        {
            IQueryable<T> query = _dbContext.Set<T>().AsNoTracking();

            if (filter != null)
            {
                query = query.Where(filter);
            }

            if (!string.IsNullOrEmpty(includeProperties))
            {
                foreach (var includeProperty in includeProperties.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
                {
                    query = query.Include(includeProperty);
                }
            }

            return await query.ToListAsync();
        }
        public async Task<IEnumerable<T>> GetAllIncludeRelated(Expression<Func<T, bool>> filter = null, params Expression<Func<T, object>>[] includes)
        {
			IQueryable<T> query = _dbContext.Set<T>().AsNoTracking();
                
			if (filter != null )
			{
					query = query.Where(filter);			}

			if (includes != null && includes.Any())
			{
				foreach (var include in includes)
				{
					query = query.Include(include);
				}
			}

			return await query.ToListAsync();


		}

        public async Task<T> GetFirstItem(Expression<Func<T, bool>> filter)
        {
            var query = _dbContext.Set<T>();
            return await query.Where(filter).FirstOrDefaultAsync();
        }

        public async Task<IEnumerable<T>> GetAllIncludeDeleted(Expression<Func<T, bool>> filter = null)
        {
            var query = filter != null ? _dbContext.Set<T>().Where(filter) : _dbContext.Set<T>();
            return await query.ToListAsync();
        }

        public DbContext GetContext()
        {
            return _dbContext;
        }

        public void BeginTransaction()
        {
            // Implement transaction logic here
        }

        public void CommitTransaction()
        {
            // Implement transaction logic here
        }

        public void RollbackTransaction()
        {
            // Implement transaction logic here
        }

        public DbContext ReloadContext()
        {
            _dbContext.Dispose();
            _dbContext = new DashBankDbContext();
            return _dbContext;
        }
    }
}


