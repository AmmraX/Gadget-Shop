using System;
using System.Linq;
using System.Web.UI.WebControls;
using GadgetHubSolution.Models;

namespace GadgetHubClientAPP
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            try
            {
                using (var db = new GadgetHubContext())
                {
                    var orders = db.Orders
                        .Select(o => new
                        {
                            o.OrderId,
                            ProductName = o.Product.Name,
                            o.Quantity,
                            o.DistributorName,
                            o.ConfirmedPrice,
                            o.ConfirmedDeliveryDays,
                            o.Status,
                            o.CreatedAt
                        }).ToList();

                    gvOrders.DataSource = orders;
                    gvOrders.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error loading orders: " + ex.Message;
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeleteOrder")
            {
                DeleteOrder(orderId);
            }
            else if (e.CommandName == "ViewQuotes")
            {
                ShowDistributorQuotations(orderId);
            }
        }

        private void DeleteOrder(int orderId)
        {
            try
            {
                using (var db = new GadgetHubContext())
                {
                    var order = db.Orders.Find(orderId);
                    if (order != null)
                    {
                        // Delete related DistributorQuotations
                        var relatedQuotes = db.DistributorQuotations.Where(q => q.OrderId == orderId).ToList();
                        db.DistributorQuotations.RemoveRange(relatedQuotes);

                        db.Orders.Remove(order);
                        db.SaveChanges();

                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Text = $"Order {orderId} canceled successfully.";
                    }
                    else
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = $"Order {orderId} not found.";
                    }
                }

                LoadOrders(); // Refresh grid
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error deleting order: " + ex.Message;
            }
        }

        private void ShowDistributorQuotations(int orderId)
        {
            try
            {
                using (var db = new GadgetHubContext())
                {
                    var quotes = db.DistributorQuotations
                        .Where(q => q.OrderId == orderId)
                        .Select(q => new
                        {
                            q.DistributorName,
                            q.PricePerUnit,
                            q.DeliveryDays,
                            q.SubmittedAt
                        }).ToList();

                    gvQuotes.DataSource = quotes;
                    gvQuotes.DataBind();

                    pnlQuotes.Visible = true;
                    lblQuotesTitle.Text = $"Distributor Quotations for Order {orderId}";
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error loading quotations: " + ex.Message;
            }
        }

        protected void btnCloseQuotes_Click(object sender, EventArgs e)
        {
            pnlQuotes.Visible = false;
        }
    }
}
