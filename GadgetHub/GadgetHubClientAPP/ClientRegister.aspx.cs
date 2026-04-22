using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace GadgetHubClientAPP
{
    public partial class ClientRegister : Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                lblMessage.Text = "Please enter all fields.";
                return;
            }

            if (password != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match!";
                return;
            }

            if (SaveUserToDatabase(username, password))
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Registration successful! <a href='ClientLogin.aspx'>Login here</a>";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Username already exists or an error occurred.";
            }
        }

        private bool SaveUserToDatabase(string username, string password)
        {
            string connStr = ConfigurationManager.ConnectionStrings["GadgetHubDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM ClientUsers WHERE Username = @Username", conn);
                    checkCmd.Parameters.AddWithValue("@Username", username);
                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                        return false;

                    // Insert new user
                    SqlCommand insertCmd = new SqlCommand("INSERT INTO ClientUsers (Username, PasswordHash) VALUES (@Username, @Password)", conn);
                    insertCmd.Parameters.AddWithValue("@Username", username);
                    insertCmd.Parameters.AddWithValue("@Password", password); // 🔐 Replace with hashing in production

                    insertCmd.ExecuteNonQuery();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }
    }
}
