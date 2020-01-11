using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoSACAD
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

       


        public string encryption(String password)
        {
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
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

        public void Submit_SA(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                String username = superAdminID.Text.ToString();
                String password = superAdminPW.Text;

                String con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                SqlConnection connection = new SqlConnection(con);
                connection.Open();

                bool passVerified = Crypto.VerifyPassword(username, password);

                String passwords = Crypto.getPasswordFromDb(username);

                String query = "SELECT [Unit_Number], [Password] FROM registered_users WHERE ([Unit_Number] = @unitID) AND ([Password] = @password) AND ([isAdmin] = @isadmin);";

                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@unitID", username);
                cmd.Parameters.AddWithValue("@password", passwords);
                cmd.Parameters.AddWithValue("@isadmin", "Yes");
                SqlDataReader sqldr = cmd.ExecuteReader();
                if (sqldr.Read() && passVerified)
                {
                    Session["SuperAdminUser"] = SessionCrypto.Encrypt(username);
                    Session["IsSuperAdmin"] = "True";
                    superAdminID.Text = "";
                    superAdminPW.Text = "";
                    Response.Redirect("CADSA.aspx");
                }
                else
                {
                    superAdminID.Text = "";
                    superAdminPW.Text = "";
                    Label1.Text = "Incorrect Credentials Provided or Not a Admin";

                }
                connection.Close();
            }
        }

        public string strongHash(String pass, byte[] salt)
        {
            //Hash and salt the password using pbdkf2, making it nice and slow :)
            Rfc2898DeriveBytes pbdkf2 = new Rfc2898DeriveBytes(pass, salt, 10000);

            byte[] hash = pbdkf2.GetBytes(20);
            byte[] hashBytes = new byte[45];

            Array.Copy(salt, 0, hashBytes, 0, 25);
            Array.Copy(hash, 0, hashBytes, 25, 45);

            return Convert.ToBase64String(hashBytes);
        }

        public byte[] getSalt()
        {
            byte[] salt = new byte[25];

            RNGCryptoServiceProvider cp = new RNGCryptoServiceProvider();
            cp.GetBytes(salt);

            return salt;
        }

}
}