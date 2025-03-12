using DatabaseLibrary.DatabaseContext;
using DatabaseLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace DatabaseLibrary.Services
{
    public class VisitorService
    {
        public async Task GetVisitorByIdAsync(int id)
        {
            using var context = new AppDbContext();
            var visitor = await context.Visitors.FindAsync(id);
            Console.WriteLine($"{visitor.VisitorId} {visitor.Name} {visitor.Email}");
        }

        public async Task<List<Visitor>> GetAllVisitorsAsync()
        {
            using var context = new AppDbContext();
            return await context.Visitors.ToListAsync();
        }
    }
}
