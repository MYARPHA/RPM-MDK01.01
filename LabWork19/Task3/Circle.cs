using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task3
{
    public class Circle : IShape
    {
        public void Draw()
        {
            Console.WriteLine("Shape: Circle");
        }
    }
}