using System.Text.RegularExpressions;

string input = Console.ReadLine();
string pattern = @"(?=.*[a-z])(?=.*[A-Z])(?=.*[?!.])(?=.*\d+).{6,}";
Regex regex = new(pattern);

while (!regex.IsMatch(input))
{
    Console.WriteLine("Пароль не надежный. Повторите попытку");
    input = Console.ReadLine();
}
Console.WriteLine("Пароль надежный");