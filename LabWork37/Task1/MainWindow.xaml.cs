using System.IO;
using System.Windows;

namespace Task1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

        }

        private void ShowFiles(string filePath)
        {
            DirectoryInfo directory = new(filePath);
            if (directory.Exists)
            {
                FileInfo[] files = directory.GetFiles("*", SearchOption.AllDirectories);
                resultDataGrid.ItemsSource = files.Select(files => new
                {
                    files.Name,
                    files.Extension,
                    files.FullName,
                    files.Length,
                    files.CreationTime,
                    files.LastWriteTime,
                }).ToList();
            }
            else
            {
                warningLabel.Visibility = Visibility.Visible;
            }
        }

        private void ClearButton_Click(object sender, RoutedEventArgs e)
        {
            
            //fileNameTextBox.Clear();
        }

        private void FileSearchTextBox_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
        {
            ShowFiles(directoryTextBox.Text);
        }
    }
}