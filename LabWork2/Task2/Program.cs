// Сортировка
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
Console.WriteLine(BinarySearch(arrray, value));

static int BinarySearch(int[] array, int value)
{
    int leftArrayPart = 0;
    int rightArrayPart = array.Length;

    while (leftArrayPart <= rightArrayPart)
    {
        int arrayMiddle = (leftArrayPart + rightArrayPart) / 2;

        if (array[arrayMiddle] == value)
        {
            return arrayMiddle + 1;
        }

        if (value < array[arrayMiddle])
        {
            rightArrayPart = arrayMiddle - 1;
        }
        else
        {
            leftArrayPart = arrayMiddle + 1;
        }
    }
    return -1;  // сложность алгоритма O(log(N))
}
