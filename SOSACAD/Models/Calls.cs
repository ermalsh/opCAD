using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoSACAD.Models
{
    public class Calls
    {
        public string PrimaryIdentifier { get; set; }
    }

    public class GetCalls
    {
        public string ID { get; set; }
        public string Caller { get; set; }
        public string Location { get; set; }
        public string Description { get; set; }
        public string Date_Time { get; set; }
        public string Unit_Responding { get; set; }
        public string Status { get; set; }
        public string Notes { get; set; }
    }
}