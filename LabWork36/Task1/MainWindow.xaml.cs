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

        private void NewWindowItem_Click(object sender, RoutedEventArgs e)
        {
            MainWindow window = new();
            window.Show();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            Hide();
            ConfirmationWindow confirmationWindow = new();

            confirmationWindow.Owner = this;
            confirmationWindow.WindowStartupLocation = WindowStartupLocation.CenterOwner;

            if (confirmationWindow.ShowDialog().Value == true)
                return;
            e.Cancel = true;
            Show();
        }
    }
}