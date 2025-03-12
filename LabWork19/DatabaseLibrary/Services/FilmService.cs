using DatabaseLibrary.DatabaseContext;
using DatabaseLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace DatabaseLibrary.Services
{
    public class FilmService
    {
        public async Task GetFilmByIdAsync(int id)
        {
            using var context = new AppDbContext();
            var film = await context.Films.FindAsync(id);
            Console.WriteLine($"{film.MovieId} {film.Title} {film.Duration} {film.AgeRating}");
        }

        public async Task<List<Movie>> GetAllMoviesAsync()
        {
            using var context = new AppDbContext();
            return await context.Films.ToListAsync();
        }
    }
}
