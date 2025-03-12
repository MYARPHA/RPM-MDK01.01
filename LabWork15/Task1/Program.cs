class Program
{
    delegate int Operations(int x);

    static int Square(int x)
        => x * x;

    static int Factorial(int x)
    {
        if (x < 0)
            return -1;
        if (x == 0)
            return 1;
        else
            return x * Factorial(x - 1);
    }

    static int Abs(int x)
    {
        if (x < 0)
            return -x;
        return x;
    }

    public static void Main()
    {
        int x = -5;
        Operations operation = Square;
        Console.WriteLine($"Квадрат числа: {operation?.Invoke(x)}");
        operation = Factorial;
        Console.WriteLine($"Факториал: {operation?.Invoke(x)}");
        operation = Abs;
        Console.WriteLine($"Модуль числа: {operation?.Invoke(x)}");
    }
}