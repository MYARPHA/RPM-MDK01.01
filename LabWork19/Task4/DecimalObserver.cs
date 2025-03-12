using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task4
{
    public class DecimalObserver : Observer
    {
        private Subject subject;

        public DecimalObserver(Subject subject)
        {
            this.subject = subject;
            subject.Attach(this);
        }

        public override void Update()
        {
            Console.WriteLine($"Decimal String: {subject.State}");
        }
    }
}