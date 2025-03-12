using Task3;

IShape circle = new Circle();
circle = new RedShapeDecorator(circle);
circle = new BlueShapeDecorator(circle);
circle.Draw();

IShape redCircle = new RedShapeDecorator(new Circle());
IShape redRectangle = new RedShapeDecorator(new Rectangle());
IShape blueCircle = new BlueShapeDecorator(new Circle());

Console.WriteLine("Circle with normal border");
circle.Draw();

Console.WriteLine("\nCircle of red border");
redCircle.Draw();

Console.WriteLine("\nRectangle of red border");
redRectangle.Draw();

Console.WriteLine("\nRectangle of blue border");
blueCircle.Draw();