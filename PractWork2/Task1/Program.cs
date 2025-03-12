using Excel = Microsoft.Office.Interop.Excel;

Console.WriteLine("Укажите каталог: ");
string directory = Console.ReadLine();

var app = new Excel.Application();
app.Visible = true;

app.SheetsInNewWorkbook = 2;
var workbook = app.Workbooks.Add();

var worksheet = workbook.Worksheets[1];
worksheet.Name = "Файлы";
worksheet.Cells[1, 1] = "Номер файла";
worksheet.Cells[1, 2] = "Имя файла";
worksheet.Cells[1, 3] = "Размер файла";
worksheet.Columns.Autofit();

worksheet = workbook.Worksheets[2];
worksheet.Name = "Подпапки";
worksheet.Cells[1, 1] = "Номер подпапки";
worksheet.Cells[1, 2] = "Имя подпапки"; 
worksheet.Columns.Autofit();

if()

/* var processes = Process.GetProcessesByName("Excel");
foreach (var process in processes)
    process.Kill(); */