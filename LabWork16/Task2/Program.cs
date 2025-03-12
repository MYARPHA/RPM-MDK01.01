using Task2;

User user = new User();
user.Notify += User_Notify;

user.Login = "user";
user.Login = "useruserresu";

void User_Notify(object? sender, EventArgs e)
{
    User currentUser = (User)sender;
    Console.WriteLine($"Изменены данные пользователя со следующим логином: {currentUser.Login}");
}