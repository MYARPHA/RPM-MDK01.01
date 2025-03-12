using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task3
{
    public class BlueShapeDecorator : ShapeDecorator
    {
        public BlueShapeDecorator(IShape decoratedShape) : base(decoratedShape) { }

        public override void Draw()
        {
            decoratedShape.Draw();
            SetBlueBorder(decoratedShape);
        }

        private void SetBlueBorder(IShape decoratedShape)
        {
            Console.WriteLine("Border Color: Blue");
        }
    }
}