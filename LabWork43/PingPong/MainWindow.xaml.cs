using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace PingPong
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Timer timer = new();

        double racketSpeed = 5;
        double ballSpeedX = 3;
        double ballSpeedY = 3;  
        public MainWindow()
        {
            InitializeComponent();

            Canvas.SetBottom(racket, 10);
            Canvas.SetLeft(racket, (pingPongCanvas.ActualWidth - racket.Width) / 2);

            Canvas.SetTop(ball, 50);
            Canvas.SetLeft(ball, 50);
        }

        private void Window_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Left) 
            {
               
            }
        }
    }
}