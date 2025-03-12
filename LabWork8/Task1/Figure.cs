namespace Task1
{
    abstract class Figure
    {
        public abstract double Area();
        public abstract double Perimeter();
        public abstract void Print();
        public abstract string Name { get; }
    }
}
