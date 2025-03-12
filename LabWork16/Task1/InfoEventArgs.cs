using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Task1
{
    public class InfoEventArgs : EventArgs
    {
        public string PropertyName { get => PropertyName; }
        public string ErrorText { get; }
        public DateTime ChangeDateTime { get; }
    }
}
