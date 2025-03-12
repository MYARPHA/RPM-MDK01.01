using Microsoft.Win32;
using System.Windows;
using System.Windows.Media.Imaging;
using System.Windows.Threading;

namespace Image_Carousel
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class ImageCarousel : Window
    {
        DispatcherTimer timer = new();
        private string[] images;
        int currentIndex = 0;

        public ImageCarousel()
        {
            InitializeComponent();

            timer.Interval = TimeSpan.FromSeconds(0.3);
            timer.Tick += Timer_Tick;
        }

        private void Timer_Tick(object? sender, EventArgs e)
        {

        }

        public void LoadImages()
        {
            OpenFileDialog openImage = new();
            openImage.Filter = "Image Files|*.png;*.jpg;*.jpeg;*.gif;*.bmp";

            if (openImage.ShowDialog() == true)
            {
                BitmapImage bitmap = new BitmapImage(new Uri(openImage.FileName));
                imageChange.Source = bitmap;
            }
        }

        private void SelectFolderButton_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dialog = new();
            dialog.Multiselect = true;
            dialog.Filter = "Image Files|*.png;*.jpg;*.jpeg;*.gif;*.bmp";

            if (dialog.ShowDialog() == true)
            {
                images = dialog.FileNames;
                //LoadImages(images[0]);
            }
        }

        private void StartButton_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}