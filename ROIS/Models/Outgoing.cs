using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ROIS.Models
{
    public class Outgoing
    {
        public string barcodetag { get; set; }
        public string referenceno { get; set; }
        public string prodcode { get; set; }
        public int locationid { get; set; }
        public string filenumber { get; set; }
        public string bundlenumber { get; set; }
        public double quantity { get; set; }
    }
}