using GadgetHubSolution.Models;
using System;

public class Order
{
    public int OrderId { get; set; }
    public int ProductId { get; set; }
    public int Quantity { get; set; }
    public string Status { get; set; }  
    public DateTime CreatedAt { get; set; }

    public int QuotationCount { get; set; }  

    public string DistributorName { get; set; }
    public decimal? ConfirmedPrice { get; set; }
    public int? ConfirmedDeliveryDays { get; set; }

    public virtual Product Product { get; set; }
    public int UserId { get; internal set; }
}
