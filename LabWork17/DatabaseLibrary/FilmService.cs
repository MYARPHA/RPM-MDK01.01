using DatabaseLibrary.Data;
using DatabaseLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace DatabaseLibrary
{
    public class FilmService
    {
        private readonly GameStoreContext _context;

        public FilmService(GameStoreContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Film>> GetAllFilmsAsync()
        {
            return await _context.Films.ToListAsync();
        }

        public async Task<Film> GetFilmByIdAsync(int id)
        {
            return await _context.Films.FindAsync(id);
        }
    }
}
