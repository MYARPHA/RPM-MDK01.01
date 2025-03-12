using System.Configuration;
using System.Windows;
using System.IO;

namespace Task3
{
    /// <summary>
    /// Логика взаимодействия для SettingsWindow.xaml
    /// </summary>
    public partial class SettingsWindow : Window
    {
        public SettingsWindow()
        {
            InitializeComponent();
            string[] lines = File.ReadAllLines("userData.txt");
            loginTextBox.Text = lines[0];
            passwordTextBox.Text = lines[1];
            emailTextBox.Text = lines[2];
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            File.WriteAllLines("userData.txt", [loginTextBox.Text, passwordTextBox.Text, emailTextBox.Text]);

        }
    }
}
