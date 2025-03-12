namespace Task1
{
    class Files
    {
        private string fileName;
        private string path;
        private int size;

        public Files() : this("name", "path", 1)
        {
        }

        public Files(string fileName, string path, int size)
        {
            this.fileName = fileName;
            this.path = path;
            this.size = size;
        }

        public string FileName
        {
            get => fileName;
            set
            {
                if (value.Length >= 1)
                {
                    fileName = value;
                }
            }
        }

        public string Path
        {
            get => path;
            set
            {
                if (value.Length >= 1)
                {
                    path = value;
                }
            }
        }

        public int Size
        {
            get => size;
            set
            {
                if (value >= 0)
                {
                    size = value;
                }
            }
        }

        public void Print()
        {
            Console.WriteLine($"Имя файла: {FileName}, Путь: {Path}, Размер: {Size}");
        }
    }
}
