using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Microsoft.Security.Application;

namespace SoSACAD.Models
{
    public class LoginHandler
    {
        private string Username { get; set; }
        private string Password { get; set; }
        private string EmailAddress { get; set; }
        private string Approved { get; set; }
        private string Dispatcher { get; set; }
        private string Admin { get; set; }
        private string Banned { get; set; }
        private string IPAddress { get; set; }

        /// <summary>
        /// Login Method for LEO
        /// </summary>
        public static void LoginMethodLEO(String Username, String Password)
        {
            var Context = HttpContext.Current;
            bool passVerified = Crypto.VerifyPassword(Username, Password);

            Encoder.HtmlEncode(Username);
            Encoder.HtmlEncode(Password);

            if (passVerified)
            {
                Context.Response.Cookies["authcookie"]["username"] = SessionCrypto.Encrypt(Username);
                Context.Response.Cookies["authcookie"]["password"] = SessionCrypto.Encrypt(Password);
                Context.Response.Cookies["authcookie"].Expires = DateTime.Now.AddDays(2);

                if (Context.Response.Cookies["authcookie"]["username"] == SessionCrypto.Encrypt(Username) && Context.Response.Cookies["authcookie"]["password"] == SessionCrypto.Encrypt(Password))
                {
                    Context.Session["User"] = SessionCrypto.Encrypt(Username);
                    Context.Session["IsLEO"] = "True";
                    Crypto.StoreIP(Username);
                    Context.Response.Redirect("CAD.aspx");
                }
                else
                {
                    Context.Session["User"] = null;
                    Context.Session["IsLEO"] = null;
                    Context.Response.Cookies["authcookie"]["username"] = null;
                    Context.Response.Cookies["authcookie"]["password"] = null;
                }

            }
            else
            {
                Context.Session["User"] = null;
                Context.Session["IsLEO"] = null;
                Context.Session["IsDispatcher"] = null;
                Context.Session["IsCiv"] = null;
                Context.Session["IsAdmin"] = null;
                Context.Session["CivilianUser"] = null;
                Context.Session["UnitName"] = null;
                Context.Response.Cookies["authcookie"]["username"] = null;
                Context.Response.Cookies["authcookie"]["password"] = null;
                Context.Response.Redirect("default.aspx?error=1");
            }
        }

        /// <summary>
        /// Login Method for Dispatcher
        /// </summary>
        public static void LoginMethodCom(String Username, String Password)
        {
            var Context = HttpContext.Current;
            bool passVerified = Crypto.VerifyPasswordCom(Username, Password);

            Encoder.HtmlEncode(Username);
            Encoder.HtmlEncode(Password);

            if (passVerified)
            {
                Context.Response.Cookies["authcookie"]["username"] = SessionCrypto.Encrypt(Username);
                Context.Response.Cookies["authcookie"]["password"] = SessionCrypto.Encrypt(Password);
                Context.Response.Cookies["authcookie"].Expires = DateTime.Now.AddDays(2);

                if (Context.Response.Cookies["authcookie"]["username"] == SessionCrypto.Encrypt(Username) && Context.Response.Cookies["authcookie"]["password"] == SessionCrypto.Encrypt(Password))
                {
                    Context.Session["UnitName"] = SessionCrypto.Encrypt(Username);
                    Context.Session["IsDispatcher"] = "True";
                    Crypto.StoreIP(Username);
                    Context.Response.Redirect("CADC.aspx");
                }
                else
                {
                    Context.Session["UnitName"] = null;
                    Context.Session["IsDispatcher"] = null;
                    Context.Response.Cookies["authcookie"]["username"] = null;
                    Context.Response.Cookies["authcookie"]["password"] = null;
                }

            }
            else
            {
                Context.Session["User"] = null;
                Context.Session["IsLEO"] = null;
                Context.Session["IsDispatcher"] = null;
                Context.Session["IsCiv"] = null;
                Context.Session["IsAdmin"] = null;
                Context.Session["CivilianUser"] = null;
                Context.Session["UnitName"] = null;
                Context.Response.Cookies["authcookie"]["username"] = null;
                Context.Response.Cookies["authcookie"]["password"] = null;
                Context.Response.Redirect("default.aspx?error=1");
            }
        }

        /// <summary>
        /// Login Method for Civ
        /// </summary>
        public static void LoginMethodCiv(String Username, String Password)
        {
            var Context = HttpContext.Current;

            Encoder.HtmlEncode(Username);
            Encoder.HtmlEncode(Password);

            bool passVerified = CryptoCiv.VerifyPassword(Username, Password);

            if (passVerified)
            {
                {
                    Context.Response.Cookies["authcookie"]["username"] = SessionCrypto.Encrypt(Username);
                    Context.Response.Cookies["authcookie"]["password"] = SessionCrypto.Encrypt(Password);
                    Context.Response.Cookies["authcookie"].Expires = DateTime.Now.AddDays(2);

                    if (Context.Response.Cookies["authcookie"]["username"] == SessionCrypto.Encrypt(Username) && Context.Response.Cookies["authcookie"]["password"] == SessionCrypto.Encrypt(Password))
                    {
                        Context.Session["CivilianUser"] = SessionCrypto.Encrypt(Username);
                        Context.Session["IsCIV"] = "True";
                        Crypto.StoreCivIP(Username);
                        Context.Response.Redirect("CivCAD.aspx");
                    }
                    else
                    {
                        Context.Session["CivilianUser"] = null;
                        Context.Session["IsCIV"] = null;
                        Context.Response.Cookies["authcookie"]["username"] = null;
                        Context.Response.Cookies["authcookie"]["password"] = null;
                    }
                }
            }
            else
            {
                Context.Session["User"] = null;
                Context.Session["IsLEO"] = null;
                Context.Session["IsDispatcher"] = null;
                Context.Session["IsCiv"] = null;
                Context.Session["IsAdmin"] = null;
                Context.Session["CivilianUser"] = null;
                Context.Session["UnitName"] = null;
                Context.Response.Cookies["authcookie"]["username"] = null;
                Context.Response.Cookies["authcookie"]["password"] = null;
                Context.Response.Redirect("default.aspx?error=1");
            }
        }

        /// <summary>
        /// Register Mehtod for Civ
        /// </summary>
        public static void RegisterMethodCiv(String Username, String Password, String Email, String Name)
        {
            var Context = HttpContext.Current;

            Encoder.HtmlEncode(Username);
            Encoder.HtmlEncode(Password);
            Encoder.HtmlEncode(Email);
            Encoder.HtmlEncode(Name);

            //Get the encrypt the password by using the class  
            String pass = Crypto.encryption(Password);
            //Check whether the UseName and password are Empty  
            if (Username.Length > 0 && Password.Length > 0)
            {
                //creating the connection string              
                String connection = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                SqlConnection con = new SqlConnection(connection);

                String passwords = Crypto.strongHash(Password); //encryption(password);
                con.Open();
                // Check whether the Username Found in the Existing DB  
                String search = "SELECT * FROM [registered_civs] WHERE ([Username] = @civUser OR [Email] = @civEmail);";

                SqlCommand cmds = new SqlCommand(search, con);
                cmds.Parameters.AddWithValue("@civUser", Username);
                cmds.Parameters.AddWithValue("@civEmail", Email);
                SqlDataReader sqldrs = cmds.ExecuteReader();

                if (sqldrs.Read())
                {
                    String passed = (String)sqldrs["Password"];

                }
                else
                {
                    try
                    {
                        sqldrs.Close();
                        // if the Username not found create the new user accound  
                        String sql = "INSERT INTO [registered_civs] ([Name], [Username], [Password], [Email], [isApproved], [isBanned]) " +
                        "VALUES (@civName, @civUsername, @civPassword, @civEmail, @isapproved, @isbanned)";
                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@civName", Name);
                        cmd.Parameters.AddWithValue("@civUsername", Username);
                        cmd.Parameters.AddWithValue("@civPassword", passwords);
                        cmd.Parameters.AddWithValue("@civEmail", Email);
                        cmd.Parameters.AddWithValue("@isapproved", "Yes");
                        cmd.Parameters.AddWithValue("@isbanned", "No");
                        cmd.ExecuteNonQuery();
                        Context.Session["CivilianUser"] = SessionCrypto.Encrypt(Username);
                        Context.Session["IsCIV"] = "Yes";
                        Context.Response.Redirect("default.aspx?approval=1");

                    }
                    catch
                    {
                    }
                    con.Close();
                }
            }

            else
            {
                
            }
        }
    }
}
