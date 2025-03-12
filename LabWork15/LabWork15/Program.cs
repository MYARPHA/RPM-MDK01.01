using LabWork15;

Console.WriteLine("LabWork15");

DatabaseContext context = new("PRSERVER\\SQLEXPRESS", "ispp3511", "ispp3511", "3511");

//CategoryRepository repository = new(context);
//Console.WriteLine(await repository.AddAsync(new Category { Name = "test1" }));

//Category category = await repository.GetByIdAsync(1);
//Console.WriteLine(category.Name);

VisitorRepository repository = new(context);
Console.WriteLine(await repository.AddAsync(new Visitor { PhoneNumber = "89025043227" }));