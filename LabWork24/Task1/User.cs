namespace Task1
{
    public class User
    {
        public string _login;
        public string _password;

        public bool IsCorrectUserData(string login, string password, string confirmPassword)
        {
            bool isLoginCorrect = !login.Equals(string.Empty);
            bool isPasswordCorrect = !password.Equals(string.Empty);
            bool isConfirmCorrect = (password.Equals(confirmPassword));

            return isLoginCorrect && isPasswordCorrect && isConfirmCorrect;
        }
    }
}