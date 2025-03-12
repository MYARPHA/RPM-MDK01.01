using DomainLayer;
using System.Net.Http.Json;
using System.Text.Json;

Console.WriteLine("Hello, World!");

CategoryService service = new();

var categories = await service.GetAsync();
foreach (var category in categories)
    Console.WriteLine($"{category.CategoryId} {category.Name}");

await service.DeleteCategoryAsync(62);

Console.WriteLine();

HttpClient client = new() { BaseAddress = new Uri("http://localhost:5147/api/v1/") };

//var response = await client.GetAsync("categories");

//if (response.IsSuccessStatusCode)
//{
//    var content = await response.Content.ReadAsStringAsync();

//    var options = new JsonSerializerOptions
//    {
//        PropertyNameCaseInsensitive = true,
//    };
//    Console.WriteLine(content);
//    //var categories = JsonSerializer.Deserialize<List<Category>>(content, options);
//    //foreach (var category in categories)
//    //    Console.WriteLine($"{category.CategoryId} {category.Name}");

//    Console.WriteLine(content);
//}
//else
//{
//    var error = response.StatusCode;
//    Console.WriteLine($"http error: {error}");
//}

//int id = 62;
//var category1 = await client.GetFromJsonAsync<Category>($"categories/{id}");
//category1.Name = "changed name 123";

//try
//{
//    response = await client.PutAsJsonAsync($"categories/{id}", category1);
//    response.EnsureSuccessStatusCode(); //2xx
//}
//catch (HttpRequestException ex)
//{

//    Console.WriteLine(ex.Message);
//}

//response = await client.GetAsync("categories");
//response.EnsureSuccessStatusCode();
//var categories2 = await response.Content.ReadFromJsonAsync<List<Category>>();
//Console.WriteLine();


//var categories = await client.GetFromJsonAsync<List<Category>>("categories");

//foreach (var category in categories)
//    Console.WriteLine($"{category.CategoryId} {category.Name}");

//int id = 1;
//var category1 = await client.GetFromJsonAsync<Category>($"categories/{id}");
//Console.WriteLine($"category1: {category1.CategoryId} {category1.Name}");

//id = 60;
//await client.DeleteAsync($"categories/{id}");

//Category category2 = new() { Name = "test category" };
//await client.PostAsJsonAsync("categories", category2);



//Console.WriteLine();
