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
            if (Properties.Settings.Default.login == loginTextBox.Text && Properties.Settings.Default.password == passwordTextBox.Text)
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
