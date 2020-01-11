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
    public partial class CivCAD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CivilianUser"] == null || Session["IsCiv"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {

            }
        }

    
        [WebMethod]
        public static GetCivs[] GetAllCivs(String Username)
        {
            List <GetCivs> civs = new List<GetCivs>();
            string query = string.Format("SELECT * FROM [civilians] WHERE Username = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(Username)) + "' AND Active = 'Yes'");
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetCivs civ = new GetCivs();
                        civ.ID = Convert.ToString(reader.GetInt32(0));
                        civ.Full_Name = reader["Full_Name"].ToString();
                        civ.First_Name = reader["First_Name"].ToString();
                        civ.Last_Name = reader["Last_Name"].ToString();
                        civ.License_Number = reader["License_Number"].ToString();
                        civ.Address = reader["Address"].ToString();
                        civ.License_Status = reader["License_Status"].ToString();
                        civ.Active_Warrant = reader["Active_Warrant"].ToString();
                        civ.DOB = reader["DOB"].ToString();
                        civ.Gender = reader["Gender"].ToString();
                        civ.Hair = reader["Hair"].ToString();
                        civ.Ethnicity = reader["Ethnicity"].ToString();
                        civ.Weight = reader["Weight"].ToString();
                        civ.License_Expiration = reader["License_Expiration"].ToString();
                        civ.License_State = reader["License_State"].ToString();
                        civ.First_Name = reader["First_Name"].ToString();
                        civ.Portrait = reader["Portrait"].ToString();
                        civs.Add(civ);
                    }
                }
            }
            return civs.ToArray();
        }

        [WebMethod]
        public static GetTickets[] GetMyTickets(String Owner)
        {
            List<GetTickets> tickets = new List<GetTickets>();
            string query = string.Format("SELECT * FROM [tickets] WHERE [Full_Name] =  '" + Encoder.HtmlEncode(Owner) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetTickets ticket = new GetTickets();
                        ticket.ID = Convert.ToString(reader.GetInt32(0));
                        ticket.Full_Name = reader["Full_Name"].ToString();
                        ticket.Date = reader["Date"].ToString();
                        ticket.Ticket_Details = reader["Ticket_Details"].ToString();
                        ticket.Ticket_Unit = reader["Ticket_Unit"].ToString();
                        ticket.Ticket_Location = reader["Ticket_Location"].ToString();
                        ticket.Ticket_Fine = reader["Ticket_Fine"].ToString();
                        ticket.Ticket_Jailtime = reader["Ticket_Jailtime"].ToString();
                        ticket.Ticket_Warrant_Active = reader["Ticket_Warrant_Active"].ToString();
                        ticket.Ticket_Charges = reader["Ticket_Charges"].ToString();
                        ticket.License_Number = reader["License_Number"].ToString();
                        tickets.Add(ticket);
                    }
                }
            }
            return tickets.ToArray();
        }

        [WebMethod]
        public static GetVehs[] GetMyVehicles(String Owner)
        {
            List<GetVehs> vehs = new List<GetVehs>();
            string query = string.Format("SELECT * FROM [vehicles] WHERE [Owner] = '" + Encoder.HtmlEncode(Owner) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetVehs veh = new GetVehs();
                        veh.ID = Convert.ToString(reader.GetInt32(0));
                        veh.Model = reader["Model"].ToString();
                        veh.Color = reader["Color"].ToString();
                        veh.License_Number = reader["License_Number"].ToString();
                        veh.Owner = reader["Owner"].ToString();
                        veh.Registration_Valid = reader["Registration_Valid"].ToString();
                        veh.Insurance_Valid = reader["Insurance_Valid"].ToString();
                        veh.Username = reader["Username"].ToString();
                        veh.Make = reader["Make"].ToString();
                        vehs.Add(veh);
                    }
                }
            }
            return vehs.ToArray();
        }

        [WebMethod]
        public static GetFirearms[] GetMyFirearms(String Owner)
        {
            List<GetFirearms> firearms = new List<GetFirearms>();
            string query = string.Format("SELECT * FROM [firearms] WHERE [Registrant] =  '" + Encoder.HtmlEncode(Owner) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetFirearms firearm = new GetFirearms();
                        firearm.Type = reader["Type"].ToString();
                        firearm.Name = reader["Firearm_Name"].ToString();
                        firearm.Date = reader["Date_Issued"].ToString();
                        firearm.DateExp = reader["Date_Expiration"].ToString();
                        firearm.Registrant = reader["Registrant"].ToString();
                        firearm.Dept = reader["Department_Issued"].ToString();
                        firearm.LicenseNumber = reader["License_Number"].ToString();
                        firearms.Add(firearm);
                    }
                }
            }
            return firearms.ToArray();
        }

        [WebMethod]
        public static GetCivs[] GetMyCivs(String Username)
        {
            List<GetCivs> civs = new List<GetCivs>();
            string query = string.Format("SELECT * FROM [civilians] WHERE Username = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(Username)) + "' AND Active = 'No'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetCivs civ = new GetCivs();
                        civ.ID = Convert.ToString(reader.GetInt32(0));
                        civ.Full_Name = reader["Full_Name"].ToString();
                        civ.First_Name = reader["First_Name"].ToString();
                        civ.Last_Name = reader["Last_Name"].ToString();
                        civ.License_Number = reader["License_Number"].ToString();
                        civ.Address = reader["Address"].ToString();
                        civ.License_Status = reader["License_Status"].ToString();
                        civ.Active_Warrant = reader["Active_Warrant"].ToString();
                        civ.DOB = reader["DOB"].ToString();
                        civ.Gender = reader["Gender"].ToString();
                        civ.Hair = reader["Hair"].ToString();
                        civ.Ethnicity = reader["Ethnicity"].ToString();
                        civ.Weight = reader["Weight"].ToString();
                        civ.License_Expiration = reader["License_Expiration"].ToString();
                        civ.License_State = reader["License_State"].ToString();
                        civ.First_Name = reader["First_Name"].ToString();
                        civ.Username = reader["Username"].ToString();
                        civ.Portrait = reader["Portrait"].ToString();
                        civs.Add(civ);
                    }
                }
            }
            return civs.ToArray();
        }

        [WebMethod]
        public static string[] GetStats(String Civilian, String Username)
        {
            string vehicles = "SELECT COUNT(*) FROM [vehicles] WHERE [Owner] = '" + Encoder.HtmlEncode(Civilian) + "'";
            string warning = "SELECT COUNT(*) FROM [tickets] WHERE [Ticket_Charges] = 'Warning' AND [Full_Name] = '" + Encoder.HtmlEncode(Civilian) + "'";
            string tickets = "SELECT COUNT(*) FROM [tickets] WHERE [Ticket_Charges] != 'Warning' AND [Full_Name] = '" + Encoder.HtmlEncode(Civilian) + "'";
            string civilians = "SELECT COUNT(*) FROM [civilians] WHERE [Username] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(Username)) + "'";
            int vehiclesCount = 0;
            int warningCount = 0;
            int ticketCount = 0;
            int civiliansCount = 0;

            using (SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmdCount = new SqlCommand(vehicles, thisConnection))
                {
                    thisConnection.Open();
                    vehiclesCount = (int)cmdCount.ExecuteScalar();
                }
                using (SqlCommand cmdCount = new SqlCommand(warning, thisConnection))
                {
                    warningCount = (int)cmdCount.ExecuteScalar();
                }
                using (SqlCommand cmdCount = new SqlCommand(tickets, thisConnection))
                {
                    ticketCount = (int)cmdCount.ExecuteScalar();
                }
                using (SqlCommand cmdCount = new SqlCommand(civilians, thisConnection))
                {
                    civiliansCount = (int)cmdCount.ExecuteScalar();
                    thisConnection.Close();
                }

                string stats = vehiclesCount + "," + warningCount + "," + ticketCount + "," + civiliansCount;
                string[] statsArray = stats.Split(',');
                return statsArray;

            }

        }

        [WebMethod]
        public static string SwitchCivilian(String License, String Username)
        {
            string query = "UPDATE [civilians] SET [Active] = 'No' WHERE [Username] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(Username)) + "'";
            string query2 = "UPDATE [civilians] SET [Active] = 'Yes' WHERE [License_Number] = '" + License + "' AND [Username] = '" + Encoder.HtmlEncode(SessionCrypto.Decrypt(Username)) + "'";
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
               
                }

                using (SqlCommand cmd2 = new SqlCommand(query2, con))
                {
                    cmd2.ExecuteNonQuery();
                    con.Close();
                }

            }

            return "Success";
        }

        [WebMethod]
        public static string CreateCivilian(String FirstName, String LastName, String DOB, String Address, String Gender, String Hair, String Ethnicity, String Weight, String LicenseNumber, String LicenseState, String LicenseExpDate, String Username, String ImagePortrait, String LicenseStatus)
        {
            String FullName = FirstName + " " + LastName;
            string query = string.Format("INSERT INTO [civilians] (License_Number, Address, License_Status, First_Name, Last_Name, DOB, Gender, Hair, Ethnicity, Weight, License_Expiration, License_State, Full_Name, Username, Portrait)" +
                "values('" + Encoder.HtmlEncode(LicenseNumber) + "','" + Encoder.HtmlEncode(Address) + "','"+ Encoder.HtmlEncode(LicenseStatus) +"','" + Encoder.HtmlEncode(FirstName) + "','" + Encoder.HtmlEncode(LastName) + "','" + Encoder.HtmlEncode(DOB) + "','" + Encoder.HtmlEncode(Gender) + "','" + Encoder.HtmlEncode(Hair) + "','" + Encoder.HtmlEncode(Ethnicity) + "','" + Encoder.HtmlEncode(Weight) + "','" + Encoder.HtmlEncode(LicenseExpDate) + "','" + Encoder.HtmlEncode(LicenseState) + "','" + Encoder.HtmlEncode(FullName) + "','" + Encoder.HtmlEncode(SessionCrypto.Decrypt(Username)) + "'" +
                ",'" + ImagePortrait + "')");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            SwitchCivilian(LicenseNumber, Username);
            return FullName;
        }

        [WebMethod]
        public static string RegisterVehicle(String Owner, String Model, String Make, String Color, String Plate, String User, String Insurance, String Registration, String Stolen)
        {
            string query = string.Format("INSERT INTO [vehicles] (Model, Make, Color, License_Number, Owner, Registration_Valid, Insurance_Valid, Stolen, Username)" +
                "values('" + Encoder.HtmlEncode(Model) + "','" + Encoder.HtmlEncode(Make) + "','" + Encoder.HtmlEncode(Color) + "','" + Encoder.HtmlEncode(Plate) + "','" + Encoder.HtmlEncode(Owner) + "','" + Encoder.HtmlEncode(Registration) + "','" + Encoder.HtmlEncode(Insurance) + "','" + Encoder.HtmlEncode(Stolen) + "','" + Encoder.HtmlEncode(SessionCrypto.Decrypt(User)) + "')");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            return "Success";
        }

        [WebMethod]
        public static string RegisterFirearm(String Type, String Name, String Date, String DateExp, String Registrant, String Dept, String LicenseNumber)
        {
            string query = string.Format("INSERT INTO [firearms] (Type, Firearm_Name, Date_Issued, Date_Expiration, Registrant, Department_Issued, License_Number)" +
                "values('" + Encoder.HtmlEncode(Type) + "','" + Encoder.HtmlEncode(Name) + "','" + Encoder.HtmlEncode(Date) + "','" + Encoder.HtmlEncode(DateExp) + "','" + Encoder.HtmlEncode(Registrant) + "','" + Encoder.HtmlEncode(Dept) + "','" + Encoder.HtmlEncode(LicenseNumber) +"')");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            return "Success";
        }

        [WebMethod]
        public static string CreateTicket(String FullName, String TicketDate, String TicketUnit, String TicketLocation, String TicketLicenseNumber, String TicketDetails, String TicketCharges, String TicketFines)
        {
            string query = string.Format("INSERT INTO [tickets] (Full_Name, Date, Ticket_Unit, Ticket_Location, License_Number, Ticket_Details, Ticket_Charges, Ticket_Fine)" +
                "values('" + Encoder.HtmlEncode(FullName) + "','" + Encoder.HtmlEncode(TicketDate) + "','" + Encoder.HtmlEncode(TicketUnit) + "','" + Encoder.HtmlEncode(TicketLocation) + "','" + Encoder.HtmlEncode(TicketLicenseNumber) + "','" + Encoder.HtmlEncode(TicketDetails) + "','" + Encoder.HtmlEncode(TicketCharges) + "','" + Encoder.HtmlEncode(TicketFines) + "')");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            return "Success";
        }

        [WebMethod]
        public static string CreateCall(String CallerName, String CallDate, String CallLocation, String CallDetails)
        {
            try
            {

            string Status = "Pending";
            string query = string.Format("INSERT INTO [call_reports] (Caller, Location, Date_Time, Description, Status)" +
                "values('" + Encoder.HtmlEncode(CallerName) + "','" + Encoder.HtmlEncode(CallLocation) + "','" + Encoder.HtmlEncode(CallDate) + "','" + Encoder.HtmlEncode(CallDetails) + "','" + Encoder.HtmlEncode(Status) + "')");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            return "Success";
            }
                catch
            {
                return "Error";
            }
           
        }

        [WebMethod]
        public static string ChangeCivilianImage(String URL, String FullName)
        {
            string query = "UPDATE [civilians] SET [Portrait] = '" + Encoder.HtmlEncode(URL) + "' WHERE [Full_Name] = '" + Encoder.HtmlEncode(FullName) + "'";
           
            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                }
            }

            return "Success";
        }
    }
}