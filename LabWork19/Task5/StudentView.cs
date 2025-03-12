namespace Task5
{
    public class StudentView
    {
        public void PrintStudentDetails(string StudentName, string StudentRollNo)
        {
            Console.WriteLine("Student: ");
            Console.WriteLine($"Name: {StudentName}");
            Console.WriteLine($"Roll No: {StudentRollNo}");
        }
    }
}