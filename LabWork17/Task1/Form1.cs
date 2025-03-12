namespace Task1
{
    public partial class Form1 : Form
    {
        FileInfo[] files;

        public Form1()
        {
            InitializeComponent();
            DirectoryInfo directory = new DirectoryInfo(@"V:\ispp35\LabWork17");
            files = directory.GetFiles("*", SearchOption.AllDirectories);
        }

        private void Task1Button_Click(object sender, EventArgs e)
        {
            fileDataGridView.DataSource = files
                .Select(file => new
                {
                    file.Name,
                    file.DirectoryName,
                    file.CreationTime,
                    file.Length
                })
                .OrderBy(file => file.Name)
                .ThenByDescending(file => file.CreationTime)
                .ToList();
        }

        private void Task2Button_Click(object sender, EventArgs e)
        {
            fileDataGridView.DataSource = files
                .GroupBy(file => file.Extension)
                .ToList();
        }

        private void Task3Button_Click(object sender, EventArgs e)
        {
            fileDataGridView.DataSource = files
                .GroupBy(file => file.Extension)
                .Select(group => new
                {
                    Extension = group.Key,
                    ExtentionCount = group.Count(),
                })
                .ToList();
        }

        private void Task4Button_Click(object sender, EventArgs e)
        {
            //fileDataGridView1.DataSource = files.AsEnumerable();
            //{
            //    files.Where(file => file.DirectoryName == "LabWork17" || file.DirectoryName == "Task1").ToList();
            //}
        }

        private void Task5Button_Click(object sender, EventArgs e)
        {
            fileDataGridView.DataSource = files
                .Where(file => file.CreationTime.Date == DateTime.Today)
                .OrderBy(file => file.CreationTime)
                .Take(5)
                .ToList();
        }

        private void Task6Button_Click(object sender, EventArgs e)
        {
            fileDataGridView.DataSource = files
                .GroupBy(file => file.Exists)
                .Select(group => new
                {
                    FileCount = group.Count(file => file.Exists),
                    LengthSum = group.Sum(file => (file.Length / 1024.0) / 1024.0)
                })
                .ToList();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            fileDataGridView.DataSource = files
                .Select(file => new
                {
                    file.Name,
                    file.Extension,
                    file.FullName,
                    file.Length,
                });
        }

        private void button8_Click(object sender, EventArgs e)
        {
            //var userName = textBox1.Text;
            //fileDataGridView.DataSource = files
            //    .Count(file => file.Name == userName)
            //    .To;
        }
    }
}
