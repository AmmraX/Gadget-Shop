using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHubSolution.Models
{
    public class OrderRequest
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public int UserId { get; set; }  
    }
}