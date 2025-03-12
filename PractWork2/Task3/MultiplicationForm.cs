using Microsoft.Office.Interop.Excel;
using System;
using System.Drawing;
using System.Windows.Forms;
using Excel = Microsoft.Office.Interop.Excel;

namespace Task3
{
    public partial class MultiplicationForm : Form
    {
        public MultiplicationForm()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            multTable.Text = "Таблица умножения";
        }

        private void multTable_Click(object sender, EventArgs e)
        {
            var app = new Excel.Application();
            app.Visible = true;

            app.SheetsInNewWorkbook = 1;
            var workbook = app.Workbooks.Add();

            var worksheet = workbook.Worksheets[1];
            worksheet.Name = "Умножение";

            Range horizontalRange = worksheet.range[worksheet.Cells[10, 6], worksheet.Cells[10, 12]];
            worksheet.Cells[10, 5] = 2;
            worksheet.Cells[10, 5].Font.Size = 15;
            worksheet.Cells[10, 5].HorizontalAlignment = XlHAlign.xlHAlignCenter;
            worksheet.Cells[10, 5].Borders.LineStyle = XlLineStyle.xlContinuous;
            worksheet.Cells[10, 5].Interior.Color = ColorTranslator.ToOle(Color.Green);
            horizontalRange.Formula = "=E10+1";

            Range verticalRange = worksheet.range[worksheet.Cells[12, 4], worksheet.Cells[18, 4]];
            worksheet.Cells[11, 4] = 2;
            worksheet.Cells[11, 4].Font.Size = 15;
            worksheet.Cells[11, 4].HorizontalAlignment = XlHAlign.xlHAlignCenter;
            worksheet.Cells[11, 4].Borders.LineStyle = XlLineStyle.xlContinuous;
            worksheet.Cells[11, 4].Interior.Color = ColorTranslator.ToOle(Color.Green);
            verticalRange.Formula = "=D11+1";

            Range table = worksheet.range[worksheet.Cells[11, 5], worksheet.Cells[18, 12]];
            table.Formula = "=$D11*E$10";

            Range title = worksheet.range[worksheet.Cells[9, 4], worksheet.Cells[9, 12]];
            title.Merge();
            title.Value = "Таблица умножения";
            title.Font.Bold = true;
            title.Font.Italic = true;
            title.Font.Size = 20;

            horizontalRange.Font.Size = 15;
            verticalRange.Font.Size = 15;
            table.Font.Size = 15;

            title.HorizontalAlignment = XlHAlign.xlHAlignCenter;
            horizontalRange.HorizontalAlignment = XlHAlign.xlHAlignCenter;
            verticalRange.HorizontalAlignment = XlHAlign.xlHAlignCenter;
            table.HorizontalAlignment = XlHAlign.xlHAlignCenter;

            horizontalRange.Borders.LineStyle = XlLineStyle.xlContinuous;
            verticalRange.Borders.LineStyle = XlLineStyle.xlContinuous;
            table.Borders.LineStyle = XlLineStyle.xlContinuous;
            worksheet.Cells[10, 4].Borders.LineStyle = XlLineStyle.xlContinuous;

            horizontalRange.Interior.Color = ColorTranslator.ToOle(Color.Green);
            verticalRange.Interior.Color = ColorTranslator.ToOle(Color.Green);
            table.Interior.Color = ColorTranslator.ToOle(Color.LightYellow);
        }
    }
}
