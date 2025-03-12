int[] array = { 7, 0, -4, 3, 1, -2, 5 };

Console.Write("Исходный массив: ");
for (int i = 0; i < array.Length; i++)
{
    Console.Write($"{array[i]}\t");
}

for (int i = 1; i < array.Length; i++)
{
    int x = array[i];
    int j = i - 1;

    while (j >= 0 && array[j] > x)
    {
        array[j + 1] = array[j];
        j--;
    }
    array[j + 1] = x;

    Console.Write($"\n{i} Проход: ");
    for (j = 0; j < array.Length; j++)
    {
        Console.Write($"{array[j]}\t");
    }
}