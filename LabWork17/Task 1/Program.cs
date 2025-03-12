using DatabaseLibrary.Data;
using DatabaseLibrary;
using DatabaseLibrary.Models;

GameStoreContext context = new();
var visitorService = new VisitorService(context);
var ticketService = new TicketService(context);
var filmService = new FilmService(context);
var genreService = new GenreService(context);

// Получение имени поситителя 
var visitor = await visitorService.GetVisitorByIdAsync(1);
Console.WriteLine($"Имя поситителя: {visitor.Name}");

// Все поситители
var allVisitors = await visitorService.GetAllVisitorsAsync();
foreach (var visitors in allVisitors)
{
    Console.WriteLine($"Список поситителей: {visitors.VisitorId} {visitors.Name}");
}


// Получение Id билета
var ticket = await ticketService.GetTicketByIdAsync(5);
Console.WriteLine($"Id билета: {ticket.TicketId}");

// Получение всех билетов
var allTickets = await ticketService.GetAllTicketsAsync();
foreach (var tickets in allTickets)
{
    Console.WriteLine($"Список билетов: {tickets.TicketId}");
}

//// Получение Id жанра
//var genre = await genreService.GetGenreByIdAsync(1);
//Console.WriteLine($"Id жанра: {genre.Genre1}");

//// Получение всех жанров
//var allGenres = await genreService.GetAllGenresAsync();
//Console.WriteLine($"Общее количество: {allGenres.Count()}");

// Получение название фильма
var film = await filmService.GetFilmByIdAsync(2);
Console.WriteLine($"Id фильма: {film.FilmTitle}");

// Получение всех фильмов
var allFilms = await filmService.GetAllFilmsAsync();
foreach (var films in allFilms)
{
    Console.WriteLine($"{films.FilmId} {films.FilmTitle}");
}