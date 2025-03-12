using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task4
{
    public abstract class Observer
    {
        protected Subject Subject;

        public abstract void Update();
    }
}