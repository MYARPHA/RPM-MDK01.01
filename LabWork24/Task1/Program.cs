using Task1;

User user = new();
Console.WriteLine("Введите логин: ");
string? login = Console.ReadLine();
Console.WriteLine("Введите пароль: ");
string? password = Console.ReadLine();
Console.WriteLine("Подтвердите пароль: ");
string? confirmPassword = Console.ReadLine();

if (user.IsCorrectUserData(login, password, confirmPassword))
{
    user._login = login;
    user._password = password;
    Console.WriteLine("Вы успешно зарегистрировались");
}
else
{
    Console.WriteLine("Вы лейм и не смогли зарегистрироваться");
}