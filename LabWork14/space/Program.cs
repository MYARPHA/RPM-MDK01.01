using System.Text.RegularExpressions;

Console.WriteLine("Введите строку: ");
string input = Console.ReadLine();
string pattern = @"  *";
string replacement = " ";
Regex regex = new(pattern);
input = regex.Replace(input, replacement);
Console.WriteLine(input);