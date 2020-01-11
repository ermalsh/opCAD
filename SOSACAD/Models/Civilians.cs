using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoSACAD.Models
{
    public class Civilians
    {
        
    }

    public class GetCivs
    {
        public string ID { get; set; }
        public string Full_Name { get; set; }
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
        public string License_Number { get; set; }
        public string Address { get; set; }
        public string License_Status { get; set; }
        public string Active_Warrant { get; set; }
        public string DOB { get; set; }
        public string Gender { get; set; }
        public string Hair { get; set; }
        public string Ethnicity { get; set; }
        public string Weight { get; set; }
        public string License_Expiration { get; set; }
        public string License_State { get; set; }
        public string Username { get; set; }
        public string Portrait { get; set; }
        public string Owner { get; set; }
    }

    public class GetArrests
    {
        public string ID { get; set; }
        public string Full_Name { get; set; }
        public string Date { get; set; }
        public string Arrest_Details { get; set; }
        public string Arrest_Unit { get; set; }
        public string Arrest_Location { get; set; }
        public string Arrest_Fine { get; set; }
        public string Arrest_Jailtime { get; set; }
        public string Arrest_Warrant_Active { get; set; }
        public string Arrest_Charges { get; set; }
        public string License_Number { get; set; }
    }

    public class GetTickets
    {
        public string ID { get; set; }
        public string Full_Name { get; set; }
        public string Date { get; set; }
        public string Ticket_Details { get; set; }
        public string Ticket_Unit { get; set; }
        public string Ticket_Location { get; set; }
        public string Ticket_Fine { get; set; }
        public string Ticket_Jailtime { get; set; }
        public string Ticket_Warrant_Active { get; set; }
        public string Ticket_Charges { get; set; }
        public string License_Number { get; set; }
    }

    public class GetFirearms
    {
        public string Type { get; set; }
        public string Name { get; set; }
        public string Date { get; set; }
        public string DateExp { get; set; }
        public string Registrant { get; set; }
        public string Dept { get; set; }
        public string LicenseNumber { get; set; }
    }

    public class GetWarrants
    {
        public string ID { get; set; }
        public string Full_Name { get; set; }
        public string License_Number { get; set; }
        public string Warrant_Issued { get; set; }
        public string Warrant_Charges { get; set; }
        public string Warrant_Department { get; set; }
        public string Warrant_Status { get; set; }
        public string Warrant_Results { get; set; }
        public string Warrant_Officer { get; set; }
    }


    public class WarningData
    {
        public string fullName { get; set; }
        public string licenseNumber { get; set; }
        public string licenseState { get; set; }
        public string warningDateIssued { get; set; }
        public string warningLocation { get; set; }
        public string warningOfficer { get; set; }
        public string warningDetails { get; set; }
    }

    public class TicketData
    {
        public string ID { get; set; }
        public string fullName { get; set; }
        public string licenseNumber { get; set; }
        public string licenseState { get; set; }
        public string ticketDateIssued { get; set; }
        public string ticketLocation { get; set; }
        public string ticketOfficer { get; set; }
        public string ticketDetails { get; set; }
        public string ticketCharges { get; set; }
        public string ticketFines { get; set; }
    }

    public class ArrestData
    {
        public string ID { get; set; }
        public string fullName { get; set; }
        public string licenseNumber { get; set; }
        public string licenseState { get; set; }
        public string arrestDateIssued { get; set; }
        public string arrestLocation { get; set; }
        public string arrestOfficer { get; set; }
        public string arrestDetails { get; set; }
        public string arrestCharges { get; set; }
        public string arrestWarrantActive { get; set; }
        public string arrestFines { get; set; }
        public string arrestJailtime { get; set; }
    }

    public class WarrantData
    {
        public string ID { get; set; }
        public string fullName { get; set; }
        public string licenseNumber { get; set; }
        public string licenseState { get; set; }
        public string warrantDateIssued { get; set; }
        public string warrantDepartment { get; set; }
        public string warrantOfficer { get; set; }
        public string warrantCharges { get; set; }
        public string warrantStatus { get; set; }
        public string warrantResults { get; set; }
    }
}