using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using SoSACAD.Models;

namespace SoSACAD
{
    public partial class CAD : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void LogOut(object sender, EventArgs e)
        {
            Session["User"] = null;
            Session["IsLEO"] = null;
            Session["IsDispatcher"] = null;
            Session["IsCiv"] = null;
            Session["CivilianUser"] = null;
            Session["UnitName"] = null;
            Response.Redirect("default.aspx");
        }
    }
}