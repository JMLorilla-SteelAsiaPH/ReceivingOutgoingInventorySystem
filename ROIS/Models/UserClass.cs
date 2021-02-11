using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ROIS.Models
{
    public class UserClass
    {
        public int userId { get; set; }
        public string username { get; set; }
        public string userPass { get; set; }
        public string fullName { get; set; }
        public string userLocation { get; set; }
    }
}