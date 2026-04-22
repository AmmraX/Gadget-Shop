using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHubSolution.Models
{
    public class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
        public string Category { get; set; }
    }
}