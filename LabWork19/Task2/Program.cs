using Task2;

ShapeFactory shapeFactory = new ShapeFactory();

IShape circle = shapeFactory.GetShape("CIRCLE");
circle.Draw();

IShape rectangle = shapeFactory.GetShape("RECTANGLE");
rectangle.Draw();

IShape square = shapeFactory.GetShape("SQUARE");
square.Draw();

IShape triangle = shapeFactory.GetShape("TRIANGLE");
triangle.Draw();