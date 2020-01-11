using System;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using SoSACAD.Models;
using System.Web;

namespace SoSACAD
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["error"] == "1")
            {
                Label1.Text = "Invalid Credentials, Not Approved, Not a Dispatcher, or Banned... You can choose.";
            } else if(Request.QueryString["approval"] == "1")
            {
                Label1.Text = "Account Created Successfully. Please wait for an Admin to Approve your account.";
            }
        }

        public static string Username { get; private set; }
        public static string Password { get; private set; }
        public static string Email { get; private set; }
        public static string Name { get; private set; }

        protected void LeoLoginInit(object sender, EventArgs e)
        {
            Username = Request.Form["leousername"];
            Password = Request.Form["leopassword"];

            if (GoDispatch.Checked == true)
            {
                LoginHandler.LoginMethodCom(Username, Password);
            }
            else
            {
                LoginHandler.LoginMethodLEO(Username, Password);
            }
        }

        protected void CivLoginInit(object sender, EventArgs e)
        {
            Username = Request.Form["civusername"];
            Password = Request.Form["civpassword"];
            LoginHandler.LoginMethodCiv(Username, Password);
        }

        protected void CivRegisterInit(object sender, EventArgs e)
        {
            Name = Request.Form["civNewName"];
            Username = Request.Form["civNewUsername"];
            Password = Request.Form["civNewPassword"];
            Email = Request.Form["civNewEmail"];
            LoginHandler.RegisterMethodCiv(Username, Password, Email, Name);
        }
    }
}