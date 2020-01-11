using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoSACAD
{
    public class GetUsers
    {
        public string ID { get; set; }
        public string Name { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string IP { get; set; }
        public string isApproved { get; set; }
        public string isBanned { get; set; }
        public string isArchived { get; set; }
    }
}