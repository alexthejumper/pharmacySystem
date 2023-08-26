using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Security.Principal;


namespace pharmacy_System
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True";
            con.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string surname = surnameTB.Text;
            string first_name = fnameTB.Text;
            string email = emailTB.Text;
            int phone = Convert.ToInt32(mobileNumTB.Text); 
            string street = streetTB.Text;
            string town = townTB.Text;
            string password = passwordTB.Text;
            string username = usernameTB.Text;
            string NIC = nicTB.Text;
            string accountType = DropDownList1.SelectedValue;
            DateTime today = DateTime.Today;

            if (Page.IsValid)
            {
                SqlCommand cmd2 = new SqlCommand("insert into account values(@type, @date, @username, @password)", con);

                cmd2.Parameters.AddWithValue("@type", accountType);
                cmd2.Parameters.AddWithValue("@date", today);
                cmd2.Parameters.AddWithValue("@username", username);
                cmd2.Parameters.AddWithValue("@password", password);
                cmd2.ExecuteNonQuery();

                string query = "SELECT ACC_ID FROM ACCOUNT WHERE ACC_PASSWORD = @password";
                SqlCommand comm = new SqlCommand(query, con);
                comm.Parameters.AddWithValue("password", password);
                int ID = (int)comm.ExecuteScalar();

                SqlCommand cmd;


                if (accountType == "PHARMACIST")
                {
                    cmd = new SqlCommand("insert into pharmacist values(@surname, @fname, @NIC, @street, @town, @phone, @email, " + ID + ")", con);
                }
                else if (accountType == "DOCTOR")
                {
                    cmd = new SqlCommand("insert into doctor values(@surname, @fname, @NIC, @street, @town, @phone, @email, " + ID + ")", con);
                }
                else {
                    cmd = new SqlCommand("insert into customer values(@surname, @fname, @NIC, @street, @town, @phone, @email, " + ID + ")", con);
                }

            
                cmd.Parameters.AddWithValue("@surname", surname);
                cmd.Parameters.AddWithValue("@fname", first_name);
                cmd.Parameters.AddWithValue("@NIC", NIC);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.Parameters.AddWithValue("@street", street);
                cmd.Parameters.AddWithValue("@town", town);

                cmd.ExecuteNonQuery();

                
                Response.Write("<script>alert('Data inserted successfully')</script>");

                surnameTB.Text = "";
                fnameTB.Text = "";
                emailTB.Text = "";
                mobileNumTB.Text = "";
                streetTB.Text = "";
                townTB.Text = "";
                passwordTB.Text = "";
                confirmPasswordTB.Text = "";
                DropDownList1.SelectedValue = "0";

                Server.Transfer("Login.aspx");
            }
            else {
                Response.Write("<script>alert('Data cannot be inserted')</script>");
            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}