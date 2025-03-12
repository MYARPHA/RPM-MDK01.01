using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task1
{
    public class OperationDivide : IStrategy
    {
        public int DoOperation(int num1, int num2)
        {
            return num1 / num2;
        }
    }
}