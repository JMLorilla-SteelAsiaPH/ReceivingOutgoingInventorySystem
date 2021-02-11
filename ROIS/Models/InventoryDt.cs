using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ROIS.Models
{
    public class InventoryDt
    {
        public string RefNo { get; set; }
        public string ProdCode { get; set; }
        public int LocationId { get; set; }
        public string FileNo { get; set; }
        public string BundleNo { get; set; }
        public float Qty { get; set; }
        public float TotalWeight { get; set; }
    }
}