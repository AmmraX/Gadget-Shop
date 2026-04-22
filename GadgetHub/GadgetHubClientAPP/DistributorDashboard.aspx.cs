using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.UI;
using GadgetHubSolution.Models;
using Newtonsoft.Json;

namespace GadgetHubClientAPP
{
    public partial class DistributorDashboard : Page
    {
        private List<DistributorOrderViewModel> OrdersCache
        {
            get => Session["OrdersCache"] as List<DistributorOrderViewModel>;
            set => Session["OrdersCache"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["DistributorName"] == null)
            {
                Response.Redirect("DistributorLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string distributorName = Session["DistributorName"].ToString();
                lblDistributorName.Text = distributorName;

                LoadPendingOrders();
                LoadPlacedOrders(distributorName);
            }
        }

        private void LoadPendingOrders()
        {
            lblMessage.Text = "";

            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://localhost:44369/");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response = client.GetAsync("api/quotation/pending-orders").Result;

                if (response.IsSuccessStatusCode)
                {
                    var data = response.Content.ReadAsStringAsync().Result;
                    var orders = JsonConvert.DeserializeObject<List<DistributorOrderViewModel>>(data);

                    OrdersCache = orders;

                    rptOrders.DataSource = orders;
                    rptOrders.DataBind();
                }
                else
                {
                    lblMessage.Text = "❌ Failed to load pending orders.";
                    lblMessage.CssClass = "message error";
                }
            }
        }

        private void LoadPlacedOrders(string distributorName)
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://localhost:44369/");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                HttpResponseMessage response = client.GetAsync($"api/quotation/placed-orders-by-distributor/{distributorName}").Result;

                if (response.IsSuccessStatusCode)
                {
                    var data = response.Content.ReadAsStringAsync().Result;
                    var placedOrders = JsonConvert.DeserializeObject<List<PlacedOrderViewModel>>(data);

                    rptPlacedOrders.DataSource = placedOrders;
                    rptPlacedOrders.DataBind();
                }
                else
                {
                    rptPlacedOrders.DataSource = null;
                    rptPlacedOrders.DataBind();
                }
            }
        }

        protected void btnSubmitQuotation_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (Session["DistributorName"] == null)
            {
                lblMessage.Text = "⚠️ You must log in first.";
                lblMessage.CssClass = "message warning";
                Response.Redirect("DistributorLogin.aspx");
                return;
            }

            string distributorName = Session["DistributorName"].ToString();

            var btn = sender as System.Web.UI.WebControls.Button;
            var item = btn.NamingContainer as System.Web.UI.WebControls.RepeaterItem;

            var txtPrice = item.FindControl("txtPrice") as System.Web.UI.WebControls.TextBox;
            var txtDays = item.FindControl("txtDays") as System.Web.UI.WebControls.TextBox;

            if (!decimal.TryParse(txtPrice.Text, out decimal price))
            {
                lblMessage.Text = "⚠️ Invalid price entered.";
                lblMessage.CssClass = "message warning";
                return;
            }

            if (!int.TryParse(txtDays.Text, out int days))
            {
                lblMessage.Text = "⚠️ Invalid delivery days entered.";
                lblMessage.CssClass = "message warning";
                return;
            }

            int orderId = int.Parse(btn.CommandArgument);

            var quotation = new DistributorQuotation
            {
                OrderId = orderId,
                DistributorName = distributorName,
                PricePerUnit = price,
                DeliveryDays = days
            };

            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = new Uri("https://localhost:44369/");
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    var json = JsonConvert.SerializeObject(quotation);
                    var content = new StringContent(json);
                    content.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                    HttpResponseMessage response = client.PostAsync("api/quotation/submit-quotation", content).Result;

                    if (response.IsSuccessStatusCode)
                    {
                        string script = "alert('✅ Quotation submitted successfully!');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "QuotationSuccess", script, true);

                        RemoveOrderFromCache(orderId);

                        lblMessage.Text = "";
                    }
                    else
                    {
                        var errorMsg = response.Content.ReadAsStringAsync().Result;
                        lblMessage.Text = $"❌ Failed to submit quotation. Server says: {errorMsg}";
                        lblMessage.CssClass = "message error";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"❌ Exception: {ex.Message}";
                lblMessage.CssClass = "message error";
            }
        }

        private void RemoveOrderFromCache(int orderId)
        {
            if (OrdersCache == null)
                return;

            OrdersCache.RemoveAll(o => o.OrderId == orderId);

            rptOrders.DataSource = OrdersCache;
            rptOrders.DataBind();
        }

        public class DistributorOrderViewModel
        {
            public int OrderId { get; set; }
            public string ProductName { get; set; }
            public int Quantity { get; set; }
            public string Status { get; set; }
            public int QuotationCount { get; set; }
            public DateTime CreatedAt { get; set; }
        }

        public class PlacedOrderViewModel
        {
            public int OrderId { get; set; }
            public string ProductName { get; set; }
            public int Quantity { get; set; }
            public decimal ConfirmedPrice { get; set; }
            public int ConfirmedDeliveryDays { get; set; }
            public DateTime CreatedAt { get; set; }
        }
    }
}
