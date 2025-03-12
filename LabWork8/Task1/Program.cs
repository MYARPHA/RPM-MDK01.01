using Task1;

Files file = new("hogwarts_sucks.txt", "../asasas/hogwarts_sucks.txt", 100);
Console.WriteLine(file);
Console.WriteLine();
Console.WriteLine(file.ToString());

Files file1 = new("aboba.png", "../twitchemotes/aboba.png", 123);
Console.WriteLine(file.Equals(file1));

