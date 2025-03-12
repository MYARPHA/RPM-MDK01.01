using DBLibrary;

Console.WriteLine("Строка подключения к БД:");
Console.WriteLine(DAL.ConnectionString);

Console.WriteLine("Проверка подключения...");
bool isConnected = await DAL.CheckConnectionAsync();
Console.WriteLine($"Подключение успешно: {isConnected}");

Console.WriteLine("Выполнение SQL-запроса...");
var games = await DAL.ExecuteNonQueryAsync(); 
foreach (var game in games)
{
    Console.WriteLine(game);
}

Console.ReadLine();