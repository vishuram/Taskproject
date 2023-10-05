using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace taskregister
{
    public partial class login : System.Web.UI.Page
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {
           
           
        }

        protected void BtnLogin_Click_Click(object sender, EventArgs e)
        {
            string email = txtemail.Text;
           
            int userId = GetSlnoFromDatabase(email);

            if (userId != -1)
            {
                
                HttpCookie uIdCookie = new HttpCookie("userId");
                uIdCookie.Value = userId.ToString();
                uIdCookie.Expires = DateTime.Now.AddHours(1); 
                Response.Cookies.Add(uIdCookie);
                string uIdValue = Request.Cookies["userId"]?.Value;
                if (int.TryParse(uIdValue, out int intValue))
                {
                    Response.Redirect("Register.aspx");
                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Invalid Crediential!');", true);
            }
           
        }

        protected int GetSlnoFromDatabase(string email)

        {
            int userId = -1; 
            string connectionString = "Data Source=LAPTOP-QLQ22PR0; initial catalog=Demo;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "select userId from taskRegister6 where email='" + txtemail.Text + "'and password='" + txtpass.Text + "' and remark is null";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@email", email);
                 

                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        userId = Convert.ToInt32(result);

                    }
                }
            }

            return userId;
        }
    }
}