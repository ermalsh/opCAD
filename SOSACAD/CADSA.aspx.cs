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
    public partial class CADSA1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SuperAdminUser"] == null || Session["IsSuperAdmin"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }
            else
            {

            }
        }

        [WebMethod]
        public int GetRegisteredUsersCount()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            int count = 0;
            SqlCommand com = new SqlCommand("Registered_Users_Count", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            return count;
        }

        [WebMethod]
        public static GetUnits[] GetAdminData(String UnitNumber)
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
        public static GetUnits[] GetUnitData(String ID)
        {
            List<GetUnits> units = new List<GetUnits>();
            string query = string.Format("SELECT * FROM [registered_users] WHERE [ID] = '"+ Encoder.HtmlEncode(ID) +"' AND isArchived = 'No'");

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
                        unit.LoginName = reader["Unit_Number"].ToString();
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
                        unit.isBanned = reader["isBanned"].ToString();
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
            string query = string.Format("SELECT * FROM [registered_users] WHERE isArchived = 'No' Order By ID DESC");

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
                        unit.LoginName = reader["Unit_Number"].ToString();
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
                        unit.isBanned = reader["isBanned"].ToString();
                        units.Add(unit);
                    }
                }
            }
            return units.ToArray();
        }

        [WebMethod]
        public static GetCivs[] GetAllCharacters()
        {
            List<GetCivs> civs = new List<GetCivs>();
            string query = string.Format("SELECT * FROM [civilians]");

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
                        civ.Owner = reader["Username"].ToString();
                        civs.Add(civ);
                    }
                }
            }
            return civs.ToArray();
        }

        [WebMethod]
        public static GetCivs[] GetCivData(String CivID)
        {
            List<GetCivs> civs = new List<GetCivs>();
            string query = string.Format("SELECT * FROM [civilians] WHERE [ID] = '"+ Encoder.HtmlEncode(CivID) +"'");

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
                        civ.Owner = reader["Username"].ToString();
                        civs.Add(civ);
                    }
                }
            }
            return civs.ToArray();
        }

        [WebMethod]
        public static GetVehs[] GetAllVehicles()
        {
            List<GetVehs> vehs = new List<GetVehs>();
            string query = string.Format("SELECT * FROM [vehicles]");

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
        public static GetUsers[] GetAllUsers()
        {
            List<GetUsers> users = new List<GetUsers>();
            string query = string.Format("SELECT * FROM [registered_civs] WHERE isArchived = 'No' Order By ID DESC");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetUsers user = new GetUsers();
                        user.ID = Convert.ToString(reader.GetInt32(0));
                        user.Name = reader["Name"].ToString();
                        user.Username = reader["Username"].ToString();
                        user.Email = reader["Email"].ToString();
                        user.IP = reader["IP"].ToString();
                        user.isApproved = reader["isApproved"].ToString();
                        user.isBanned = reader["isBanned"].ToString();
                        users.Add(user);
                    }
                }
            }
            return users.ToArray();
        }

        [WebMethod]
        public static GetUsers[] GetUserData(String ID)
        {
            List<GetUsers> users = new List<GetUsers>();
            string query = string.Format("SELECT * FROM [registered_civs] WHERE [ID] = '" + Encoder.HtmlEncode(ID) + "'");

            using (SqlConnection con =
                    new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GetUsers user = new GetUsers();
                        user.ID = Convert.ToString(reader.GetInt32(0));
                        user.Name = reader["Name"].ToString();
                        user.Username = reader["Username"].ToString();
                        user.Email = reader["Email"].ToString();
                        user.IP = reader["IP"].ToString();
                        user.isApproved = reader["isApproved"].ToString();
                        user.isBanned = reader["isBanned"].ToString();
                        users.Add(user);
                    }
                }
            }
            return users.ToArray();
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
        public static string UpdateUnitData(String Name, String ID, String Approved, String Banned, String Dispatcher, String Admin, String Primary, String Division, String SubD, String SubD2, String SubD3, String SubD4)
        {
            string query = "UPDATE [registered_users] SET [Name] = '" + Encoder.HtmlEncode(Name) + "', [isNewUser] = '" + Encoder.HtmlEncode(Approved) + "', [isAdmin] = '" + Encoder.HtmlEncode(Admin) + "', [isDispatcher] = '" + Encoder.HtmlEncode(Dispatcher) + "', [isBanned] = '" + Encoder.HtmlEncode(Banned) + "', [Primary_Identifier] = '" + Encoder.HtmlEncode(Primary) + "', [Division] = '" + Encoder.HtmlEncode(Division) + "', [Sub_Division] = '" + Encoder.HtmlEncode(SubD) + "', [Sub_Division_2] = '" + Encoder.HtmlEncode(SubD2) + "', [Sub_Division_3] = '" + Encoder.HtmlEncode(SubD3) + "', [Sub_Division_4] = '" + Encoder.HtmlEncode(SubD4) + "' WHERE [ID] = '" + Encoder.HtmlEncode(ID) + "'";

            using (SqlConnection con =
                      new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        //
        [WebMethod]
        public static string ResetUnitPassword(String UnitID, String UnitPassword)
        {
            string query = "UPDATE [registered_users] SET [Password] = @newPassword WHERE [ID] = @ID";

            using (SqlConnection con =
                      new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    String newPass = Crypto.strongHash(UnitPassword);
                    cmd.Parameters.AddWithValue("@newPassword", newPass);
                    cmd.Parameters.AddWithValue("@ID", UnitID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        [WebMethod]
        public static string UpdateUserData(String Name, String ID, String Approved, String Banned, String Email)
        {
            string query = "UPDATE [registered_civs] SET [Name] = '" + Encoder.HtmlEncode(Name) + "', [isApproved] = '" + Encoder.HtmlEncode(Approved) + "', [isBanned] = '" + Encoder.HtmlEncode(Banned) + "',  [Email] = '" + Encoder.HtmlEncode(Email) + "' WHERE [ID] = '" + Encoder.HtmlEncode(ID) + "'";

            using (SqlConnection con =
                      new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        //
        [WebMethod]
        public static string ResetUserPassword(String UserID, String UserPassword)
        {
            string query = "UPDATE [registered_civs] SET [Password] = @newPassword WHERE [ID] = @ID";

            using (SqlConnection con =
                      new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    String newPass = CryptoCiv.strongHash(UserPassword);
                    cmd.Parameters.AddWithValue("@newPassword", newPass);
                    cmd.Parameters.AddWithValue("@ID", UserID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        //
        [WebMethod]
        public static string ArchiveUnit(int UserID)
        {
            string query = "UPDATE [registered_users] SET [isArchived] = @isArchived, [isNewUser] = @isNewUser WHERE [ID] = @ID";

            using (SqlConnection con =
                      new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ID", UserID);
                    cmd.Parameters.AddWithValue("@isNewUser", "No");
                    cmd.Parameters.AddWithValue("@isArchived", "Yes");

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        //
        [WebMethod]
        public static string ArchiveUser(int UserID)
        {
            string query = "UPDATE [registered_civs] SET [isArchived] = @isArchived, [isApproved] = @isApproved WHERE [ID] = @ID";

            using (SqlConnection con =
                      new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ID", UserID);
                    cmd.Parameters.AddWithValue("@isApproved", "No");
                    cmd.Parameters.AddWithValue("@isArchived", "Yes");

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    return "success";
                }
            }
        }

        //
        [WebMethod]
        public static string UpdateCivData(String FirstName, String LastName, String FullName, String CivLicense, String CivAddress, String CivLicenseStatus, String CivDOB, String CivGender, String CivHair, String CivEthnicity, String CivWeight, String CivExpiration, String CivState, String CivPortrait, String CivID)
        {
            string query = "UPDATE [civilians] SET [License_Number] = '" + Encoder.HtmlEncode(CivLicense) + "', [Full_Name] = '" + Encoder.HtmlEncode(FullName) + "', [Address] = '" + Encoder.HtmlEncode(CivAddress) + "', [License_Status] = '" + Encoder.HtmlEncode(CivLicenseStatus) + "',  [First_Name] = '" + Encoder.HtmlEncode(FirstName) + "',  [Last_Name] = '" + Encoder.HtmlEncode(LastName) + "',  [DOB] = '" + Encoder.HtmlEncode(CivDOB) + "'" +
                ",  [Gender] = '" + Encoder.HtmlEncode(CivGender) + "',  [Hair] = '" + Encoder.HtmlEncode(CivHair) + "',  [Weight] = '" + Encoder.HtmlEncode(CivWeight) + "',  [Ethnicity] = '" + Encoder.HtmlEncode(CivEthnicity) + "',  [License_Expiration] = '" + Encoder.HtmlEncode(CivExpiration) + "',  [License_State] = '" + Encoder.HtmlEncode(CivState) + "',  [Portrait] = '" + Encoder.HtmlEncode(CivPortrait) + "' WHERE [ID] = '" + Encoder.HtmlEncode(CivID) + "'";

            using (SqlConnection con =
                      new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
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