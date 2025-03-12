using DatabaseLibrary.Data;
using DatabaseLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace DatabaseLibrary
{
    public class VisitorService 
    {
        private readonly GameStoreContext _context;

        public VisitorService(GameStoreContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Visitor>> GetAllVisitorsAsync()
        {
            return await _context.Visitors.ToListAsync();
        }

        public async Task<Visitor> GetVisitorByIdAsync(int id)
        {
            return await _context.Visitors.FindAsync(id);
        }
    }
}
