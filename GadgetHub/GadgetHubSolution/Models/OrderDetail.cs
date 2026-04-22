using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHubSolution.Models
{
    public class OrderDetail
    {
        public int OrderDetailId { get; set; }
        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public int? SelectedDistributorId { get; set; }

        
        public virtual Product Product { get; set; }
        public virtual Distributor SelectedDistributor { get; set; }
    }

}