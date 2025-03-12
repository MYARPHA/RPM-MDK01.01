int[] arrray = { 97, 45, 32, 65, 83, 23, 15 };
Array.Sort(arrray);

Console.WriteLine("Отсортированный массив: ");
for (int i = 0; i < arrray.Length; i++)
{
    Console.Write($"{arrray[i]} ");
}
Console.WriteLine("\n");

int value = 32;

Console.WriteLine($"Позиция элемента массива: ");
Console.WriteLine(JumpSort(arrray, value));

static int JumpSort(int[]array, int value)
{
    int jumpStep = Convert.ToInt32(Math.Sqrt(array.Length));
    int previousStep = 0;
    for (int i = 0; i < array.Length; i++)
    {
        // Не доделано!
    }
    return -1;
}