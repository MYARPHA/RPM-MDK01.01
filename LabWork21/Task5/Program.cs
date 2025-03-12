Console.WriteLine(GetPower(5, 2));

int GetPower(int x, int n)
{
    if (n == 0)
        return 1;
    if (n % 2 == 0 && n >= 0)
        return GetPower(x * x, n >> 1);
    if (n % 2 != 0 && n >= 0)
        return x * GetPower(x * x, (n - 1) >> 1);
    return -1;
}
