using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using GadgetHubSolution.Models;

namespace GadgetHubSolution.Controllers
{
    [RoutePrefix("api/quotation")]
    public class QuotationController : ApiController
    {
        private readonly GadgetHubContext db = new GadgetHubContext();

   
        [HttpPost]
        [Route("submit-order")]
        public IHttpActionResult SubmitOrder(List<OrderRequest> orderRequests)
        {
            if (orderRequests == null || !orderRequests.Any())
                return BadRequest("No order data received.");

            try
            {
                foreach (var request in orderRequests)
                {
                    var newOrder = new Order
                    {
                        ProductId = request.ProductId,
                        Quantity = request.Quantity,
                        Status = "Awaiting Approval",
                        CreatedAt = DateTime.Now,
                        UserId = request.UserId 
                    };

                    db.Orders.Add(newOrder);
                }

                db.SaveChanges();
                return Ok("Order(s) submitted and waiting for distributor quotations.");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        
        [HttpGet]
        [Route("pending-orders")]
        public IHttpActionResult GetPendingOrders()
        {
            try
            {
                var orders = db.Orders
                    .Where(o => o.Status == "Awaiting Approval")
                    .Select(o => new
                    {
                        o.OrderId,
                        o.ProductId,
                        ProductName = o.Product.Name,
                        o.Quantity,
                        o.Status,
                        o.CreatedAt,
                        QuotationCount = db.DistributorQuotations.Count(q => q.OrderId == o.OrderId)
                    })
                    .ToList();

                return Ok(orders);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

     
        [HttpPost]
        [Route("submit-quotation")]
        public IHttpActionResult SubmitQuotation(DistributorQuotation quote)
        {
            if (quote == null)
                return BadRequest("Invalid quotation data.");

            var order = db.Orders.Find(quote.OrderId);
            if (order == null)
                return BadRequest("Order not found.");

            if (order.Status != "Awaiting Approval")
                return BadRequest("Order is not accepting quotations.");

            bool alreadyQuoted = db.DistributorQuotations.Any(q => q.OrderId == quote.OrderId && q.DistributorName == quote.DistributorName);
            if (alreadyQuoted)
                return BadRequest("You have already submitted a quotation for this order.");

            int distinctQuoteCount = db.DistributorQuotations
                .Where(q => q.OrderId == quote.OrderId)
                .Select(q => q.DistributorName)
                .Distinct()
                .Count();
            if (distinctQuoteCount >= 3)
                return BadRequest("Maximum number of quotations reached for this order.");

            try
            {
                quote.SubmittedAt = DateTime.Now;
                db.DistributorQuotations.Add(quote);
                db.SaveChanges();

    
                distinctQuoteCount = db.DistributorQuotations
                    .Where(q => q.OrderId == quote.OrderId)
                    .Select(q => q.DistributorName)
                    .Distinct()
                    .Count();

                if (distinctQuoteCount >= 3)
                {
                    PlaceOrderInternal(quote.OrderId);
                }

                return Ok("Quotation submitted successfully.");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        [HttpPost]
        [Route("place-order")]
        public IHttpActionResult PlaceOrder(int orderId)
        {
            try
            {
                var result = PlaceOrderInternal(orderId);
                if (result == null)
                    return BadRequest("Order not found or no valid quotations.");

                return Ok(result);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }


        private object PlaceOrderInternal(int orderId)
        {
            var quotes = db.DistributorQuotations.Where(q => q.OrderId == orderId).ToList();
            if (quotes == null || quotes.Count == 0)
                return null;

            var bestQuote = quotes.OrderBy(q => q.PricePerUnit).FirstOrDefault();
            if (bestQuote == null)
                return null;

            var order = db.Orders.Find(orderId);
            if (order == null)
                return null;

            order.Status = "Placed";
            order.DistributorName = bestQuote.DistributorName;
            order.ConfirmedPrice = bestQuote.PricePerUnit;
            order.ConfirmedDeliveryDays = bestQuote.DeliveryDays;

            db.SaveChanges();

            return new
            {
                Message = "Order placed successfully.",
                OrderId = order.OrderId,
                Distributor = bestQuote.DistributorName,
                Price = bestQuote.PricePerUnit,
                DeliveryDays = bestQuote.DeliveryDays
            };
        }

    
        [HttpGet]
        [Route("placed-orders/{userId}")]
        public IHttpActionResult GetPlacedOrders(int userId)
        {
            try
            {
                var placedOrders = db.Orders
                    .Where(o => o.UserId == userId && o.Status == "Placed")
                    .Select(o => new
                    {
                        o.OrderId,
                        ProductName = o.Product.Name,
                        o.Quantity,
                        o.DistributorName,
                        o.ConfirmedPrice,
                        o.ConfirmedDeliveryDays,
                        o.CreatedAt
                    })
                    .ToList();

                return Ok(placedOrders);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }


        [HttpGet]
        [Route("placed-orders-by-distributor/{distributorName}")]
        public IHttpActionResult GetPlacedOrdersByDistributor(string distributorName)
        {
            try
            {
                var placedOrders = db.Orders
                    .Where(o => o.DistributorName == distributorName && o.Status == "Placed")
                    .Select(o => new
                    {
                        o.OrderId,
                        ProductName = o.Product.Name,
                        o.Quantity,
                        o.DistributorName,
                        o.ConfirmedPrice,
                        o.ConfirmedDeliveryDays,
                        o.CreatedAt
                    })
                    .ToList();

                return Ok(placedOrders);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
    }
}
