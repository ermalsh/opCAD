using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoSACAD.Models
{
    public class Vehicles
    {

    }

    public class VehicleLookup
    {
        public string License_Number { get; set; }
    }

    public class GetVehs
    {
        public string ID { get; set; }
        public string Model { get; set; }
        public string Color { get; set; }
        public string License_Number { get; set; }
        public string Owner { get; set; }
        public string Registration_Valid { get; set; }
        public string Insurance_Valid { get; set; }
        public string Username { get; set; }
        public string Make { get; set; }
        public string Stolen { get; set; }
    }
}