using Dapper;
using static Dapper.SqlMapper;

namespace LabWork15
{
    internal class CategoryRepository : IRepository<Category>
    {
        private readonly DatabaseContext _dbContext;

        public CategoryRepository(DatabaseContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<int> AddAsync(Category entity)
        {
            // создали SQL-команду
            string query = "INSERT INTO Category(Name) VALUES(@Name); SELECT SCOPE_IDENTITY()";
            // создали подключение
            using var connection = _dbContext.CreateConnection();
            // выполнили команду
            return await connection.ExecuteScalarAsync<int>(query, entity);
        }

        public Task DeleteAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Category>> GetAllAsync()
        {
            throw new NotImplementedException();
        }

        public async Task<Category> GetByIdAsync(int id)
        {
            // создали SQL-команду
            string query = "SELECT * FROM Category WHERE CategoryId=@Id";
            // создали подключение
            using var connection = _dbContext.CreateConnection();
            // выполнили команду
            return await connection.QuerySingleOrDefaultAsync<Category>(query, new { Id = id});
        }

        public Task UpdateAsync(Category entity)
        {
            throw new NotImplementedException();
        }
    }
}
