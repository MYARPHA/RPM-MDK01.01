int[] array = { 7, 0, -4, 3, 1, -2, 5 };

Console.Write("\n1 Проход: ");
for(int i = 0; i < array.Length; i++)
{
    Console.Write($"{array[i]}\t");
}

for (int i = 0; i < array.Length - 1; i++)
{
    for (int j = array.Length - 2; j >= 0; j--)
    { 
        if (array[j] > array[j + 1])
        {
            int temp = array[j];
            array[j] = array[j + 1];
            array[j + 1] = temp;
        }
    }

    Console.Write($"\n{i + 2} Проход: ");
    for (int j = 0; j < array.Length; j++)
    {
        Console.Write($"{array[j]}\t");
    }
}