using System.Configuration;
using System.Windows;

namespace Task2
{
    /// <summary>
    /// Логика взаимодействия для SettingsWindow.xaml
    /// </summary>
    public partial class SettingsWindow : Window
    {

        public SettingsWindow()
        {
            InitializeComponent();
            var config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            loginTextBox.Text = config.AppSettings.Settings["login"].Value;
            passwordTextBox.Text = config.AppSettings.Settings["password"].Value;
            emailTextBox.Text = config.AppSettings.Settings["email"].Value;
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            var config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            config.AppSettings.Settings["login"].Value = loginTextBox.Text;
            config.AppSettings.Settings["password"].Value = passwordTextBox.Text;
            config.AppSettings.Settings["email"].Value = emailTextBox.Text;
            config.Save();
            ConfigurationManager.RefreshSection("appSettings");
        }
    }
}
