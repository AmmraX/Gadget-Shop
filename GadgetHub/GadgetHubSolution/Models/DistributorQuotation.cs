using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHubSolution.Models
{
    public class DistributorQuotation
    {
        public int Id { get; set; }
        public int OrderId { get; set; }
        public string DistributorName { get; set; }
        public decimal PricePerUnit { get; set; }
        public int DeliveryDays { get; set; }
        public DateTime SubmittedAt { get; set; }
        

    }

}