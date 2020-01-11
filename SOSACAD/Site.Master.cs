using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace SoSACAD
{
    public partial class SiteMaster : MasterPage
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