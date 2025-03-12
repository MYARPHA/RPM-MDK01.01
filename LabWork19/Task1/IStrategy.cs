using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task1
{
    public interface IStrategy
    {
        int DoOperation(int num1, int num2);
    }
}