using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ROIS.Models
{
    public class PostedDetailsTable
    {
        public string ItrNo { get; set; }
        public string ID { get; set; }
        public string ProdCd { get; set; }
        public int Qty { get; set; }
        public string FileNumber { get; set; }
        public string BundleNumber { get; set; }
        public string LastUser { get; set; }
    }
}