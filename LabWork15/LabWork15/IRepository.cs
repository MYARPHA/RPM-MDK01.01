namespace LabWork15
{
    public interface IRepository<T> where T : class
    {
        Task<T> GetByIdAsync(int id);
        Task<IEnumerable<T>> GetAllAsync();
        Task<int> AddAsync(T entity); // добавляет то что указано в параметрах
        Task UpdateAsync(T entity);
        Task DeleteAsync(int id);
    }
}
