using Task1;

//Задание 1
Files file1 = new Files();
Files file2 = new("aboba.png", "../twitchemotes/aboba.png", 200);
file1.Print();
file2.Print();
Console.WriteLine();

//Задание 2
file2.FileName = "";
file2.Path = "";
file2.FileSize = -1;
file2.Print();

file2.FileName = "a";
file2.Path = "b";
file2.FileSize = 300;
file2.Print();

