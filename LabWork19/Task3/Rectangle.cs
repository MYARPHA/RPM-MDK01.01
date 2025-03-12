using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task3
{
    public class Rectangle : IShape
    {
        public void Draw()
        {
            Console.WriteLine("Shape: Rectangle");
        }
    }
}