using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GadgetHubSolution.Models
{
    public class DistributorUser
    {
        [Key]
        public int UserId { get; set; }
        public int DistributorId { get; set; }
        public string Username { get; set; }
        public string PasswordHash { get; set; }

        public virtual Distributor Distributor { get; set; }
    }

}