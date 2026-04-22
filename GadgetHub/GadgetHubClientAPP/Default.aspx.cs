using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.UI;
using GadgetHubSolution.Models;
using Newtonsoft.Json;

namespace GadgetHubClientAPP
{
    public partial class _Default : Page
    {
        private int CurrentUserId => 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAvailableProducts();
                LoadPlacedOrders(CurrentUserId);
                BindCart();
            }
        }

        #region CartItem Model
        public class CartItem
        {
            public int ProductId { get; set; }
            public string ProductName { get; set; }
            public int Quantity { get; set; }
        }

        private List<CartItem> Cart
        {
            get
            {
                if (Session["Cart"] == null)
                    Session["Cart"] = new List<CartItem>();
                return (List<CartItem>)Session["Cart"];
            }
            set
            {
                Session["Cart"] = value;
            }
        }
        #endregion

        #region API Calls

        private void LoadAvailableProducts()
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://localhost:44369/");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response = client.GetAsync("api/products/all").Result;

                if (response.IsSuccessStatusCode)
                {
                    var data = response.Content.ReadAsStringAsync().Result;
                    var products = JsonConvert.DeserializeObject<List<Product>>(data);
                    rptProducts.DataSource = products;
                    rptProducts.DataBind();
                }
            }
        }

        private void LoadPlacedOrders(int userId)
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://localhost:44369/");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response = client.GetAsync($"api/quotation/placed-orders/{userId}").Result;

                if (response.IsSuccessStatusCode)
                {
                    var data = response.Content.ReadAsStringAsync().Result;
                    var placedOrders = JsonConvert.DeserializeObject<List<PlacedOrderViewModel>>(data);
                    rptPlacedOrders.DataSource = placedOrders;
                    rptPlacedOrders.DataBind();
                }
            }
        }

        #endregion

        #region Cart Operations

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            var btn = (System.Web.UI.WebControls.Button)sender;
            var item = (System.Web.UI.WebControls.RepeaterItem)btn.NamingContainer;

            int productId = Convert.ToInt32(btn.CommandArgument);
            string productName = ((System.Web.UI.WebControls.Literal)item.FindControl("litProductName")).Text;
            int qty = int.Parse(((System.Web.UI.WebControls.TextBox)item.FindControl("txtQty")).Text);

            var existing = Cart.FirstOrDefault(c => c.ProductId == productId);
            if (existing != null)
                existing.Quantity += qty;
            else
                Cart.Add(new CartItem { ProductId = productId, ProductName = productName, Quantity = qty });

            BindCart();
        }

        private void BindCart()
        {
            rptCart.DataSource = Cart;
            rptCart.DataBind();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Cart.Count == 0)
            {
                lblResult.Text = "❌ Cart is empty!";
                return;
            }

            var orderList = Cart.Select(item => new OrderRequest
            {
                ProductId = item.ProductId,
                Quantity = item.Quantity,
                UserId = CurrentUserId
            }).ToList();

            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://localhost:44369/");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var content = new StringContent(JsonConvert.SerializeObject(orderList));
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                HttpResponseMessage response = client.PostAsync("api/quotation/submit-order", content).Result;

                if (response.IsSuccessStatusCode)
                {
                    Cart.Clear();
                    BindCart();
                    LoadPlacedOrders(CurrentUserId);
                    lblResult.Text = "✅ All cart items submitted successfully!";

                    // ✅ Show JavaScript alert
                    ScriptManager.RegisterStartupScript(this, GetType(), "CheckoutSuccess",
                        "alert('✅ All cart items submitted successfully!');", true);
                }
                else
                {
                    string error = response.Content.ReadAsStringAsync().Result;
                    lblResult.Text = $"❌ Checkout failed. Server says: {error}";
                }
            }
        }

        #endregion

        #region Optional: Single Order Button (Not used in UI currently)

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            var btn = (System.Web.UI.WebControls.Button)sender;
            var item = (System.Web.UI.WebControls.RepeaterItem)btn.NamingContainer;

            int productId = Convert.ToInt32(btn.CommandArgument);
            int qty = int.Parse(((System.Web.UI.WebControls.TextBox)item.FindControl("txtQty")).Text);

            var orderList = new List<OrderRequest>
            {
                new OrderRequest { ProductId = productId, Quantity = qty, UserId = CurrentUserId }
            };

            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://localhost:44369/");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var content = new StringContent(JsonConvert.SerializeObject(orderList));
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                HttpResponseMessage response = client.PostAsync("api/quotation/submit-order", content).Result;

                if (response.IsSuccessStatusCode)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "OrderSuccess",
                        "alert('✅ Order placed successfully and awaiting approval.');", true);
                    lblResult.Text = "✅ Your order has been submitted for approval.";
                    LoadPlacedOrders(CurrentUserId);
                }
                else
                {
                    string error = response.Content.ReadAsStringAsync().Result;
                    lblResult.Text = $"❌ Failed to place order. Server says: {error}";
                }
            }
        }

        #endregion

        public class PlacedOrderViewModel
        {
            public int OrderId { get; set; }
            public string ProductName { get; set; }
            public int Quantity { get; set; }
            public string DistributorName { get; set; }
            public decimal? ConfirmedPrice { get; set; }
            public int? ConfirmedDeliveryDays { get; set; }
            public DateTime CreatedAt { get; set; }

            public DateTime? EstimatedDeliveryDate =>
                ConfirmedDeliveryDays.HasValue ? CreatedAt.AddDays(ConfirmedDeliveryDays.Value) : (DateTime?)null;
        }
    }
}
