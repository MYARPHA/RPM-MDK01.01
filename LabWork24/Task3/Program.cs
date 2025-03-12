internal class Program
{
    private static int GetDaysCount(int month, int year)
    {
        if (month < 1 || month > 12)
            throw new ArgumentException("Неверный номер месяца");
        int februaryDays = (year % 400 == 0 || year % 100 != 0 && year % 4 == 0) ? 29 : 28;
        int[] monthDays = { 31, februaryDays, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
        return monthDays[month - 1];
    }
    static void Main(string[] args)
    {
        Console.WriteLine("Введите номер месяца: ");
        int inputMonthNumber = Convert.ToInt32(Console.ReadLine());
        Console.WriteLine("Введите год: ");
        int inputYear = Convert.ToInt32(Console.ReadLine());
        Console.WriteLine(GetDaysCount(inputMonthNumber, inputYear));
    }
}

