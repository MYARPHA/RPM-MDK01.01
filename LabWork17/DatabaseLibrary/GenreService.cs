using DatabaseLibrary.Data;
using DatabaseLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace DatabaseLibrary
{
    public class GenreService
    {
        private readonly GameStoreContext _context;

        public GenreService(GameStoreContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Genre>> GetAllGenresAsync()
        {
            return await _context.Genres.ToListAsync();
        }

        public async Task<Genre> GetGenreByIdAsync(int id)
        {
            return await _context.Genres.FindAsync(id);
        }
    }
}
