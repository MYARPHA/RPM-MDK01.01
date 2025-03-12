using Microsoft.Win32;
using System.Windows;

namespace LabWork21
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
        private string _selectFilePath;
        public string SelectFilePath
        {
            get => _selectFilePath;
            set
            {
                _selectFilePath = value;
            }
        }


        private void SelectButton_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new OpenFileDialog
            {
                Filter = "Image files (*.jpg, *.png|*.jpg;*.png|All Files(*.*)|*.*)"
            };

            if (dialog.ShowDialog() == true)
            {
                SelectFilePath = dialog.FileName;
            }

        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}