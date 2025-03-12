using System.Text.RegularExpressions;

string input = Console.ReadLine();
string pattern = @"^[a-zA-Z 0-9_-]+@+[a-zA-Z 0-9]*\.[a-z]*$";
Regex regex = new(pattern);
if (regex.IsMatch(input))
{
    Console.WriteLine("вы ввели корректный адрес");
}
else
{
    Console.WriteLine("вы ввели некорректный адрес");
}