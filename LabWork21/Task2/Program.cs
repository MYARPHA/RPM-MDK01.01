// Вычисление площади кольца
double outerRadius = 1;
double innerRadius = 5;
double square = Math.PI * (outerRadius - innerRadius) * (outerRadius + innerRadius);
if (square < 0)
    square = -square;
Console.WriteLine(square);

// Сумма ряда натуральных чисел
int n = 9;
int sum = n * (n + 1) >> 1;
Console.WriteLine(sum);