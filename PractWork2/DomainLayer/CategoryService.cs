using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Json;
using System.Text;
using System.Threading.Tasks;

namespace DomainLayer
{
    public class CategoryService
    {
        private readonly HttpClient _client;
        private readonly string _baseUrl = "http://localhost:5147/api/v1/";

        public CategoryService()
        {
            _client = new() { BaseAddress = new Uri(_baseUrl) };
        }

        public async Task<IEnumerable<Category>> GetAsync()
        {
            var response = await _client.GetAsync("categories/");
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadFromJsonAsync<IEnumerable<Category>>();
        }

        public async Task<Category> GetAsync(int id)
        {
            var response = await _client.GetAsync($"api/v1/categories/{id}");
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadFromJsonAsync<Category>();
        }

        public async Task AddCategoryAsync(Category category)
        {
            var response = await _client.PostAsJsonAsync("api/v1/", category);
            response.EnsureSuccessStatusCode();
        }

        public async Task UpdateCategoryAsync(Category category)
        {
            var response = await _client.PutAsJsonAsync($"categories/{category.CategoryId}", category);
            response.EnsureSuccessStatusCode();
        }

        public async Task DeleteCategoryAsync(int id)
        {
            var response = await _client.DeleteAsync($"api/v1/delete/{id}");
            response.EnsureSuccessStatusCode();
        }
    }
}
