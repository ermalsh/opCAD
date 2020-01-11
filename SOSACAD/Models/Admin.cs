using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;


namespace SoSACAD.Models
{
    public class Admin
    {
        [WebMethod]
        public static int GetRegisteredUsersCount()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            int count = 0;
            SqlCommand com = new SqlCommand("Registered_Users_Count", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();
            count = (int)com.ExecuteScalar();
            con.Close();
            return count;
        }

        [WebMethod]
        public static int GetRegisteredCivsCount()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            int count = 0;
            SqlCommand com = new SqlCommand("Registered_Civs_Count", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();
            count = (int)com.ExecuteScalar();
            con.Close();
            return count;
        }

        [WebMethod]
        public static int GetCallTotalCount()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            int count = 0;
            SqlCommand com = new SqlCommand("Calls_Total_Count", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();
            count = (int)com.ExecuteScalar();
            con.Close();
            return count;
        }
        
    }
}