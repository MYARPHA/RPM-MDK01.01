using DatabaseLibrary.DatabaseContext;
using DatabaseLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace DatabaseLibrary.Services
{
    public class TicketService
    {
        public async Task GetTicketByIdAsync(int id)
        {
            using var context = new AppDbContext();
            var ticket = await context.Tickets.FindAsync(id);
            Console.WriteLine($"{ticket.TicketId} {ticket.Seat} {ticket.Row}");
        }

        public async Task<List<Ticket>> GetAllTicketsAsync()
        {
            using var context = new AppDbContext();
            return await context.Tickets.ToListAsync();
        }
    }
}
