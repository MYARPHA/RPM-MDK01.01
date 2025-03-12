Console.WriteLine(GetSize(215423124));

string GetSize(long bytes)
{
    if (bytes >= 1 << 30)
        return $"{bytes} Б = {bytes >> 30} ГБ";
    if (bytes >= 1 << 20)
        return $"{bytes} Б = {bytes >> 20} МБ";
    if (bytes >= 1 << 10)
        return $"{bytes} Б = {bytes >> 10} КБ";
    return $"{bytes} Б";
}