using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoSACAD
{
    public partial class CADSA : System.Web.UI.MasterPage
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
            Session["SuperAdminUser"] = null;
            Session["IsSuperAdmin"] = null;
            Response.Redirect("default.aspx");
        }

    }
}