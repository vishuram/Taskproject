using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace taskregister
{
    public partial class Register : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnupdate.Visible = false;
                popup.Visible = false;
                GetDataIngridView();
                

            }
            
        }
       
        string connectionString = ConfigurationManager.ConnectionStrings["DemoConnectionString2"].ConnectionString;

        private SqlCommand cmd;
        private SqlDataReader dr;
        
        public void GetDataIngridView()
        {
            SqlConnection con = new SqlConnection(connectionString);

            con.Open();
            cmd = new SqlCommand("sp_UsersDetails");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            dr = cmd.ExecuteReader();
            GridView1.DataSource = dr;
            GridView1.DataBind();
            con.Close();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)                                                
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[6].Text = "*******";
                e.Row.Cells[7].Text = "*******";
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            btnupdate.Visible = false;
            string gender;
            string firstName = txtfirstname.Text;
            string lastName = txtlastname.Text;
            string mobileNo = txtmobileno.Text;
            string email = txtemail.Text;
            string password = txtpassword.Text;
            string confirmPassword = txtconfirmpass.Text;
            string address = txtAddress.Text;
            
            bool check = radiomale.Checked;
            if (check)
                gender = radiomale.Text;
            else
                gender = radiofemale.Text;
            string pincode = txtpincode.Text;
            string country = DropDownList1.SelectedValue;
            string Status = status.Checked ? "Active" : "Inactive";
            string uIdValue = Request.Cookies["userId"]?.Value;

            SqlConnection con = new SqlConnection(connectionString);

            SqlCommand co = new SqlCommand("exec sp_taskRegister2 '" + firstName + "','" + lastName + "','" + mobileNo + "','" + email + "','" + password + "','" + confirmPassword + "','" + address + "','" + gender + "','" + pincode + "','" + country + "','" + Status + "','" + uIdValue + "'", con);
                con.Open();
                co.ExecuteNonQuery();
                con.Close();
                clean();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "usernotfound", "alert('Inserted succesfully'); document.location.href='" + ResolveUrl("Register.aspx") + "';", true);

        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = txtemail.Text;
            string MobileNo = txtmobileno.Text;
            
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "Select count(*) from taskRegister6 where email = @email and mobileNo = @mobileNo";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@email", email);
                command.Parameters.AddWithValue("@mobileNo", MobileNo);
                int count = (int)command.ExecuteScalar();
                args.IsValid = (count == 0);
            }
        }


        public void clean()
        {
            txtfirstname.Text = "";
            txtlastname.Text = "";
            txtmobileno.Text = "";
            txtemail.Text = "";
            txtAddress.Text = "";
            txtpincode.Text = "";
            radiomale.Text = "";
            txtpassword.Text = "";
            txtconfirmpass.Text = "";
            DropDownList1.SelectedValue = "";
           
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnRegister.Visible = false;
            btnupdate.Visible = true;
           
            int id = Convert.ToInt32(GridView1.SelectedValue);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("FilldataReg", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("userId", id);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string Gender;
                    txtfirstname.Text = reader["firstName"].ToString();
                    txtlastname.Text = reader["lastName"].ToString();
                    txtmobileno.Text = reader["mobileNo"].ToString();
                    txtemail.Text = reader["email"].ToString();
                    txtAddress.Text = reader["address"].ToString();
                    txtpincode.Text = reader["pincode"].ToString();
                    string gender = reader["gender"].ToString();
                    if (gender == "Male")
                    {
                        radiomale.Checked = true;
                        radiofemale.Checked = false;
                    }
                    else if (gender == "Female")
                    {
                        radiofemale.Checked = true;
                        radiomale.Checked = false;
                    }
                    
                    txtpassword.Text = reader["Password"].ToString();
                    txtconfirmpass.Text = reader["ConfirmPassword"].ToString();
                    DropDownList1.Text = reader["country"].ToString();
                    status.Text = reader["status"].ToString();

                }
            }


        }

        protected void btnUpdate_Click(object sender, EventArgs e)  
        {
           
            string uIdValue = Request.Cookies["userId"]?.Value;
            int userId = Convert.ToInt32(GridView1.SelectedValue);
            string gender;
            string firstName = txtfirstname.Text;
            string lastName = txtlastname.Text;
            string mobileNo = txtmobileno.Text;
            string email = txtemail.Text;
            string address = txtAddress.Text;
            string pincode = txtpincode.Text;
            bool check = radiomale.Checked;
            if (check)
                gender = radiomale.Text;
            else
                gender = radiofemale.Text;
            string password = txtpassword.Text;
            string confirmPassword = txtconfirmpass.Text;
            string country = DropDownList1.SelectedValue;
            string Status = status.Checked ? "Active" : "Inactive";

            int data = checkduplicatedata2(userId, mobileNo, email);

            if (data==1)
            {
                
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "emailExists", "alert('Email already exists. Please choose a different email.');", true);
            }
            else
            {

                SqlConnection con = new SqlConnection(connectionString);


                SqlCommand co = new SqlCommand("exec sp_updatetaskRegister2 '" + userId + "','" + firstName + "','" + lastName + "','" + mobileNo + "','" + email + "','" + password + "','" + confirmPassword + "','" + address + "','" + gender + "','" + pincode + "','" + country + "','" + Status + "','"+ uIdValue+"'", con);
                con.Open();
                co.ExecuteNonQuery();
                con.Close();
                clean();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "usernotfound", "alert('succesfully Update'); document.location.href='" + ResolveUrl("Register.aspx") + "';", true);
            }
        }
        public int checkduplicatedata2(int UserId, string Mobile, string Email)
        {
            SqlConnection con = new SqlConnection(connectionString);

            SqlCommand co = new SqlCommand("exec DataExists2 '" + UserId + "','" + Mobile + "','" + Email + "'", con);
            con.Open();
            int value = Convert.ToInt32(co.ExecuteScalar());
            con.Close();
            return value;

        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            
            Label2.Text = Convert.ToString(GridView1.DataKeys[e.RowIndex].Value.ToString());
          
            popup.Visible = true;
           
           
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShortAlert", "alert('Are you sure want to Cancel?')", true);
           
        }



        protected void btndelete_Click(object sender, EventArgs e)
        {
            string uIdValue = Request.Cookies["userId"]?.Value;
            int userId = Convert.ToInt32(GridView1.SelectedValue);

            string inputRemark = txtremark.Text;
            int maxLength = 255; 

            if (inputRemark.Length > maxLength)
            {
                inputRemark = inputRemark.Substring(0, maxLength); 
            }
    
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("SP_Delete", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@userId", Label2.Text);
                    cmd.Parameters.AddWithValue("@CookieValue", uIdValue);
                    cmd.Parameters.AddWithValue("@remark", inputRemark);

                    var value = cmd.ExecuteNonQuery();

                    if (value == 1)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully deleted.');", true);
                    }
                }
            }
            Response.Redirect(Request.RawUrl);
        }


    }
}