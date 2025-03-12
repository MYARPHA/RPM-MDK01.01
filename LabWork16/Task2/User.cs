using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace Task2
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
                Notify?.Invoke(this, EventArgs.Empty);
            }
        }
        public string Password
        {
            get => password;
            set
            {
                password = value;
                Notify?.Invoke(this, EventArgs.Empty);
            }
        }

        public event EventHandler Notify;
    }
}
