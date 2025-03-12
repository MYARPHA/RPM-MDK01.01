Console.WriteLine(GetDaysCount(13 ,2021));

int GetDaysCount(int month, int year)
{
    if (month < 1 && month > 12)
        return -1;
    switch (month)
    {
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        case 2:
            return (year % 100 != 0 && year % 4 == 0 || year % 400 == 0) ? 29 : 28;
        default:
            return 31;
    }
}