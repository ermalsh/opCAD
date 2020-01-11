using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Security.Application;
using SoSACAD.Models;
using System.Web.Http;
using System.Web.UI.WebControls;

namespace SoSACAD.Database_Access_Layer
{
    public class Db
    {
        //Add Warning Procedure
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        WarningData Warning = new WarningData();
        public void Unit_Data(WarningData Warning)
        {
            SqlCommand com = new SqlCommand("Warning_Add", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            com.Parameters.AddWithValue("@Full_Name", Encoder.HtmlEncode(Warning.fullName));
            com.Parameters.AddWithValue("@Date", Encoder.HtmlEncode(Warning.warningDateIssued));
            com.Parameters.AddWithValue("@Ticket_Details", Encoder.HtmlEncode(Warning.warningDetails));
            com.Parameters.AddWithValue("@Ticket_Unit", Encoder.HtmlEncode(Warning.warningOfficer));
            com.Parameters.AddWithValue("@Ticket_Location", Encoder.HtmlEncode(Warning.warningLocation));
            com.Parameters.AddWithValue("@Ticket_Fine", "0");
            com.Parameters.AddWithValue("@Ticket_Jailtime", "0");
            com.Parameters.AddWithValue("@Ticket_Warrant_Active", "No");
            com.Parameters.AddWithValue("@Ticket_Charges", "Warning");
            com.Parameters.AddWithValue("@License_Number", Encoder.HtmlEncode(Warning.licenseNumber));
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
        }

        //Add Ticket Procedure
        TicketData Ticket = new TicketData();
        public void Add_Ticket(TicketData Ticket)
        {
            SqlCommand com = new SqlCommand("Ticket_Add", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            com.Parameters.AddWithValue("@Full_Name", Encoder.HtmlEncode(Ticket.fullName));
            com.Parameters.AddWithValue("@Date", Encoder.HtmlEncode(Ticket.ticketDateIssued));
            com.Parameters.AddWithValue("@Ticket_Details", Encoder.HtmlEncode(Ticket.ticketDetails));
            com.Parameters.AddWithValue("@Ticket_Unit", Encoder.HtmlEncode(Ticket.ticketOfficer));
            com.Parameters.AddWithValue("@Ticket_Location", Encoder.HtmlEncode(Ticket.ticketLocation));
            com.Parameters.AddWithValue("@Ticket_Fine", Encoder.HtmlEncode(Ticket.ticketFines));
            com.Parameters.AddWithValue("@Ticket_Jailtime", "0");
            com.Parameters.AddWithValue("@Ticket_Warrant_Active", "No");
            com.Parameters.AddWithValue("@Ticket_Charges", Encoder.HtmlEncode(Ticket.ticketCharges));
            com.Parameters.AddWithValue("@License_Number", Encoder.HtmlEncode(Ticket.licenseNumber));
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
        }

        //Load Tickets Procedure
        public TicketData[] Load_Tickets([FromBody]TicketData CivTickets)
        {
            SqlCommand com = new SqlCommand("Load_Tickets", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();
            com.Parameters.AddWithValue("@License_Number", Encoder.HtmlEncode(CivTickets.licenseNumber));
            List<TicketData> ticketData = new List<TicketData>();

            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                TicketData ticket = new TicketData
                {
                    ID = Convert.ToString(reader.GetInt32(0)),
                    fullName = reader["Full_Name"].ToString(),
                    ticketDateIssued = reader["Date"].ToString(),
                    ticketDetails = reader["Ticket_Details"].ToString(),
                    ticketOfficer = reader["Ticket_Unit"].ToString(),
                    ticketLocation = reader["Ticket_Location"].ToString(),
                    ticketFines = reader["Ticket_Fine"].ToString(),
                    ticketCharges = reader["Ticket_Charges"].ToString(),
                    licenseNumber = reader["License_Number"].ToString()
                };
                ticketData.Add(ticket);
            }
            con.Close();
            return ticketData.ToArray();
        }

        //Add Arrest Procedure
        ArrestData Arrests = new ArrestData();
        public void Add_Arrest(ArrestData Arrests)
        {
            SqlCommand com = new SqlCommand("Arrest_Add", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            com.Parameters.AddWithValue("@Full_Name", Encoder.HtmlEncode(Arrests.fullName));
            com.Parameters.AddWithValue("@Date", Encoder.HtmlEncode(Arrests.arrestDateIssued));
            com.Parameters.AddWithValue("@Arrest_Details", Encoder.HtmlEncode(Arrests.arrestDetails));
            com.Parameters.AddWithValue("@Arrest_Unit", Encoder.HtmlEncode(Arrests.arrestOfficer));
            com.Parameters.AddWithValue("@Arrest_Location", Encoder.HtmlEncode(Arrests.arrestLocation));
            com.Parameters.AddWithValue("@Arrest_Fine", Encoder.HtmlEncode(Arrests.arrestFines));
            com.Parameters.AddWithValue("@Arrest_Jailtime", Encoder.HtmlEncode(Arrests.arrestJailtime));
            com.Parameters.AddWithValue("@Arrest_Warrant_Active", "No");
            com.Parameters.AddWithValue("@Arrest_Charges", Encoder.HtmlEncode(Arrests.arrestCharges));
            com.Parameters.AddWithValue("@License_Number", Encoder.HtmlEncode(Arrests.licenseNumber));
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
        }

        //Load Arrests Procedure
        public ArrestData[] Load_Arrests([FromBody]ArrestData CivArrests)
        {
            SqlCommand com = new SqlCommand("Load_Arrests", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();
            com.Parameters.AddWithValue("@License_Number", Encoder.HtmlEncode(CivArrests.licenseNumber));
            List<ArrestData> arrestData = new List<ArrestData>();

            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                ArrestData arrest = new ArrestData
                {
                    ID = Convert.ToString(reader.GetInt32(0)),
                    fullName = reader["Full_Name"].ToString(),
                    arrestDateIssued = reader["Date"].ToString(),
                    arrestDetails = reader["Arrest_Details"].ToString(),
                    arrestOfficer = reader["Arrest_Unit"].ToString(),
                    arrestLocation = reader["Arrest_Location"].ToString(),
                    arrestFines = reader["Arrest_Fine"].ToString(),
                    arrestJailtime = reader["Arrest_Jailtime"].ToString(),
                    arrestWarrantActive = reader["Arrest_Warrant_Active"].ToString(),
                    arrestCharges = reader["Arrest_Charges"].ToString(),
                    licenseNumber = reader["License_Number"].ToString()
                };
                arrestData.Add(arrest);
            }
            con.Close();
            return arrestData.ToArray();
        }

        //Add Warrant Procedure
        WarrantData Warrant = new WarrantData();
        public void Add_Warrant(WarrantData Warrant)
        {
            SqlCommand com = new SqlCommand("Warrant_Add", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            com.Parameters.AddWithValue("@Full_Name", Encoder.HtmlEncode(Warrant.fullName));
            com.Parameters.AddWithValue("@Warrant_Issued", Encoder.HtmlEncode(Warrant.warrantDateIssued));
            com.Parameters.AddWithValue("@Warrant_Charges", Encoder.HtmlEncode(Warrant.warrantCharges));
            com.Parameters.AddWithValue("@Warrant_Department", Encoder.HtmlEncode(Warrant.warrantDepartment));
            com.Parameters.AddWithValue("@Warrant_Status", "Active");
            com.Parameters.AddWithValue("@Warrant_Results", "N/A");
            com.Parameters.AddWithValue("@Warrant_Officer", Encoder.HtmlEncode(Warrant.warrantOfficer));
            com.Parameters.AddWithValue("@License_Number", Encoder.HtmlEncode(Warrant.licenseNumber));
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
        }

        //Load Warrants Procedure
        public WarrantData[] Load_Warrants([FromBody]WarrantData CivWarrants)
        {
            SqlCommand com = new SqlCommand("Load_Warrants", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();
            com.Parameters.AddWithValue("@License_Number", Encoder.HtmlEncode(CivWarrants.licenseNumber));
            List<WarrantData> warrantData = new List<WarrantData>();

            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                WarrantData ticket = new WarrantData
                {
                    ID = Convert.ToString(reader.GetInt32(0)),
                    fullName = reader["Full_Name"].ToString(),
                    licenseNumber = reader["License_Number"].ToString(),
                    warrantDateIssued = reader["Warrant_Issued"].ToString(),
                    warrantCharges = reader["Warrant_Charges"].ToString(),
                    warrantDepartment = reader["Warrant_Department"].ToString(),
                    warrantStatus = reader["Warrant_Status"].ToString(),
                    warrantResults = reader["Warrant_Results"].ToString()
                };
                warrantData.Add(ticket);
            }
            con.Close();
            return warrantData.ToArray();
        }

        //Get Unit Data (Unit that is logged in)
        public GetUnits[] Unit_Data([FromBody]GetUnitNumber Unit)
        {
            SqlCommand com = new SqlCommand("Unit_Get", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            com.Parameters.AddWithValue("@UnitNumber", Encoder.HtmlEncode(SessionCrypto.Decrypt(Unit.UnitNumberEncrypted)));
            con.Open();

            List<GetUnits> unitsData = new List<GetUnits>();
            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                GetUnits unit = new GetUnits
                {
                    ID = Convert.ToString(reader.GetInt32(0)),
                    Unit_Number = reader["Primary_Identifier"].ToString(),
                    Name = reader["Name"].ToString(),
                    Division = reader["Division"].ToString(),
                    Sub_Division = reader["Sub_Division"].ToString(),
                    Sub_Division_2 = reader["Sub_Division_2"].ToString(),
                    Sub_Division_3 = reader["Sub_Division_3"].ToString(),
                    Sub_Division_4 = reader["Sub_Division_4"].ToString(),
                    isNewUser = reader["isNewUser"].ToString(),
                    isDispatcher = reader["isDispatcher"].ToString(),
                    isAdmin = reader["isAdmin"].ToString(),
                    Status = reader["Status"].ToString()
                };
                unitsData.Add(unit);
            }
            con.Close();
            return unitsData.ToArray();
        }

        //Get calls that are assigned to logged in unit
        public GetCalls[] Call_Data([FromBody]Calls pID)
        {
            SqlCommand com = new SqlCommand("Calls_Get", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            com.Parameters.AddWithValue("@PrimaryIdentifier", Encoder.HtmlEncode(pID.PrimaryIdentifier));
            con.Open();

            List<GetCalls> calls = new List<GetCalls>();
            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                GetCalls call = new GetCalls
                {
                    ID = Convert.ToString(reader.GetInt32(0)),
                    Caller = reader["Caller"].ToString(),
                    Location = reader["Location"].ToString(),
                    Description = reader["Description"].ToString(),
                    Date_Time = reader["Date_Time"].ToString(),
                    Unit_Responding = reader["Unit_Responding"].ToString(),
                    Status = reader["Status"].ToString(),
                    Notes = reader["Notes"].ToString()
                };
                calls.Add(call);
            }
            con.Close();
            return calls.ToArray();
        }

        //Get calls that are assigned to logged in unit
        public GetCalls[] All_Call_Data()
        {
            SqlCommand com = new SqlCommand("All_Calls_Get", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();
            List<GetCalls> calls = new List<GetCalls>();
            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                GetCalls call = new GetCalls
                {
                    ID = Convert.ToString(reader.GetInt32(0)),
                    Caller = reader["Caller"].ToString(),
                    Location = reader["Location"].ToString(),
                    Description = reader["Description"].ToString(),
                    Date_Time = reader["Date_Time"].ToString(),
                    Unit_Responding = reader["Unit_Responding"].ToString(),
                    Status = reader["Status"].ToString(),
                    Notes = reader["Notes"].ToString()
                };
                calls.Add(call);
            }
            con.Close();
            return calls.ToArray();
        }

        //Get and load all Civilians
        public GetCivs[] Get_Civs()
        {
            SqlCommand com = new SqlCommand("Civs_Get", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();

            List<GetCivs> civs = new List<GetCivs>();
            SqlDataReader reader = com.ExecuteReader();
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
                    License_State = reader["License_State"].ToString(),
                    Portrait = reader["Portrait"].ToString(),
                };
                civs.Add(civ);
            }
            con.Close();
            return civs.ToArray();
        }

        //Get and Search Specific Civilian
        public GetCivs[] Search_Civ([FromBody]GetCivs Civilian)
        {
            SqlCommand com = new SqlCommand("SearchCiv_Get", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();
            com.Parameters.AddWithValue("@Full_Name", Encoder.HtmlEncode(Civilian.Full_Name));

            List<GetCivs> civs = new List<GetCivs>();
            SqlDataReader reader = com.ExecuteReader();
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
                    License_State = reader["License_State"].ToString(),
                    Portrait = reader["Portrait"].ToString(),
                };
                civs.Add(civ);
            }
            con.Close();
            return civs.ToArray();
        }

        //Get and Load all Vehicles
        public GetVehs[] Get_Veh()
        {
            SqlCommand com = new SqlCommand("Vehs_Get", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            con.Open();

            List<GetVehs> vehs = new List<GetVehs>();
            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                GetVehs veh = new GetVehs
                {
                    ID = Convert.ToString(reader.GetInt32(0)),
                    Model = reader["Model"].ToString(),
                    Color = reader["Color"].ToString(),
                    License_Number = reader["License_Number"].ToString(),
                    Owner = reader["Owner"].ToString(),
                    Registration_Valid = reader["Registration_Valid"].ToString(),
                    Insurance_Valid = reader["Insurance_Valid"].ToString(),
                    Username = reader["Username"].ToString(),
                    Make = reader["Make"].ToString(),
                    Stolen = reader["Stolen"].ToString()
                };
                vehs.Add(veh);
            }
            con.Close();
            return vehs.ToArray();
        }

        //Get and Look Up specific Vehicle
        public GetVehs[] Lookup_Veh([FromBody]VehicleLookup Vehicle)
        {
            SqlCommand com = new SqlCommand("SearchVeh_Get", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            com.Parameters.AddWithValue("@License_Number", Encoder.HtmlEncode(Vehicle.License_Number));
            con.Open();

            List<GetVehs> vehs = new List<GetVehs>();
            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                GetVehs veh = new GetVehs
                {
                    ID = Convert.ToString(reader.GetInt32(0)),
                    Model = reader["Model"].ToString(),
                    Color = reader["Color"].ToString(),
                    License_Number = reader["License_Number"].ToString(),
                    Owner = reader["Owner"].ToString(),
                    Registration_Valid = reader["Registration_Valid"].ToString(),
                    Insurance_Valid = reader["Insurance_Valid"].ToString(),
                    Username = reader["Username"].ToString(),
                    Make = reader["Make"].ToString(),
                    Stolen = reader["Stolen"].ToString()
                };
                vehs.Add(veh);
            }
            con.Close();
            return vehs.ToArray();
        }

        //Update Identifier for Logged in User
        IdentifierSetting Identifier = new IdentifierSetting();
        public void Update_ID(IdentifierSetting Identifier)
        {
            SqlCommand com = new SqlCommand("Update_ID", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            com.Parameters.AddWithValue("@Unit_Number", Encoder.HtmlEncode(SessionCrypto.Decrypt(Identifier.UnitNumberEncrypted)));
            com.Parameters.AddWithValue("@PrimaryIdentifier", Encoder.HtmlEncode(Identifier.SelectedIdentifier));
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
        }

        //Register LEO for Admins
        Registration.LEO LEORegInfo = new Registration.LEO();
        public string Label1 { get; private set; }
        public string RegisterLEO(Registration.LEO LEORegInfo)
        {
            String username = LEORegInfo.unitID;
            String password = LEORegInfo.unitPW;
            String name = LEORegInfo.unitName;
            String email = LEORegInfo.unitEmail;
            String primaryNumber = LEORegInfo.unitNumber;
            String division = LEORegInfo.unitDivision;
            String division2 = LEORegInfo.unitDivision2;
            String division3 = LEORegInfo.unitDivision3;
            String division4 = LEORegInfo.unitDivision4;
            String division5 = LEORegInfo.unitDivision5;
            String pass = Crypto.encryption(password);

            if (username.Length > 0 && password.Length > 0)
            {
                String connection = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                SqlConnection con = new SqlConnection(connection);

                String passwords = Crypto.strongHash(password);
                con.Open();
                String search = "SELECT * FROM [registered_users] WHERE ([Unit_Number] = @unitID OR [Primary_Identifier] = @unitPrimaryNumber OR [Email_Address] = @unitEmail);";

                SqlCommand cmds = new SqlCommand(search, con);
                cmds.Parameters.AddWithValue("@unitID", username);
                cmds.Parameters.AddWithValue("@unitPrimaryNumber", primaryNumber);
                cmds.Parameters.AddWithValue("@unitEmail", email);
                SqlDataReader sqldrs = cmds.ExecuteReader();

                if (sqldrs.Read())
                {
                    String passed = (String)sqldrs["Password"];
                    Label1 = "This Unit ID is already in use";

                }
                else
                {
                    try
                    {
                        sqldrs.Close();
                        String sql = "INSERT INTO [registered_users] ([Unit_Number], [Password], [Name], [Primary_Identifier], [Division], [Sub_Division], [Sub_Division_2], [Sub_Division_3], [Sub_Division_4], [isNewUser]," +
                            "[isDispatcher], [isAdmin], [Status], [Email_Address]) VALUES (@unitID, @password, @unitName, @unitPrimaryNumber, @division, @division2, @division3, @division4,  @division5, @isNewUser, @isDispatcher," +
                            "@isAdmin, @status, @unitEmail);";
                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@unitID", username);
                        cmd.Parameters.AddWithValue("@unitName", name);
                        cmd.Parameters.AddWithValue("@password", passwords);
                        cmd.Parameters.AddWithValue("@unitEmail", email);
                        cmd.Parameters.AddWithValue("@unitPrimaryNumber", primaryNumber);
                        cmd.Parameters.AddWithValue("@division", primaryNumber);
                        cmd.Parameters.AddWithValue("@division2", division2);
                        cmd.Parameters.AddWithValue("@division3", division3);
                        cmd.Parameters.AddWithValue("@division4", division4);
                        cmd.Parameters.AddWithValue("@division5", division5);
                        cmd.Parameters.AddWithValue("@isAdmin", "No");
                        cmd.Parameters.AddWithValue("@isDispatcher", "No");
                        cmd.Parameters.AddWithValue("@isNewUser", "No");
                        cmd.Parameters.AddWithValue("@status", "10-42");

                        cmd.ExecuteNonQuery();
                        String Message = "Success";
                        Label1 = Message.ToString();
                    }
                    catch (Exception ex)
                    {
                        Label1 = ex.ToString();
                    }
                    con.Close();
                }
            }

            else
            {
                String Message = "Username or Password is empty";
                Label1 = Message.ToString();
            }
            return Label1.ToString();
        }

        ////////*BEGIN LEADERBOARDS*////////
        public Leaderboards[] Get_Score([FromBody]int Modifier)
        {
            switch (Modifier)
            {
                case 1:
                    return RetrieveScore("Get_Score_Arrests");
                case 2:
                    return RetrieveScore("Get_Score_Tickets");
                case 3:
                    return RetrieveScore("Get_Score_Warrants");
                case 4:
                    return RetrieveScore("Get_Score_Calls");
                default:
                    return null;
            }
        }

        public Leaderboards[] RetrieveScore(String Modifier)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            SqlCommand com = new SqlCommand(Modifier, con);
            con.Open();
            List<Leaderboards> ScoreData = new List<Leaderboards>();
            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {
                Leaderboards scores = new Leaderboards
                {
                    Unit = reader[0].ToString(),
                    Points = Int32.Parse(reader["Points"].ToString())
                };
                ScoreData.Add(scores);
            }
            con.Close();
            return ScoreData.ToArray();
            ////////*END LEADERBOARDS*/////////
        }
    }
}
