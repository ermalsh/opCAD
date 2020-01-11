using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace SoSACAD
{
    public class Crypto
    {

        private static int SALT_LENGTH = 16;
        private static int ROUNDS = 10000;

        /// <summary>
        /// Verify that the password entered by the user is the same as the passowrd in the DB
        /// </summary>
        /// <param name="dbUsername">The PK ("Unit_Number") for the user in the DB</param>
        /// <param name="enteredPassword">The password they have entered</param>
        /// <returns>True if they're the same, false otherwise. Note: It will also return false if they don't exist in the DB</returns>
        public static bool VerifyPassword(String dbUsername, String enteredPassword)
        {
            String connection = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            SqlConnection con = new SqlConnection(connection);

            con.Open();

            String select = "SELECT * FROM [registered_users] WHERE ([Unit_Number] = @dbUsername) AND ([isBanned] = @isbanned) AND ([isNewUser] = @isnewuser)";
            SqlCommand cmds = new SqlCommand(select, con);
            cmds.Parameters.AddWithValue("@dbUsername", dbUsername);
            cmds.Parameters.AddWithValue("@isnewuser", "Yes");
            cmds.Parameters.AddWithValue("@isbanned", "No");
            SqlDataReader sqldrs = cmds.ExecuteReader();
            if (sqldrs.Read())
            {
                String dbPassword = (String)sqldrs["Password"];
               
                byte[] dbHash = Convert.FromBase64String(dbPassword);
                byte[] salt = new byte[SALT_LENGTH];
                Array.Copy(dbHash, 0, salt, 0, SALT_LENGTH);

                var pbk = new Rfc2898DeriveBytes(enteredPassword, salt, ROUNDS);
                byte[] hash = pbk.GetBytes(20);

                for (int i = 0; i < 20; i++) {
                    if (dbHash[i + SALT_LENGTH] != hash[i])
                    {
                        return false; // If the bytes don't match, neither does the pass!
                    }
                }

                return true;

            }
            else
            {
                return false; //not in DB so, password is technically wrong
            }

        }

        public static bool VerifyPasswordCom(String dbUsername, String enteredPassword)
        {
            String connection = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            SqlConnection con = new SqlConnection(connection);

            con.Open();

            String select = "SELECT * FROM [registered_users] WHERE ([Unit_Number] = @dbUsername) AND ([isBanned] = @isbanned) AND ([isNewUser] = @isnewuser) AND ([isDispatcher] = @isdispatcher)";
            SqlCommand cmds = new SqlCommand(select, con);
            cmds.Parameters.AddWithValue("@dbUsername", dbUsername);
            cmds.Parameters.AddWithValue("@isnewuser", "Yes");
            cmds.Parameters.AddWithValue("@isbanned", "No");
            cmds.Parameters.AddWithValue("@isdispatcher", "Yes");

            SqlDataReader sqldrs = cmds.ExecuteReader();
            if (sqldrs.Read())
            {
                String dbPassword = (String)sqldrs["Password"];

                byte[] dbHash = Convert.FromBase64String(dbPassword);
                byte[] salt = new byte[SALT_LENGTH];
                Array.Copy(dbHash, 0, salt, 0, SALT_LENGTH);

                var pbk = new Rfc2898DeriveBytes(enteredPassword, salt, ROUNDS);
                byte[] hash = pbk.GetBytes(20);

                for (int i = 0; i < 20; i++)
                {
                    if (dbHash[i + SALT_LENGTH] != hash[i])
                    {
                        return false; // If the bytes don't match, neither does the pass!
                    }
                }

                return true;

            }
            else
            {
                return false; //not in DB so, password is technically wrong
            }

        }

        public static string StoreIP(String dbUsername)
        {
            string userip;
            String connection = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            SqlConnection con = new SqlConnection(connection);
            String ipStoreQuery = "UPDATE [registered_users] SET [ipAddress] = @ipAddress WHERE [Unit_Number] = @dbUsername";
            SqlCommand commandEx = new SqlCommand(ipStoreQuery, con);
            commandEx.Parameters.AddWithValue("@dbUsername", dbUsername);
            commandEx.Parameters.AddWithValue("@ipAddress", GetIpAddress(out userip));
            con.Open();
            commandEx.ExecuteNonQuery();
            con.Close();
            return "Success";
        }

        public static string StoreCivIP(String dbUsername)
        {
            string userip;
            String connection = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            SqlConnection con = new SqlConnection(connection);
            String ipStoreQuery = "UPDATE [registered_civs] SET [ipAddress] = @ipAddress WHERE [Username] = @dbUsername";
            SqlCommand commandEx = new SqlCommand(ipStoreQuery, con);
            commandEx.Parameters.AddWithValue("@dbUsername", dbUsername);
            commandEx.Parameters.AddWithValue("@ipAddress", GetIpAddress(out userip));
            con.Open();
            commandEx.ExecuteNonQuery();
            con.Close();
            return "Success";
        }

        protected static string GetIpAddress(out string userip)
        {
            userip = HttpContext.Current.Request.UserHostAddress;
            string ipAddress = "";
            if (HttpContext.Current.Request.UserHostAddress != null)
            {
                Int64 macinfo = new Int64();
                string macSrc = macinfo.ToString("X");
                if (macSrc == "0")
                {
                    if (userip == "127.0.0.1")
                    {
                        ipAddress = "Localhost";
                    }
                    else
                    {
                        ipAddress = userip;
                    }
                }
            }
            return ipAddress;
        }

        /// <summary>
        /// Get the fully-hashed password from the DB for a given user
        /// </summary>
        /// <param name="dbUsername">The PK ("Unit_Number") for the user in the DB</param>
        /// <returns>The hashed password stored in the DB </returns>
        public static string getPasswordFromDb(String dbUsername)
        {
            String connection = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            SqlConnection con = new SqlConnection(connection);

            con.Open();

            String select = "SELECT * FROM [registered_users] WHERE ([Unit_Number] = @dbUsername) AND ([isBanned] = @isbanned) AND ([isNewUser] = @isnewuser);";
            SqlCommand cmds = new SqlCommand(select, con);
            cmds.Parameters.AddWithValue("@dbUsername", dbUsername);
            cmds.Parameters.AddWithValue("@isnewuser", "Yes");
            cmds.Parameters.AddWithValue("@isbanned", "No");

            SqlDataReader sqldrs = cmds.ExecuteReader();
            if (sqldrs.Read())
            {
                String dbPassword = (String)sqldrs["Password"];
                return dbPassword;
            }
            else
            {
                return "Invalid"; //not in DB so, password is technically wrong
            }
        }

        /// <summary>
        /// Wrapper for the "strongHash(String, byte[])" function. Internally calls the getSalt() function so, 
        /// you don't have to
        /// </summary>
        /// <param name="password">The text to hash (the password)</param>
        /// <returns>a base64 string of the hashed password</returns>
        public static string strongHash(String password)
        {
            byte[] salt = getSalt();
            return strongHash(password, salt);
        }

        /// <summary>
        /// Hash a given password using the given salt byte array using the PBDK2 algorithm
        /// </summary>
        /// <param name="pass">The text to hash (the password)</param>
        /// <param name="salt">The salt to use (should be secure random)</param>
        /// <returns>a base64 string of the hashed password</returns>
        public static string strongHash(String pass, byte[] salt)
        {
            //Hash and salt the password using pbdkf2, making it nice and slow :)
            Rfc2898DeriveBytes pbdkf2 = new Rfc2898DeriveBytes(pass, salt, ROUNDS);

            byte[] hash = pbdkf2.GetBytes(20);
            byte[] hashBytes = new byte[20  + SALT_LENGTH];

            Array.Copy(salt, 0, hashBytes, 0, SALT_LENGTH);
            Array.Copy(hash, 0, hashBytes, SALT_LENGTH, 20 );

            return Convert.ToBase64String(hashBytes);
        }
        /// <summary>
        /// Get a random byte array of SALT_LEGNTH to use in the hashing algorithm
        /// </summary>
        /// <returns>a secure random byte array</returns>
        public static byte[] getSalt()
        {
            byte[] salt = new byte[SALT_LENGTH];

            RNGCryptoServiceProvider cp = new RNGCryptoServiceProvider();
            cp.GetBytes(salt);

            return salt;
        }

        public static string encryption(String password)
        {
            SHA256CryptoServiceProvider md5 = new SHA256CryptoServiceProvider();
            byte[] encrypt;
            UTF8Encoding encode = new UTF8Encoding();
            //encrypt the given password string into Encrypted data  
            encrypt = md5.ComputeHash(encode.GetBytes(password));
            StringBuilder encryptdata = new StringBuilder();
            //Create a new string by using the encrypted data  
            for (int i = 0; i < encrypt.Length; i++)
            {
                encryptdata.Append(encrypt[i].ToString());
            }
            return encryptdata.ToString();
        }
    }
}