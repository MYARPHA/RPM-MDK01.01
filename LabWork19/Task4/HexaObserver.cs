using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task4
{
    public class HexaObserver : Observer
    {
        private Subject subject;

        public HexaObserver(Subject subject)
        {
            this.subject = subject;
            subject.Attach(this);
        }

        public override void Update()
        {
            Console.WriteLine($"Hex String: {Convert.ToString(subject.State, 16).ToUpper()}");
        }
    }
}