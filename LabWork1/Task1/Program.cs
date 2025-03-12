int[] array = { 7, 0, -4, 3, 1, -2, 5 };

for (int i = 0; i < array.Length;i ++)
{
    Console.Write($"{array[i]}\t");
}
Console.WriteLine();

for (int i = 0; i < array.Length - 1; i++)
{
    int indexMin = i;

    for (int j = i + 1; j < array.Length; j++)
    {
        if (array[j] < array[indexMin])
        {
            indexMin = j;
        }
    }

    if (array[indexMin] != array[i])
    {
        int temp = array[i];
        array[i] = array[indexMin];
        array[indexMin] = temp;
    }

    for (int j = 0;j < array.Length; j++)
    {
        Console.Write($"{array[j]}\t");
    }
    Console.WriteLine();
}
