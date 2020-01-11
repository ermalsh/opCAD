using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Security.Application;
using SoSACAD.Models;

namespace SoSACAD
{
    public partial class CADSV : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UnitName"] == null || Session["IsDispatcher"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {

            }
        }

        
        [WebMethod]
        public static GetCalls[] GetAllCalls()
        {
            List<GetCalls> calls = new List<GetCalls>();
            string query = string.Format("SELECT [ID], [Caller], [Location], [Description], [Date_Time], [Unit_Responding], [Status], [Notes] FROM [call_reports] Order By ID DESC");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetCalls call = new GetCalls();
                        call.ID = Convert.ToString(reader.GetInt32(0));
                        call.Caller = reader["Caller"].ToString();
                        call.Location = reader["Location"].ToString();
                        call.Description = reader["Description"].ToString();
                        call.Date_Time = reader["Date_Time"].ToString();
                        call.Unit_Responding = reader["Unit_Responding"].ToString();
                        call.Status = reader["Status"].ToString();
                        call.Notes = reader["Notes"].ToString();
                        calls.Add(call);
                    }
                }
            }
            return calls.ToArray();
        }

        [WebMethod]
        public static GetCalls[] GetCall(String CallID)
        {
            List<GetCalls> calls = new List<GetCalls>();
            string query = string.Format("SELECT [ID], [Caller], [Location], [Description], [Date_Time], [Unit_Responding], [Status] FROM [call_reports] WHERE [ID] = '" + Encoder.HtmlEncode(CallID) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetCalls call = new GetCalls();
                        call.ID = Convert.ToString(reader.GetInt32(0));
                        call.Caller = reader["Caller"].ToString();
                        call.Location = reader["Location"].ToString();
                        call.Description = reader["Description"].ToString();
                        call.Date_Time = reader["Date_Time"].ToString();
                        call.Unit_Responding = reader["Unit_Responding"].ToString();
                        call.Status = reader["Status"].ToString();
                        calls.Add(call);
                    }
                }
            }
            return calls.ToArray();
        }

        [WebMethod]
        public static GetUnits[] GetUnitData(String UnitNumber)
        {
            List<GetUnits> units = new List<GetUnits>();
            string query = string.Format("SELECT * FROM [registered_users] WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetUnits unit = new GetUnits();
                        unit.ID = Convert.ToString(reader.GetInt32(0));
                        unit.Unit_Number = reader["Primary_Identifier"].ToString();
                        unit.Name = reader["Name"].ToString();
                        unit.Division = reader["Division"].ToString();
                        unit.Sub_Division = reader["Sub_Division"].ToString();
                        unit.Sub_Division_2 = reader["Sub_Division_2"].ToString();
                        unit.Sub_Division_3 = reader["Sub_Division_3"].ToString();
                        unit.Sub_Division_4 = reader["Sub_Division_4"].ToString();
                        unit.isNewUser = reader["isNewUser"].ToString();
                        unit.isDispatcher = reader["isDispatcher"].ToString();
                        unit.isAdmin = reader["isAdmin"].ToString();
                        unit.Status = reader["Status"].ToString();
                        unit.UnitIcon = reader["Unit_Icon"].ToString();
                        units.Add(unit);
                    }
                }
            }
            return units.ToArray();
        }

        [WebMethod]
        public static GetUnits[] GetAllUnits()
        {
            List<GetUnits> units = new List<GetUnits>();
            string query = string.Format("SELECT * FROM [registered_users] Order By ID DESC");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetUnits unit = new GetUnits();
                        unit.ID = Convert.ToString(reader.GetInt32(0));
                        unit.Unit_Number = reader["Primary_Identifier"].ToString();
                        unit.Name = reader["Name"].ToString();
                        unit.Division = reader["Division"].ToString();
                        unit.Sub_Division = reader["Sub_Division"].ToString();
                        unit.Sub_Division_2 = reader["Sub_Division_2"].ToString();
                        unit.Sub_Division_3 = reader["Sub_Division_3"].ToString();
                        unit.Sub_Division_4 = reader["Sub_Division_4"].ToString();
                        unit.isNewUser = reader["isNewUser"].ToString();
                        unit.isDispatcher = reader["isDispatcher"].ToString();
                        unit.isAdmin = reader["isAdmin"].ToString();
                        unit.Status = reader["Status"].ToString();
                        unit.UnitIcon = reader["Unit_Icon"].ToString();
                        units.Add(unit);
                    }
                }
            }
            return units.ToArray();
        }

        [WebMethod]
        public static GetUnits[] LoadUnit(String UnitNumber)
        {
            List<GetUnits> units = new List<GetUnits>();
            string query = string.Format("SELECT * FROM [registered_users] WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetUnits unit = new GetUnits();
                        unit.ID = Convert.ToString(reader.GetInt32(0));
                        unit.Unit_Number = reader["Primary_Identifier"].ToString();
                        unit.Name = reader["Name"].ToString();
                        unit.Division = reader["Division"].ToString();
                        unit.Sub_Division = reader["Sub_Division"].ToString();
                        unit.Sub_Division_2 = reader["Sub_Division_2"].ToString();
                        unit.Sub_Division_3 = reader["Sub_Division_3"].ToString();
                        unit.Sub_Division_4 = reader["Sub_Division_4"].ToString();
                        unit.isNewUser = reader["isNewUser"].ToString();
                        unit.isDispatcher = reader["isDispatcher"].ToString();
                        unit.isAdmin = reader["isAdmin"].ToString();
                        unit.Status = reader["Status"].ToString();
                        units.Add(unit);
                    }
                }
            }
            return units.ToArray();
        }


        [WebMethod]
        public static string[] GetStats()
        {
            string ticket = "SELECT COUNT(*) FROM [tickets]";
            string warning = "SELECT COUNT(*) FROM [tickets] WHERE [Ticket_Charges] = 'Warning'";
            string arrest = "SELECT COUNT(*) FROM [arrests]";
            string calls = "SELECT COUNT(*) FROM [call_reports]";
            int ticketCount = 0;
            int warningCount = 0;
            int callsResponded = 0;
            int arrestCount = 0;

            using (SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmdCount = new SqlCommand(ticket, thisConnection))
                {
                    thisConnection.Open();
                    ticketCount = (int)cmdCount.ExecuteScalar();
                }
                using (SqlCommand cmdCount = new SqlCommand(warning, thisConnection))
                {
                    warningCount = (int)cmdCount.ExecuteScalar();
                }
                using (SqlCommand cmdCount = new SqlCommand(arrest, thisConnection))
                {
                    arrestCount = (int)cmdCount.ExecuteScalar();
                }
                using (SqlCommand cmdCount = new SqlCommand(calls, thisConnection))
                {
                    callsResponded = (int)cmdCount.ExecuteScalar();
                    thisConnection.Close();
                }

                string stats = ticketCount + "," + warningCount + "," + arrestCount + "," + callsResponded;
                string[] statsArray = stats.Split(',');
                return statsArray;

            }

        }


        [WebMethod]
        public static string AssignUnit(String UnitID, String UnitNumber)
        {
            using (SqlConnection con =
                  new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [call_reports] SET [Unit_Responding] = '" + Encoder.HtmlEncode(UnitNumber) + "', [Status] = 'Active' WHERE [ID] = '" + Encoder.HtmlEncode(UnitID) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string CodeFour(String CallID)
        {
            using (SqlConnection con =
                  new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [call_reports] SET [Status] = 'Closed' WHERE [ID] = '" + Encoder.HtmlEncode(CallID) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }


        [WebMethod]
        public static string UpdateUnitStatus108(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-8' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) +"'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUnitStatus106(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-6' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUnitStatus107(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-7' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUnitStatus105(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-5' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUnitStatus1041(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-41' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUnitStatus1042(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-42' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUnitStatus1023(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-23' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUnitStatus1097(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-97' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUnitStatus1019(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-19' WHERE [Primary_Identifier] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string CreateCall1099(String CallID)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [call_reports] SET [Notes] = '10-99' WHERE [ID] = '" + Encoder.HtmlEncode(CallID) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string CreateCallSignal100(String CallID)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [call_reports] SET [Notes] = 'Signal-100' WHERE [ID] = '" + Encoder.HtmlEncode(CallID) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateCall1020(String CallID, String Location)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [call_reports] SET [Location] = '" + Location + "' WHERE [ID] = '" + Encoder.HtmlEncode(CallID) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string CreateCall1032(String CallID, String UnitAdded)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string queryUpdateCallUnit = "UPDATE [call_reports] SET [Notes] = '10-32 Additional', [Unit_Responding] = [Unit_Responding] + ', " + Encoder.HtmlEncode(UnitAdded) + "' WHERE [ID] = '" + Encoder.HtmlEncode(CallID) + "'";
                using (SqlCommand cmd = new SqlCommand(queryUpdateCallUnit, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string CreateCall(String CallName, String CallDate, String CallStatus, String CallLocation, String CallDetails, String CallOfficer)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "INSERT INTO [call_reports] (Caller, Location, Description, Date_Time, Status, Unit_Responding) VALUES('" + Encoder.HtmlEncode(CallName) + "','" + Encoder.HtmlEncode(CallLocation) + "','" + Encoder.HtmlEncode(CallDetails) + "','" + Encoder.HtmlEncode(CallDate) + "','" + Encoder.HtmlEncode(CallStatus) + "','" + Encoder.HtmlEncode(CallOfficer) + "')";
               
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
              
            }
            return "success";
        }
    }
}




     
        