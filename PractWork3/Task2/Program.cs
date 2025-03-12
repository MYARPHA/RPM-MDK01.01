using Word = Microsoft.Office.Interop.Word;

var wordApp = new Word.Application();
wordApp.Visible = true;

var document = wordApp.Documents.Add();

document.PrintOut(Append:"asdasdasd");

document.SaveAs("Task2", Word.WdSaveFormat.wdFormatPDF);
document.SaveAs("Task2");