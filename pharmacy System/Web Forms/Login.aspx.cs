using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True";
            con.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String user = TextBox1.Text;
            String password = TextBox2.Text;
            String username = "";

            if (Page.IsValid)
            {
                //CUSTOMER LOGIN
                string query = "SELECT A.ACC_ID, A.ACC_USERNAME FROM ACCOUNT A, CUSTOMER C WHERE A.ACC_ID = C.ACC_ID AND A.ACC_PASSWORD = @password AND A.ACC_USERNAME = @username";
                SqlCommand comm = new SqlCommand(query, con);
                comm.Parameters.AddWithValue("password", password);
                comm.Parameters.AddWithValue("username", user);

                int counter = 0;

                using (SqlDataReader reader = comm.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        username = reader.GetString(1);
                        ++counter;
                    }
                }


                //DOCTOR LOGIN
                if (counter == 0)
                {
                    string query2 = "SELECT A.ACC_ID, A.ACC_USERNAME FROM ACCOUNT A, DOCTOR D WHERE A.ACC_ID = D.ACC_ID AND A.ACC_PASSWORD = @password AND A.ACC_USERNAME = @username";
                    SqlCommand comm2 = new SqlCommand(query2, con);
                    comm2.Parameters.AddWithValue("password", password);
                    comm2.Parameters.AddWithValue("username", user);

                    using (SqlDataReader reader = comm2.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            username = reader.GetString(1);
                            ++counter;
                        }
                    }


                    //PHARMACIST LOGIN
                    if (counter == 0)
                    {
                        string query3 = "SELECT A.ACC_ID, A.ACC_USERNAME FROM ACCOUNT A, PHARMACIST P WHERE A.ACC_ID = P.ACC_ID AND A.ACC_PASSWORD = @password AND A.ACC_USERNAME = @username";
                        SqlCommand comm3 = new SqlCommand(query3, con);
                        comm3.Parameters.AddWithValue("password", password);
                        comm3.Parameters.AddWithValue("username", user);

                        using (SqlDataReader reader = comm3.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                username = reader.GetString(1);
                                ++counter;
                            }
                        }

                        
                        //ADMIN LOGIN
                        if (counter == 0) {
                            string query4 = "SELECT ACC_TYPE FROM ACCOUNT WHERE ACC_PASSWORD = @password AND ACC_USERNAME = @username";
                            SqlCommand comm4 = new SqlCommand(query4, con);
                            comm4.Parameters.AddWithValue("password", password);
                            comm4.Parameters.AddWithValue("username", user);

                            
                            string accountT = "";
                            using (SqlDataReader reader = comm4.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                   accountT = reader.GetString(0);
                                    ++counter;
                                }
                            }

                            if (counter == 0)
                            {
                                Response.Write("<script>alert('Account not found')</script>");
                            }
                            else if (counter == 1)
                            {
                                Response.Write("<script>alert('Admin Account found');</script>");
                                Session["username"] = accountT;
                                Server.Transfer("manageMedicine.aspx");
                            }
                        }
                        else if (counter == 1)
                        {
                            Response.Write("<script>alert('Account found');</script>");
                            Session["username"] = username;
                            Server.Transfer("pharmacyPrescriptions.aspx");
                        }


                    }
                    else if (counter == 1)
                    {
                        Response.Write("<script>alert('Account found');</script>");
                        Session["username"] = username;
                        Server.Transfer("prescriptionUpload.aspx");
                    }
                }
                else if (counter==1) {
                    string deleteCart = "DELETE FROM TEMP_ONLINE_CART;";
                    SqlCommand comm2 = new SqlCommand(deleteCart, con);
                    comm2.ExecuteNonQuery();

                    Response.Write("<script>alert('Account found');</script>");
                    Session["username"] = username;
                    Server.Transfer("Home.aspx");
                }
            }
        }
    }
}