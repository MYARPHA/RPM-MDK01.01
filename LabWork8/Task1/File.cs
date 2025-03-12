namespace Task1
{
    internal class Files
    {
        public string FileName { get; set; }
        public string Path { get; set; }
        public int FileSize { get; set; }

        public Files(string fileName, string path, int fileSize)
        {
            FileName = fileName;
            Path = path;
            FileSize = fileSize;
        }

        public override string ToString()
            => ($"Название: {FileName}, путь: {Path}, размер: {FileSize}");

        public override bool Equals(object? obj)
        {
            Files file1 = obj as Files;
            if (file1 == null)
                return false;
            return FileName == file1.FileName && Path == file1.Path && FileSize == file1.FileSize;
        }
    }
}
