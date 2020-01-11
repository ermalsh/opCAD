using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoSACAD.Models
{
    public class Units
    {

    }

    public class GetUnitNumber
    {
        public string UnitNumberEncrypted { get; set; }
    }

    public class IdentifierSetting
    {
        public string UnitNumberEncrypted { get; set; }
        public string SelectedIdentifier { get; set; }
    }

    public class GetUnits
    {
        public string ID { get; set; }
        public string Unit_Number { get; set; }
        public string Name { get; set; }
        public string Division { get; set; }
        public string Sub_Division { get; set; }
        public string Sub_Division_2 { get; set; }
        public string Sub_Division_3 { get; set; }
        public string Sub_Division_4 { get; set; }
        public string Sub_Division_5 { get; set; }
        public string isNewUser { get; set; }
        public string isDispatcher { get; set; }
        public string isAdmin { get; set; }
        public string Status { get; set; }
        public string UnitIcon { get; set; }
        public string LoginName { get; set; }
        public string isBanned { get; set; }
        public string isArchived { get; set; }
        public string ipAddress { get; set; }

    }
}