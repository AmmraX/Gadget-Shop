using System;
using System.Collections.Generic;
using System.Web.UI;

namespace GadgetHubClientAPP
{
    public partial class DistributorLogin : Page
    {
        
        private readonly Dictionary<string, string> distributors = new Dictionary<string, string>
        {
            { "TechWorld", "Tech1" },
            { "ElectroCom", "Elect1" },
            { "GadgetCentral", "Gadget1" }
        };

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string distributorName = txtDistributorName.Text.Trim();
            string password = txtPassword.Text;

            if (distributors.ContainsKey(distributorName) && distributors[distributorName] == password)
            {
                Session["DistributorName"] = distributorName;

                Response.Redirect("DistributorDashboard.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid distributor name or password.";
            }
        }
    }
}
