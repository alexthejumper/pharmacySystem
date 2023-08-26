using iTextSharp.text.pdf;
using iTextSharp.text;
using iTextSharp.tool.xml;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
    public partial class viewPayments : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();

            String deletePayTemp = "delete from temp_payment";
            SqlCommand sql = new SqlCommand(deletePayTemp, con);
            sql.ExecuteNonQuery();

            String searchCustomer = "select * from customer c, account a where c.acc_id = a.acc_id and acc_username =  @user";
            SqlCommand comm3 = new SqlCommand(searchCustomer, con);
            comm3.Parameters.AddWithValue("user", Session["username"]);

            int d = 0;

            using (SqlDataReader reader = comm3.ExecuteReader())
            {
                while (reader.Read())
                {
                    d = reader.GetInt32(0);
      
                }
            }

            String selectPayment = "select * from payment where order_id in (select Order_ID from customer_order where cust_id = @custId) or Presc_ID in (select Presc_ID from prescription where Cust_ID = @custId)";
            SqlCommand comm = new SqlCommand(selectPayment, con);
            comm.Parameters.AddWithValue("custId", d);

            using (SqlDataReader reader2 = comm.ExecuteReader())
            {
                while (reader2.Read())
                {
                    if (reader2[3] != DBNull.Value) {
                        String insertTempPay = "insert into temp_payment values (@date, @amount, 'PRESCRIPTION', @reference)";
                        SqlCommand comm2 = new SqlCommand(insertTempPay, con);
                        comm2.Parameters.AddWithValue("date", reader2.GetDateTime(1));
                        comm2.Parameters.AddWithValue("amount", reader2.GetDecimal(2));
                        comm2.Parameters.AddWithValue("reference", reader2.GetInt32(3));

                        comm2.ExecuteNonQuery();
                    }
                    else
                    {
                        String insertTempPay = "insert into temp_payment values (@date, @amount, 'ONLINE ORDER', @reference)";
                        SqlCommand comm2 = new SqlCommand(insertTempPay, con);
                        comm2.Parameters.AddWithValue("date", reader2.GetDateTime(1));
                        comm2.Parameters.AddWithValue("amount", reader2.GetDecimal(2));
                        comm2.Parameters.AddWithValue("reference", reader2.GetInt32(4));

                        comm2.ExecuteNonQuery();
                    }

                }
            }


            String selectPay = "select p_id, p_date, p_amount, p_category, reference_id from temp_payment";
            SqlDataAdapter sqlDa2 = new SqlDataAdapter(selectPay, con);
            DataTable dtbl2 = new DataTable();
            sqlDa2.Fill(dtbl2);
            gvViewPayments.DataSource = dtbl2;
            gvViewPayments.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("reportView.aspx");
        }
    }
}