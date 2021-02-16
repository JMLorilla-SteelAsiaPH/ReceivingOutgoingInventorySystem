using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ROIS.Models
{
    public class InventorySummaryDt
    {
        public string prod_code { get; set; }
        public string location { get; set; }
        public int quantity { get; set; }
        public string weight { get; set; }
    }
}