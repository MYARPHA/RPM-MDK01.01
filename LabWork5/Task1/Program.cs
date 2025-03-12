using Task1;

// task1
Console.WriteLine("Task1");
Files file1 = new();
Files file2 = new("aboba", "../twitchemotes/aboba.png", 123);
Console.WriteLine();

// task2
Console.WriteLine("Task2");
file1.Print();
file2.Print();
Console.WriteLine();
Console.WriteLine();

// task3
Console.WriteLine("Task3");
file1.FileName = "";
file1.Path = "";
file1.Size = -1;
file1.Print();
file1.FileName = "life";
file1.Path = "../twitchemotes/life.png";
file1.Size = 534;
file1.Print();
Console.WriteLine();

// task4
Console.WriteLine("Task4");
Files[] files =
    [
        new Files("poggers", "../twitchemotes/poggers.png", 316),
        new Files("DIESOFCRINGE", "../twitchemotes/DIESOFCRINGE.png", 762),
        new Files("torture", "../twitchemotes/torture.png", 301),
        new Files("hiiii", "../twitchemotes/hiiii.png", 34),
    ];
Console.WriteLine("Введите имя файла: ");
string? userSearch = Console.ReadLine();

Console.WriteLine("Файлы с указанным названием: ");
foreach (var file in files)
{
    if (file.FileName == userSearch)
    {
        file.Print();
    }
}

Console.WriteLine("Введите размер файла: ");
int userSize = Convert.ToInt32(Console.ReadLine());

Console.WriteLine("Файлы, размер которых превышает заданный");
foreach (var file in files)
{
    if (file.Size > userSize)
    {
        file.Print();
    }
}
