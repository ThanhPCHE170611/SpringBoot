using Microsoft.EntityFrameworkCore;
using NewwaveDesignProject.Cores.MVVM.Models;
using System.Linq.Expressions;

namespace NewwaveDesignProject.Cores.MVVM.Repository
{
    public interface IRepository<T> where T : Entity
    {
        Task<T> Get(int id);
        Task<IEnumerable<T>> GetAll(Expression<Func<T, bool>> filter = null);
        Task<IEnumerable<T>> GetAllIncludeProperty(Expression<Func<T, bool>> filter = null, string includeProperties = "");
        Task<IEnumerable<T>> GetAllIncludeRelated(Expression<Func<T, bool>> filter = null, params Expression<Func<T, object>>[] includes);

        Task<IEnumerable<T>> GetAllIncludeDeleted(Expression<Func<T, bool>> filter = null);
        Task<T> GetFirstItem(Expression<Func<T, bool>> filter);
        Task<T> InsertAsync(T entity);
        Task<bool> InsertManyAsync(IEnumerable<T> entities);
        Task<bool> UpdateAsync(T entity);
        Task<bool> DeleteAsync(int id);
        void BeginTransaction();
        void CommitTransaction();
        void RollbackTransaction();
        DbContext GetContext();
        DbContext ReloadContext();
    }
}
