using Microsoft.Data.SqlClient;

namespace DBLibrary
{
    public static class DAL
    {
        private static string _serverName = "PRSERVER\\SQLEXPRESS";
        private static string _databaseName = "ispp3511";
        private static string _userName = "ispp3511";
        private static string _password = "3511";

        public static string ConnectionString
        {
            get
            {
                var builder = new SqlConnectionStringBuilder();
                {
                    builder.DataSource = _serverName;
                    builder.InitialCatalog = _databaseName;
                    builder.UserID = _userName;
                    builder.Password = _password;
                    builder.TrustServerCertificate = true;
                    return builder.ConnectionString;
                }

            }
        }

        // Метод для смены значений настроек подключения
        public static void ChangeConnectionSettings(string serverName, string databaseName, string userName, string password)
        {
            _databaseName = databaseName;
            _serverName = serverName;
            _databaseName = databaseName;
            _userName = userName;
            _password = password;
        }

        public static async Task<bool> CheckConnectionAsync()
        {
            try
            {
                using var connection = new SqlConnection(ConnectionString);
                await connection.OpenAsync();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
