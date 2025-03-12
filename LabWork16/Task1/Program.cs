using Task1;

User user = new User();
user.PropertyChanged += User_PropertyChanged;

user.Login = "asdas";
user.Login = "asdasdasd";
user.Password = "password";

void User_PropertyChanged(object? sender, System.ComponentModel.PropertyChangedEventArgs e)
{
    Console.WriteLine(e.PropertyName);
}