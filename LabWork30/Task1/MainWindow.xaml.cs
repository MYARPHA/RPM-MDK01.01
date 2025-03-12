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

        private void LoginCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            SubscribeButton.IsEnabled = true;
        }

        private void LoginCheckBox_Unchecked(object sender, RoutedEventArgs e)
        {
            SubscribeButton.IsEnabled = false;
        }
    }
}