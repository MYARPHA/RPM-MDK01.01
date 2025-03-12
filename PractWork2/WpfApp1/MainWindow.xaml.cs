using DomainLayer;
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

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        CategoryService _service = new();
        public MainWindow()
        {
            InitializeComponent();

           
        }

        private async void Window_Loaded(object sender, RoutedEventArgs e)
        {
            var categories = await _service.GetAsync();
            categoriesDataGrid.ItemsSource = categories;
        }

        private async void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            var category = categoriesDataGrid.SelectedItem as Category;
            if (category != null)
            {
                await _service.DeleteCategoryAsync(category.CategoryId);
            }
        }

        private async void UpdateButton_Click(object sender, RoutedEventArgs e)
        {
            var category = categoriesDataGrid.SelectedItem as Category;
            if (category != null)
            { 
                category.Name = NameTextBox.Text;
                await _service.UpdateCategoryAsync(category);
            }
        }

        private async void AddButton_Click(object sender, RoutedEventArgs e)
        {
            var category = new Category()
            {
                Name = NameTextBox.Text
            };
            await _service.AddCategoryAsync(category);
            await LoadCategoriesAsync();
        }
    }
}