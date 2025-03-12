using System.IO;
using System.Windows;

namespace Task1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public int currentPage = 1;
        public int pageSize = 5;


        public MainWindow()
        {
            InitializeComponent();
            ShowFiles();
        }

        private void ShowFiles()
        {
            DirectoryInfo directory = new(@"X:\ОПБД");
            var files = directory.GetFiles("*", SearchOption.AllDirectories)
                .Select(files => new
                {
                    files.Name,
                    files.Extension,
                    files.FullName,
                    files.Length,
                    files.CreationTime
                })
                .OrderBy(files => files.FullName)
                .Take(pageSize * currentPage);

            fileDataGrid.ItemsSource = files;

            pagesCountLabel.Content = $"Показано {files.Count()} из {directory.GetFiles("*", SearchOption.AllDirectories).Count()} записей";
        }

        private void ShowMoreButton_Click(object sender, RoutedEventArgs e)
        {
            currentPage++;
            ShowFiles();
        }

        private void CountPageTextBox_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
        {
            Int32.TryParse(countPageTextBox.Text, out pageSize);
            currentPage = 1;
            ShowFiles();
        }
    }
}