using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ROIS.Models
{
    public class ScanListModel
    {
        public string barcode { get; set; }
        public string location { get; set; }
        public string reason { get; set; }
        public string ipAddress { get; set; }
    }
}