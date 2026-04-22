using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHubSolution.Models
{
    public class Quotation
    {
        public int QuotationId { get; set; }
        public int ProductId { get; set; }
        public int DistributorId { get; set; }
        public decimal PricePerUnit { get; set; }
        public int StockAvailable { get; set; }
        public int DeliveryDays { get; set; }
        public DateTime CreatedDate { get; set; }

        public virtual Product Product { get; set; }
        public virtual Distributor Distributor { get; set; }
    }

}