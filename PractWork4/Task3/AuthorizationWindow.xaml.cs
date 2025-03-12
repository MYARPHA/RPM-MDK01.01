using System.Configuration;
using System.Windows;
using System.IO;

namespace Task3
{
    /// <summary>
    /// Логика взаимодействия для AuthorizationWindow.xaml
    /// </summary>
    public partial class AuthorizationWindow : Window
    {
        public AuthorizationWindow()
        {
            InitializeComponent();
        }

        private void AuthorizationButton_Click(object sender, RoutedEventArgs e)
        {
            string[] lines = File.ReadAllLines("userData.txt");

            if (lines[0] == loginTextBox.Text && lines[1] == passwordTextBox.Text)
            {
                SettingsWindow settingsWindow = new SettingsWindow();
                settingsWindow.Show();
            }
            else
            {
                MessageBox.Show("Некорректные данные!");
            }
        }
    }
}
