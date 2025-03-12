//Задание 1
using System.Text;

Console.WriteLine("Введите строку: ");
string? text = Console.ReadLine();
Console.WriteLine($"Количество символов: {text.Length}");

Console.WriteLine($"Количество символов без учета пробела: {text.Replace(" ", "").Length}");

int count = 0;
foreach (var symbol in text)
{
    if (Char.IsLetter(symbol))
    {
        count++;
    }
}
Console.WriteLine($"Количество букв: {count}");

Console.WriteLine("Введите символ: ");
char searchSymbol = Convert.ToChar(Console.ReadLine());
for (int i = 0; i < text.Length; i++)
{
    if (text[i] == searchSymbol)
    {
        Console.WriteLine(i + 1);
    }
}
if (!text.Contains(searchSymbol))
{
    Console.WriteLine("Символа нет");
}

//Задание 2
text = text.Trim();
while (text.Contains("  "))
{
    text = text.Replace("  ", " ");
}
Console.WriteLine($"Отформатированная строка: {text}");

Console.WriteLine("Введите строку: ");
StringBuilder userText = new(Console.ReadLine());
Console.WriteLine("Выберите регистр (верхний, нижний или инвертированный): ");
string? chosenRegister = Console.ReadLine();
if (chosenRegister == "верхний")
{
    for (int i = 0; i < userText.Length; i++)
    {
        if (Char.IsLower((char)i))
        {
            //userText.Replace((char)i, Char.ToUpper((char)i);
        }
    }
    Console.WriteLine(userText.ToString());
}
if(chosenRegister == "нижний")
{
    for (int i = 0; i < userText.Length; i++)
    {
        if (Char.IsUpper(userText[i]))
        {
            Char.ToLower(userText[i]);
        }
    }
}
if (chosenRegister == "инвертированный")
{
    for (int i = 0; i < userText.Length; i++)
    {
        if (Char.IsUpper(userText[i]))
        {
            Char.ToLower(userText[i]);
        } 
        else if (Char.IsLower(userText[i]))
        {
            Char.ToUpper(userText[i]);
        }
    }
}


