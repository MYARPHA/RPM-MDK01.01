using LabWorkLibrary;

Console.WriteLine(Maths.Add(2, 3));
Console.WriteLine(Maths.Subtract(3, 4));
Console.WriteLine(Maths.Multiply(5, 7));
Console.WriteLine(Maths.Divide(6, 9));
Console.WriteLine(Maths.GetRectangleArea(9, 4));
Console.WriteLine(Maths.BINARY_FACTOR);

User user = new();
user.Login = "...@gmail.com";
user.Password = "sahrSDF12";
user.Role = Role.Byer;