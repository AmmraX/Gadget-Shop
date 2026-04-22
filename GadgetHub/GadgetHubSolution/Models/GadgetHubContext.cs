using System.Collections.Generic;
using System.Data.Entity;

namespace GadgetHubSolution.Models
{
    public class GadgetHubContext : DbContext
    {
        public GadgetHubContext() : base("name=GadgetHubDB") { }

        public DbSet<Product> Products { get; set; }
        public DbSet<Distributor> Distributors { get; set; }
        public DbSet<DistributorUser> DistributorUsers { get; set; }
        public DbSet<Quotation> Quotations { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }
        

        
        public DbSet<DistributorQuotation> DistributorQuotations { get; set; }
    }
}