int[] array = { 97, 45, 32, 65, 83, 23, 15 };
int value = 97;

Console.WriteLine("Позиция элемента массива:");
Console.WriteLine(LinearSearch(array, value));

// Поиск
static int LinearSearch(int[] array, int value)
{
    for (int i = 0; i < array.Length; i++)
    {
        if (array[i] == value)
        {
            return i + 1;
        }
    }
    return -1;
}