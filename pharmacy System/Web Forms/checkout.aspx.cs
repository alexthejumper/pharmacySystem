using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
    public partial class checkout : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();

            String viewOrders = "select t.MED_NAME, m.med_image, m.price, t.QTY_ORDERED, m.price*t.qty_ordered as ITEM_TOTAL from medicine m, temp_online_cart t where m.med_id = t.med_id and cus_id = " + Session["customerID"];
            SqlDataAdapter sqlDa2 = new SqlDataAdapter(viewOrders, con);
            DataTable dtbl2 = new DataTable();
            sqlDa2.Fill(dtbl2);
            gvCheckoutOrders.DataSource = dtbl2;
            gvCheckoutOrders.DataBind();

            String cusomerDetails = "select * from customer where cust_id = " + Session["customerID"];
            SqlCommand comm = new SqlCommand(cusomerDetails, con);


            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    TextBox1.Text = reader.GetString(1);
                    TextBox2.Text = reader.GetString(2);
                    TextBox3.Text = reader.GetString(4);
                    TextBox4.Text = reader.GetString(5);
                    TextBox5.Text = reader.GetInt32(6).ToString();
                    TextBox6.Text = reader.GetString(7);
                }
            }

            String displayTotal = "select CONCAT('Rs ', sum(t.qty_ordered*m.price)) as GrandTotal from temp_online_cart t, medicine m where t.med_id = m.med_id and t.cus_id = " + Session["customerID"];
            SqlDataAdapter sqlDa = new SqlDataAdapter(displayTotal, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvCheckoutTotal.DataSource = dtbl;
            gvCheckoutTotal.DataBind();

        }

        //Edit Items
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewCart.aspx");
        }


        //Order Placement and Payment
        protected void Button2_Click(object sender, EventArgs e)
        {
            DateTime today = DateTime.Now;

            String createOrder = "insert into customer_order values(@date, @custID)";
            SqlCommand comm5 = new SqlCommand(createOrder, con);
            comm5.Parameters.AddWithValue("date", today);
            comm5.Parameters.AddWithValue("custID", Session["customerID"]);

            comm5.ExecuteNonQuery();

            String selectOrderID = "select @@IDENTITY";
            SqlCommand comm6 = new SqlCommand(selectOrderID, con);

            int orderID = Convert.ToInt32(comm6.ExecuteScalar());

            Response.Write("<script>alert('Order created " + orderID +"')</script>");

            String selectOrderItems = "select med_id, qty_ordered from temp_online_cart";
            SqlCommand comm2 = new SqlCommand(selectOrderItems, con);

            int d, f, g, h, j;

            String i;

            using (SqlDataReader reader = comm2.ExecuteReader())
            {
                while (reader.Read())
                {
                   d = reader.GetInt32(0);
                   f = reader.GetInt32(1);

                    j = f;

                    String selecStocks = "select stock_id, qty_on_hand from stock where med_id = " + d;
                    SqlCommand comm = new SqlCommand(selecStocks, con);

                    using (SqlDataReader reader2 = comm.ExecuteReader())
                    {
                        while (reader2.Read())
                        {
                            i = reader2.GetString(0);
                            g = reader2.GetInt32(1);

                            if (g >= f)
                            {
                                h = g - f;

                                String updateStock = "update stock set qty_on_hand = " + h + " where stock_id = '" + i + "'";
                                SqlCommand comm3 = new SqlCommand(updateStock, con);

                                comm3.ExecuteNonQuery();

                                Response.Write("<script>alert('Stock Updated')</script>");
                            }
                            else {
                                String updateStock = "update stock set qty_on_hand = 0 where stock_id = " + i;
                                SqlCommand comm11 = new SqlCommand(updateStock, con);

                                comm11.ExecuteNonQuery();
                                f -= g;

                                Response.Write("<script>alert('Stock Updated')</script>");

                                
                            }
                        }
                    }

                    String insertOrderStock = "insert into order_stock values(@orderID, @custID, @medID, @qty)";
                    SqlCommand sq = new SqlCommand(insertOrderStock, con);
                    sq.Parameters.AddWithValue("orderID", orderID);
                    sq.Parameters.AddWithValue("custID", Session["customerID"]);
                    sq.Parameters.AddWithValue("medID", d);
                    sq.Parameters.AddWithValue("qty", j);

                    sq.ExecuteNonQuery();

                    Response.Write("<script>alert('Order Stock Created')</script>");
                }
            }

            today = DateTime.Now;

            String displayTotal = "select sum(t.qty_ordered*m.price) from temp_online_cart t, medicine m where t.med_id = m.med_id and t.cus_id = " + Session["customerID"];
            SqlCommand comm9 = new SqlCommand(displayTotal, con);

            decimal total = Convert.ToDecimal(comm9.ExecuteScalar());

            Session["totalAmount"] = total;

            //Create payment
            String insertPayment = "insert into payment values(@date, @amount, null, @oID)";
            SqlCommand sql = new SqlCommand(insertPayment, con);
            sql.Parameters.AddWithValue("date", today);
            sql.Parameters.AddWithValue("amount", total);
            sql.Parameters.AddWithValue("oID", orderID);

            sql.ExecuteNonQuery();

            Response.Write("<script>alert('Payment Done')</script>");


            String deleteTempOrders = "delete from temp_online_cart";
            SqlCommand sql5 = new SqlCommand(deleteTempOrders, con);

            sql5.ExecuteNonQuery();

            Response.Write("<script>alert('Temp Cart deleted Done')</script>");

            Response.Redirect("paymentSuccesful.aspx");
        }
    }
}