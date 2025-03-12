using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Task1
{
    /// <summary>
    /// Логика взаимодействия для SettingsWindow.xaml
    /// </summary>
    public partial class SettingsWindow : Window
    {
        public SettingsWindow()
        {
            InitializeComponent();
            loginTextBox.Text = Properties.Settings.Default.login;
            passwordTextBox.Text = Properties.Settings.Default.password;
            emailTextBox.Text = Properties.Settings.Default.email;
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            Properties.Settings.Default.login = loginTextBox.Text;
            Properties.Settings.Default.password = passwordTextBox.Text;
            Properties.Settings.Default.email = emailTextBox.Text;
            Properties.Settings.Default.Save();
        }
    }
}
