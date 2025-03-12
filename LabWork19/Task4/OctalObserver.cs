using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task4
{
    public class OctalObserver : Observer
    {
        private Subject subject;

        public OctalObserver(Subject subject)
        {
            this.subject = subject;
            subject.Attach(this);
        }

        public override void Update()
        {
            Console.WriteLine($"Octal String: {Convert.ToString(subject.State, 8).ToUpper()}");
        }
    }
}