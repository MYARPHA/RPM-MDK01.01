using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace Task3
{
    internal class User
    {
        string login;
        string password;

        public string Login
        {
            get => login;
            set
            {
                login = value;
                
            }
        }
        public string Password
        {
            get => password;
            set
            {
                password = value;

            }
        }

        public event EventHandler<InfoEventArgs> Info;
        private void 
    }
}
