using System.Text.RegularExpressions;

Console.WriteLine("Введите номер: ");
string input = Console.ReadLine();
string pattern = @"^\+7|8\(9\d{2}\)\d{3}-\d{2}-\d{2}$";
Regex regex = new(pattern);
if (regex.IsMatch(input))
    Console.WriteLine("Вы ввели корректный номер ");
else
    Console.WriteLine("Вы ввели некорректный номер");

