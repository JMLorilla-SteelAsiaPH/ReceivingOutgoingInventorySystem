using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ROIS.Models
{
    public class ITRLTPostedSubdetails
    {
        public string barcodetag { get; set; }
        public string prodcode { get; set; }
        public string locationcode { get; set; }
        public string filenumber { get; set; }
        public string bundlenumber { get; set; }
        public int quantity { get; set; }
    }
}