namespace Task1
{
    internal struct Files
    {
        private string fileName;
        private string path;
        private int fileSize;

        [Flags]
        public enum Type
        {
            Archive,
            Audio,
            Video,
        }

        public Files(string fileName, string path, int fileSize)
        {
            this.FileName = fileName;
            this.Path = path;
            this.FileSize = fileSize;
            Type type = Type.Archive;
        }

        public string FileName
        {
            get => fileName;
            set
            {
                if (value.Length > 0)
                    fileName = value;
            }
        }
        public string Path
        {
            get => path;
            set
            {
                if (value.Length > 0)
                    path = value;
            }
        }
        public int FileSize
        {
            get => fileSize;
            set
            {
                if (value >= 0)
                    fileSize = value;
            }
        }

        public void Print()
        {
            Console.WriteLine($"Имя файла: {FileName}, путь к файлу: {Path}, размер: {FileSize}, тип: {(Type)1}");
        }
    }
}
