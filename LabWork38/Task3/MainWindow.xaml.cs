using System.IO;
using System.Windows;
using System.Windows.Controls;

namespace Task3
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public int pageSize = 5;
        public int currentPage = 1;

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
                .Skip(pageSize * (currentPage - 1))
                .Take(pageSize);

            fileDataGrid.ItemsSource = files;

            navigateTextBox.Text = currentPage.ToString();
        }

        private void NavigateTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            Int32.TryParse(navigateTextBox.Text, out currentPage);
            ShowFiles();
        }
    }

}