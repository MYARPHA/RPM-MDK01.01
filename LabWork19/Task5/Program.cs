using Task5;

Student model = new() { Name = "Robert", RollNo = "10" };
StudentView view = new();
StudentController controller = new(model, view);
controller.UpdateView();
controller.StudentName = "John";
controller.UpdateView();