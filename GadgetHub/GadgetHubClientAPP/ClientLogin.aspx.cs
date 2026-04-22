using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace GadgetHubClientAPP
{
    public partial class ClientLogin : Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (IsValidUser(username, password))
            {
                Session["ClientUsername"] = username;
                Response.Redirect("Default.aspx"); 
            }
            else
            {
                lblMessage.Text = "Invalid username or password!";
            }
        }

        private bool IsValidUser(string username, string password)
        {
            string connStr = ConfigurationManager.ConnectionStrings["GadgetHubDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM ClientUsers WHERE Username = @Username AND PasswordHash = @Password", conn);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password); 

                    int count = (int)cmd.ExecuteScalar();

                    return count > 0;
                }
                catch
                {
                    return false;
                }
            }
        }
    }
}
