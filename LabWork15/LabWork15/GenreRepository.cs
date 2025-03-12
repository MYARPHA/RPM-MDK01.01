namespace LabWork15
{
    public class GenreRepository : IRepository<Genre>
    {
        private readonly DatabaseContext _dbContext;

        public GenreRepository(DatabaseContext dbContext)
        {
            _dbContext = dbContext;
        }

        public Task<int> AddAsync(Genre entity)
        {
            throw new NotImplementedException();
        }

        public Task DeleteAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Genre>> GetAllAsync()
        {
            throw new NotImplementedException();
        }

        public Task<Genre> GetByIdAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task UpdateAsync(Genre entity)
        {
            throw new NotImplementedException();
        }
    }
}
