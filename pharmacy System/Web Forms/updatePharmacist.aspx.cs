using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
    public partial class updatePharmacist : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
                con.Open();

                string query = "SELECT ACC_ID FROM ACCOUNT WHERE ACC_USERNAME = @user";
                SqlCommand comm = new SqlCommand(query, con);
                comm.Parameters.AddWithValue("user", Session["username"]);


                int c;

                using (SqlDataReader reader = comm.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        c = reader.GetInt32(0);

                        string query2 = "SELECT * FROM PHARMACIST WHERE ACC_ID = " + c;
                        SqlCommand comm2 = new SqlCommand(query2, con);

                        using (SqlDataReader reader2 = comm2.ExecuteReader())
                        {
                            while (reader2.Read())
                            {
                                Session["id"] = reader2.GetInt32(0);
                                TextBox1.Text = reader2.GetString(1);
                                TextBox2.Text = reader2.GetString(2);
                                TextBox3.Text = reader2.GetString(4);
                                TextBox4.Text = reader2.GetString(5);
                                TextBox5.Text = reader2.GetInt32(6).ToString();
                                TextBox6.Text = reader2.GetString(7);
                            }
                        }
                    }
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"E:\\Users\\USER\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();

            string updateCustomer = "update pharmacist set phar_surname = @surname, phar_fname = @fname, phar_street = @street, phar_town = @town, phar_mobile = @mobile, phar_email = @email where phar_id = @id";
            SqlCommand comm3 = new SqlCommand(updateCustomer, con);
            comm3.Parameters.AddWithValue("surname", TextBox1.Text);
            comm3.Parameters.AddWithValue("fname", TextBox2.Text);
            comm3.Parameters.AddWithValue("street", TextBox3.Text);
            comm3.Parameters.AddWithValue("town", TextBox4.Text);
            comm3.Parameters.AddWithValue("mobile", TextBox5.Text);
            comm3.Parameters.AddWithValue("email", TextBox6.Text);
            comm3.Parameters.AddWithValue("id", Session["id"]);

            comm3.ExecuteNonQuery();

            Response.Write("<script>alert('Your Profile has been updated successfully')</script>");
        }
    }
}