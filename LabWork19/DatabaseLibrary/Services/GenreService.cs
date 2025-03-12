using DatabaseLibrary.DatabaseContext;
using DatabaseLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace DatabaseLibrary.Services
{
    public class GenreService
    {
        public async Task GetGenreByIdAsync(int id)
        {
            using var context = new AppDbContext();
            var genre = await context.Genres.FindAsync(id);
            Console.WriteLine($"{genre.GenreId} {genre.GenreName}");
        }

        public async Task<List<Genre>> GetAllGenresAsync()
        {
            using var context = new AppDbContext();
            return await context.Genres.ToListAsync();
        }
    }
}
