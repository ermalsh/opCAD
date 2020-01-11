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
using Newtonsoft.Json;
using SoSACAD.Models;

namespace SoSACAD
{
    public partial class CAD1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null || Session["IsLEO"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {
            }
        }

        [WebMethod]
        public static GetCivs[] WarrantReport(String License)
        {
            List<GetCivs> civs = new List<GetCivs>();
            string query = string.Format("SELECT * FROM [civilians] WHERE [License_Number] =  '" + Encoder.HtmlEncode(License) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetCivs civ = new GetCivs
                        {
                            ID = Convert.ToString(reader.GetInt32(0)),
                            Full_Name = reader["Full_Name"].ToString(),
                            First_Name = reader["First_Name"].ToString(),
                            Last_Name = reader["Last_Name"].ToString(),
                            License_Number = reader["License_Number"].ToString(),
                            Address = reader["Address"].ToString(),
                            License_Status = reader["License_Status"].ToString(),
                            Active_Warrant = reader["Active_Warrant"].ToString(),
                            DOB = reader["DOB"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Hair = reader["Hair"].ToString(),
                            Ethnicity = reader["Ethnicity"].ToString(),
                            Weight = reader["Weight"].ToString(),
                            License_Expiration = reader["License_Expiration"].ToString(),
                            License_State = reader["License_State"].ToString()
                        };
                        civ.First_Name = reader["First_Name"].ToString();
                        civs.Add(civ);
                    }
                }
            }
            return civs.ToArray();
        }

        [WebMethod]
        public static GetCivs[] ArrestReport(String License)
        {
            List<GetCivs> civs = new List<GetCivs>();
            string query = string.Format("SELECT * FROM [civilians] WHERE [License_Number] =  '" + Encoder.HtmlEncode(License) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetCivs civ = new GetCivs
                        {
                            ID = Convert.ToString(reader.GetInt32(0)),
                            Full_Name = reader["Full_Name"].ToString(),
                            First_Name = reader["First_Name"].ToString(),
                            Last_Name = reader["Last_Name"].ToString(),
                            License_Number = reader["License_Number"].ToString(),
                            Address = reader["Address"].ToString(),
                            License_Status = reader["License_Status"].ToString(),
                            Active_Warrant = reader["Active_Warrant"].ToString(),
                            DOB = reader["DOB"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Hair = reader["Hair"].ToString(),
                            Ethnicity = reader["Ethnicity"].ToString(),
                            Weight = reader["Weight"].ToString(),
                            License_Expiration = reader["License_Expiration"].ToString(),
                            License_State = reader["License_State"].ToString()
                        };
                        civ.First_Name = reader["First_Name"].ToString();
                        civs.Add(civ);
                    }
                }
            }
            return civs.ToArray();
        }

        [WebMethod]
        public static GetCivs[] TicketReport(String License)
        {
            List<GetCivs> civs = new List<GetCivs>();
            string query = string.Format("SELECT * FROM [civilians] WHERE [License_Number] =  '" + Encoder.HtmlEncode(License) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetCivs civ = new GetCivs
                        {
                            ID = Convert.ToString(reader.GetInt32(0)),
                            Full_Name = reader["Full_Name"].ToString(),
                            First_Name = reader["First_Name"].ToString(),
                            Last_Name = reader["Last_Name"].ToString(),
                            License_Number = reader["License_Number"].ToString(),
                            Address = reader["Address"].ToString(),
                            License_Status = reader["License_Status"].ToString(),
                            Active_Warrant = reader["Active_Warrant"].ToString(),
                            DOB = reader["DOB"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Hair = reader["Hair"].ToString(),
                            Ethnicity = reader["Ethnicity"].ToString(),
                            Weight = reader["Weight"].ToString(),
                            License_Expiration = reader["License_Expiration"].ToString(),
                            License_State = reader["License_State"].ToString()
                        };
                        civ.First_Name = reader["First_Name"].ToString();
                        civs.Add(civ);
                    }
                }
            }
            return civs.ToArray();
        }

        [WebMethod]
        public static GetCivs[] WarningReport(String License)
        {
            List<GetCivs> civs = new List<GetCivs>();
            string query = string.Format("SELECT * FROM [civilians] WHERE [License_Number] =  '" + Encoder.HtmlEncode(License) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetCivs civ = new GetCivs
                        {
                            ID = Convert.ToString(reader.GetInt32(0)),
                            Full_Name = reader["Full_Name"].ToString(),
                            First_Name = reader["First_Name"].ToString(),
                            Last_Name = reader["Last_Name"].ToString(),
                            License_Number = reader["License_Number"].ToString(),
                            Address = reader["Address"].ToString(),
                            License_Status = reader["License_Status"].ToString(),
                            Active_Warrant = reader["Active_Warrant"].ToString(),
                            DOB = reader["DOB"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Hair = reader["Hair"].ToString(),
                            Ethnicity = reader["Ethnicity"].ToString(),
                            Weight = reader["Weight"].ToString(),
                            License_Expiration = reader["License_Expiration"].ToString(),
                            License_State = reader["License_State"].ToString()
                        };
                        civ.First_Name = reader["First_Name"].ToString();
                        civs.Add(civ);
                    }
                }
            }
            return civs.ToArray();
        }

        [WebMethod]
        public static GetArrests[] CivArrestDetails(String ID)
        {
            List<GetArrests> arrests = new List<GetArrests>();
            string query = string.Format("SELECT * FROM [arrests] WHERE [ID] =  '" + Encoder.HtmlEncode(ID) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetArrests arrest = new GetArrests
                        {
                            ID = Convert.ToString(reader.GetInt32(0)),
                            Full_Name = reader["Full_Name"].ToString(),
                            Date = reader["Date"].ToString(),
                            Arrest_Details = reader["Arrest_Details"].ToString(),
                            Arrest_Unit = reader["Arrest_Unit"].ToString(),
                            Arrest_Location = reader["Arrest_Location"].ToString(),
                            Arrest_Fine = reader["Arrest_Fine"].ToString(),
                            Arrest_Jailtime = reader["Arrest_Jailtime"].ToString(),
                            Arrest_Warrant_Active = reader["Arrest_Warrant_Active"].ToString(),
                            Arrest_Charges = reader["Arrest_Charges"].ToString(),
                            License_Number = reader["License_Number"].ToString()
                        };
                        arrests.Add(arrest);
                    }
                }
            }
            return arrests.ToArray();
        }

        [WebMethod]
        public static GetTickets[] CivTicketDetails(String ID)
        {
            List<GetTickets> tickets = new List<GetTickets>();
            string query = string.Format("SELECT * FROM [tickets] WHERE [ID] =  '" + Encoder.HtmlEncode(ID) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetTickets ticket = new GetTickets
                        {
                            ID = Convert.ToString(reader.GetInt32(0)),
                            Full_Name = reader["Full_Name"].ToString(),
                            Date = reader["Date"].ToString(),
                            Ticket_Details = reader["Ticket_Details"].ToString(),
                            Ticket_Unit = reader["Ticket_Unit"].ToString(),
                            Ticket_Location = reader["Ticket_Location"].ToString(),
                            Ticket_Fine = reader["Ticket_Fine"].ToString(),
                            Ticket_Jailtime = reader["Ticket_Jailtime"].ToString(),
                            Ticket_Warrant_Active = reader["Ticket_Warrant_Active"].ToString(),
                            Ticket_Charges = reader["Ticket_Charges"].ToString(),
                            License_Number = reader["License_Number"].ToString()
                        };
                        tickets.Add(ticket);
                    }
                }
            }
            return tickets.ToArray();
        }

        [WebMethod]
        public static GetWarrants[] CivWarrantDetails(String ID)
        {
            List<GetWarrants> warrants = new List<GetWarrants>();
            string query = string.Format("SELECT * FROM [warrants] WHERE [ID] =  '" + Encoder.HtmlEncode(ID) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetWarrants warrant = new GetWarrants
                        {
                            ID = Convert.ToString(reader.GetInt32(0)),
                            Full_Name = reader["Full_Name"].ToString(),
                            License_Number = reader["License_Number"].ToString(),
                            Warrant_Issued = reader["Warrant_Issued"].ToString(),
                            Warrant_Charges = reader["Warrant_Charges"].ToString(),
                            Warrant_Department = reader["Warrant_Department"].ToString(),
                            Warrant_Status = reader["Warrant_Status"].ToString(),
                            Warrant_Results = reader["Warrant_Results"].ToString(),
                            Warrant_Officer = reader["Warrant_Officer"].ToString()
                        };
                        warrants.Add(warrant);
                    }
                }
            }
            return warrants.ToArray();
        }

        [WebMethod(EnableSession = true)] 
        public static string SetPatrolStatus(String UnitNumber)
        {
            HttpContext.Current.Session["OnPatrol"] = "Yes";
            string date = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            using (SqlConnection con =
                 new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query2 = string.Format("INSERT INTO [timeclock_hours] (Unit, Type, DateTime) values('" + Encoder.HtmlEncode(UnitNumber) + "', 'In','" + Encoder.HtmlEncode(date) + "')");
                using (SqlCommand cmd = new SqlCommand(query2, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "on patrol";
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static string RemovePatrolStatus(String UnitNumber)
        {
            HttpContext.Current.Session["OnPatrol"] = null;
            string date = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
            using (SqlConnection con =
                 new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query2 = string.Format("INSERT INTO [timeclock_hours] (Unit, Type, DateTime) values('" + Encoder.HtmlEncode(UnitNumber) + "', 'Out','" + Encoder.HtmlEncode(date) + "')");
                using (SqlCommand cmd = new SqlCommand(query2, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "on patrol";
                }
            }
        }

        [WebMethod]
        public static string[] GetStats(String UnitNumber)
        {
            string ticket = "SELECT COUNT(*) FROM [tickets] WHERE [Ticket_Unit] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
            string warning = "SELECT COUNT(*) FROM [tickets] WHERE [Ticket_Charges] = 'Warning' AND [Ticket_Unit] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
            string arrest = "SELECT COUNT(*) FROM [arrests] WHERE [Arrest_Unit] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
            string calls = "SELECT COUNT(*) FROM [call_reports] WHERE [Unit_Responding] = '" + Encoder.HtmlEncode(UnitNumber) + "'";
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
        public static string UpdateUnitStatus108(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-8' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
                string query = "UPDATE [registered_users] SET [Status] = '10-6' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
                string query = "UPDATE [registered_users] SET [Status] = '10-7' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
                string query = "UPDATE [registered_users] SET [Status] = '10-5' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
                string query = "UPDATE [registered_users] SET [Status] = '10-41' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
                string query = "UPDATE [registered_users] SET [Status] = '10-42' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
                string query = "UPDATE [registered_users] SET [Status] = '10-23' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
                string query = "UPDATE [registered_users] SET [Status] = '10-97' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
                string query = "UPDATE [registered_users] SET [Status] = '10-19' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string UpdateUnitStatusCodeZero(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = 'CODE ZERO' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string UpdateUnitStatus1015(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-15' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string UpdateUnitStatus1011(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-11' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string UpdateUnitStatus1012(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = '10-12' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string UpdateUnitStatusSignal11(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string query = "UPDATE [registered_users] SET [Status] = 'SIGNAL 11' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string DivisionSAFD(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string imageFD = "SAFD";
                string query = "UPDATE [registered_users] SET [Unit_Icon] = '" + Encoder.HtmlEncode(imageFD) + "' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string DivisionEMS(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string imageEMS = "EMS";
                string query = "UPDATE [registered_users] SET [Unit_Icon] = '" + Encoder.HtmlEncode(imageEMS) + "' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string DivisionSAHP(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string imageSAHP = "SAHP";
                string query = "UPDATE [registered_users] SET [Unit_Icon] = '" + Encoder.HtmlEncode(imageSAHP) + "' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
                
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
        public static string DivisionLSPD(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string imageLspd = "LSPD";
                string query = "UPDATE [registered_users] SET [Unit_Icon] = '" + Encoder.HtmlEncode(imageLspd) + "' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string DivisionBCSO(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string imageBcso = "BCSO";
                string query = "UPDATE [registered_users] SET [Unit_Icon] = '" + Encoder.HtmlEncode(imageBcso) + "' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
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
        public static string DivisionSWAT(String UnitNumber)
        {
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                string swatImage = "SWAT";
                string query = "UPDATE [registered_users] SET [Unit_Icon] = '" + Encoder.HtmlEncode(swatImage) + "' WHERE [Unit_Number] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(UnitNumber)) + "'";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }
    }
}