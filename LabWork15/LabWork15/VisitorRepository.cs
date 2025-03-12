using Dapper;

namespace LabWork15
{
    public class VisitorRepository : IRepository<Visitor>
    {
        private readonly DatabaseContext _dbContext;

        public VisitorRepository(DatabaseContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<int> AddAsync(Visitor entity)
        {
            string query = "INSERT INTO Visitor(PhoneNumber) VALUES(@PhoneNumber); SELECT SCOPE_IDENTITY()";
            using var connection = _dbContext.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(query, entity);
        }

        public Task DeleteAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Visitor>> GetAllAsync()
        {
            throw new NotImplementedException();
        }

        public Task<Visitor> GetByIdAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task UpdateAsync(Visitor entity)
        {
            throw new NotImplementedException();
        }
    }
}
