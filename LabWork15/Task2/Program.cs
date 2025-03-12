namespace Task2
{
    internal class Program
    {
        delegate void Operations(double x, double y);

        static void GetSum(double x, double y)
        {
            Console.WriteLine($"Сумма: {x + y}");
        }

        static void GetSubtract(double x, double y)
        {
            Console.WriteLine($"Разность: {x - y}");
        }

        static void GetMult(double x, double y)
        {
            Console.WriteLine($"Произведение: {x * y}");
        }

        static void GetDivide(double x, double y)
        {
            Console.WriteLine($"Частное: {x / y}");
        }

        static void Main()
        {
            double x = 1;
            double y = 2;
            Operations number = GetSum;
            number += GetSubtract;
            number += GetMult;
            number += GetDivide;
            number(x, y);
        }
    }
}
