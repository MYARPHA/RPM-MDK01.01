using System.Windows;
using System.Windows.Controls;
using Microsoft.Win32;
using System.IO;

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

        private void OpenButton_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dialog = new();
            dialog.Filter = "All Files|*.*|Text file|*.txt|Source Code File|*.cs|HTML File|*.html|Cascading Style Sheets|*.css|Java Script file|*.js|MySQL File|*.sql";

            if (dialog.ShowDialog().Value != true)
                return;
            string fileName = dialog.FileName;
            OpenTextBox.Text = File.ReadAllText(fileName);
            Title = dialog.SafeFileName;
        }
    }
}