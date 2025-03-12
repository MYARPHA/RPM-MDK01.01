using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace Shooter
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        DispatcherTimer timer = new(DispatcherPriority.Render);
        DispatcherTimer timerMove = new(DispatcherPriority.Render);
        Label scoreLabel = new();
        int score = 0;

        public MainWindow()
        {
            InitializeComponent();

            timer.Interval = TimeSpan.FromMilliseconds(500);
            timer.Start();
            timer.Tick += Timer_Tick;

            timerMove.Interval = TimeSpan.FromMilliseconds(50);
            timerMove.Start();
            timerMove.Tick += TimerMove_Tick;

            gameCanvas.Children.Add(scoreLabel);
            scoreLabel.Foreground = new SolidColorBrush(Colors.Black);
            scoreLabel.Content = 0;
        }

        private void TimerMove_Tick(object? sender, EventArgs e)
        {
            foreach (Shape item in gameCanvas.Children.OfType<Shape>())
            {
                double y = (double)item.GetValue(Canvas.TopProperty);
                Canvas.SetTop(item, y + 3);

                if (y >= 400)
                {
                    timerMove.Stop();
                    timer.Stop();
                    MessageBox.Show("Конец");
                    break;
                }
            }
        }

        private void Timer_Tick(object? sender, EventArgs e)
        {
            AddEnemy();
        }

        private void AddEnemy()
        {
            Ellipse enemy = new()
            {
                Width = 30,
                Height = 30,
                Fill = new SolidColorBrush(Colors.Purple)
            };
            enemy.MouseDown += Enemy_MouseDown;
            gameCanvas.Children.Add(enemy);

            double x = new Random().NextDouble() * (Width - enemy.Width);
            Canvas.SetLeft(enemy, x);
            Canvas.SetTop(enemy, -enemy.Height / 2);
        }

        private void Enemy_MouseDown(object sender, MouseButtonEventArgs e)
        {
            gameCanvas.Children.Remove(sender as UIElement);

            score++;
            scoreLabel.Content = score;
        }
    }
}