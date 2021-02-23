using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ROIS.Models
{
    public class DrPostedDetails
    {
        public string DrNo { get; set; }
        public string ProdCode { get; set; }
        public int Qty { get; set; }
        public string FileNumber { get; set; }
        public string BarcodeNum { get; set; }
    }
}