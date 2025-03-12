using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace Task1
{
    internal class User : INotifyPropertyChanged
    {
        string login;
        string password;

        public string Login
        {
            get => login;
            set
            {
                if (login != value)
                {
                    login = value;
                    NotifyPropertyChanged();
                }
            }
        }

        public string Password
        {
            get => password;
            set
            {
                if (password != value)
                {
                    password = value;
                    NotifyPropertyChanged();
                }
            }
        }

        public event PropertyChangedEventHandler? PropertyChanged;

        private void NotifyPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
