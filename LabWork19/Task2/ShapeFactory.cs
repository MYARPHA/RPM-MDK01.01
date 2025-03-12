namespace Task2
{
    public class ShapeFactory
    {
        public IShape GetShape(String shapeType)
        {
            if (shapeType == null)
            {
                return null;
            }
            if (shapeType.Equals("CIRCLE", StringComparison.InvariantCultureIgnoreCase))
            {
                return new Circle();
            }
            if (shapeType.Equals("RECTANGLE", StringComparison.InvariantCultureIgnoreCase))
            {
                return new Rectangle();
            }
            if (shapeType.Equals("SQUARE", StringComparison.InvariantCultureIgnoreCase))
            {
                return new Square();
            }
            if (shapeType.Equals("TRIANGLE", StringComparison.InvariantCultureIgnoreCase))
            {
                return new Triangle();
            }
            return null;
        }
    }
}