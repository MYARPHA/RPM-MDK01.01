using System.Windows;
using System.Windows.Controls;

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
            DatePicker.DisplayDateEnd = DateTime.Now;
        }

        private void RegistrateButton_Click(object sender, RoutedEventArgs e)
        {
            if (LoginTextBox.Text != string.Empty && AboutTextBox.Text != string.Empty && PasswordBox.Password == ConfirmPasswordBox.Password)
                MessageBox.Show($"{LoginTextBox.Text}, you have successfuly registered!");
        }

        private void DatePicker_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            var age = (int)(DateTime.Today.Year - DatePicker.SelectedDate?.Year);
            age -= DateTime.Today.AddYears(age) <= DatePicker.SelectedDate ? 0 : 1;
            DateOfBirthLabel.Content = age.ToString();
        }
    }
}