using DatabaseLibrary.DatabaseContext;
using DatabaseLibrary.Services;
using Microsoft.EntityFrameworkCore;
using System.Windows;

namespace LabWork19
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            SortedMovies();
        }

        public async void SortedMovies()
        {
            FilmService movieService = new FilmService();
            OutputDataGrid.ItemsSource = await movieService.GetAllMoviesAsync();
        }

        private void InputButton_Click(object sender, RoutedEventArgs e)
        {
            AppDbContext context = new();
            var year = Convert.ToInt32(YearTextBox.Text);
            var name = NameTextBox.Text;
            //var sortedMovies = context.Movies.FromSqlRaw("SELECT * FROM Movie WHERE ReleaseYear >= {0} AND Title LIKE '%' + {1} + '%'", year, name).ToList();
            var sortedMovies = context.Films.FromSql($"SELECT * FROM Movie WHERE ReleaseYear >= {year} AND Title LIKE '%' + {name} + '%'");
            OutputDataGrid.ItemsSource = sortedMovies.ToList();
        }
    }
}