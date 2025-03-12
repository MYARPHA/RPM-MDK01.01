using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Task3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            button1.Click += OpenButton1_Click;
        }

        private void OpenButton1_Click(object sender, EventArgs e)
        {
            SearchForm form = new SearchForm();
            form.Action = FindText; //указали метод для вызова
            form.ShowDialog();
        }

        private void FindText(string obj)
        {
            textBox1.Text = $"{obj} не найдена";
        }
    }
}
