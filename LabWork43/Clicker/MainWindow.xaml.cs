using System.Windows;
using System.Windows.Threading;

namespace Clicker
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        DispatcherTimer timer = new(DispatcherPriority.Render);
        int cookie = 0;
        int grandmother = 0;
        int price = 15;

        public MainWindow()
        {
            InitializeComponent();

            timer.Tick += Timer_Tick;
            timer.Interval = new TimeSpan(0, 0, 0, 0, 1000);
            timer.Start();
            imageGrandmother.IsEnabled = false;
            imageGrandmother.Opacity = 0.5;
        }

        void Timer_Tick(object? sender, EventArgs e)
        {
            cookie++;
            timerLabel.Content = cookie;
            imageGrandmother.IsEnabled = cookie >= price;
            imageGrandmother.Opacity = (cookie >= price) ? 1 : 0.5;
        }

        private void ImageCookie_MouseDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            ChangeCookieCount();
        }

        private void ImageGrandmother_MouseDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            ChangeCookieCount(-price);

            grandmother = grandmother + 1;
            grandmotherLabel.Content = grandmother;
            timer.Interval = new TimeSpan(0, 0, 0, 0, 1000 / (grandmother + 1));
            timer.Start();
        }

        private void Ellipse_MouseDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            ChangeCookieCount();
        }

        private void ChangeCookieCount(int count = 1)
        {
            cookie += count;
            timerLabel.Content = cookie;
            imageGrandmother.IsEnabled = cookie >= price;
            imageGrandmother.Opacity = (cookie >= price) ? 1 : 0.5;
        }
    }
}