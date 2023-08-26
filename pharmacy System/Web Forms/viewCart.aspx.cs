using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
   
    public partial class cart : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();

            int id = Convert.ToInt32(Request.QueryString["pro"]);

            Session["sessionID"] = id;

            String searchOnlineCart = "select med_id from temp_online_cart";
            SqlCommand comm4 = new SqlCommand(searchOnlineCart, con);

            int i = 0, j;

            using (SqlDataReader reader = comm4.ExecuteReader())
            {
                while (reader.Read())
                {
                    
                    j = reader.GetInt32(0);

                    if (j == id) {
                        ++i;
                    }
                              
                }
            }


            int d = 0;
            Session["customerID"] = d;

            String searchCustomer = "select * from customer c, account a where c.acc_id = a.acc_id and acc_username =  @user";
            SqlCommand comm = new SqlCommand(searchCustomer, con);
            comm.Parameters.AddWithValue("user", Session["username"]);

            int c = 0;

            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    d = reader.GetInt32(0);
                    Session["customerID"] = d;
                    ++c;
                }
            }

            
            

            if (i == 0 && id != 0)
            {
                String searchMedicine = "select * from medicine m where med_id =  @medID";
                SqlCommand comm2 = new SqlCommand(searchMedicine, con);
                comm2.Parameters.AddWithValue("medID", id);

                int f = 0, g = 0;

                decimal p = 0;

                String n = "";

                using (SqlDataReader reader = comm2.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        f = reader.GetInt32(0);
                        n = reader.GetString(1);
                        p = reader.GetDecimal(4);
                    }
                }

                String stockSearch = "select sum(s.Qty_On_Hand) as QTY_STOCK from medicine m, stock s where s.Med_ID = m.med_id and m.med_id = " + f;
                SqlCommand s = new SqlCommand(stockSearch, con);

                int stockQ = Convert.ToInt32(s.ExecuteScalar());

                Response.Write("<script>alert('" + id + "')</script>");

                String insertTempOrder = "insert into temp_online_cart values(@custID, @medID, @medName, @price, @qtyStock, 0, 0)";
                SqlCommand sql = new SqlCommand(insertTempOrder, con);
                sql.Parameters.AddWithValue("@custID", d);
                sql.Parameters.AddWithValue("@medID", f);
                sql.Parameters.AddWithValue("@medName", n);
                sql.Parameters.AddWithValue("@price", p);
                sql.Parameters.AddWithValue("@qtyStock", stockQ);

                sql.ExecuteNonQuery();


                Response.Write("<script>alert('Item added to Cart')</script>");


                String queryCart = "select t.Order_Id, t.med_id, t.MED_NAME, t.QTY_STOCK, m.price, t.QTY_ORDERED, m.price*t.qty_ordered as ITEM_TOTAL from temp_online_cart t, medicine m where t.med_id = m.med_id and t.CUS_ID = " + d;
                SqlDataAdapter sqlDa = new SqlDataAdapter(queryCart, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvOnlineOrders.DataSource = dtbl;
                gvOnlineOrders.DataBind();

                String displayTotal = "select sum(t.qty_ordered*m.price) as GrandTotal from temp_online_cart t, medicine m where t.med_id = m.med_id and t.cus_id = " + d;
                SqlDataAdapter sqlDa2 = new SqlDataAdapter(displayTotal, con);
                DataTable dtbl2 = new DataTable();
                sqlDa2.Fill(dtbl2);
                gvTotal.DataSource = dtbl2;
                gvTotal.DataBind();

            }

            else {

                String queryCart = "select t.Order_Id, t.med_id, t.MED_NAME, t.QTY_STOCK, m.price, t.QTY_ORDERED, m.price*t.qty_ordered as ITEM_TOTAL from temp_online_cart t, medicine m where t.med_id = m.med_id and t.CUS_ID = " + Session["customerID"];
                SqlDataAdapter sqlDa = new SqlDataAdapter(queryCart, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvOnlineOrders.DataSource = dtbl;
                gvOnlineOrders.DataBind();

                String displayTotal = "select sum(t.qty_ordered*m.price) as GrandTotal from temp_online_cart t, medicine m where t.med_id = m.med_id and t.cus_id = " + d;
                SqlDataAdapter sqlDa2 = new SqlDataAdapter(displayTotal, con);
                DataTable dtbl2 = new DataTable();
                sqlDa2.Fill(dtbl2);
                gvTotal.DataSource = dtbl2;
                gvTotal.DataBind();
            }
            

            

        }

        protected void gvOnlineOrders_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String deleteOnlineCart = "delete from temp_online_cart where med_id = @med and cus_id = @cus and order_id = @order";
            SqlCommand comm = new SqlCommand(deleteOnlineCart, con);
            comm.Parameters.AddWithValue("med", gvOnlineOrders.Rows[e.RowIndex].Cells[1].Text);
            comm.Parameters.AddWithValue("cus", Session["customerID"]);
            comm.Parameters.AddWithValue("order", gvOnlineOrders.Rows[e.RowIndex].Cells[0].Text);

            comm.ExecuteNonQuery();

            Response.Write("<script>alert('Item removed from cart')</script>");

            String queryCart = "select t.Order_Id, t.med_id, t.MED_NAME, t.QTY_STOCK, m.price, t.QTY_ORDERED, m.price*t.qty_ordered as ITEM_TOTAL from temp_online_cart t, medicine m where t.med_id = m.med_id and t.CUS_ID = " + Session["customerID"];
            SqlDataAdapter sqlDa = new SqlDataAdapter(queryCart, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvOnlineOrders.DataSource = dtbl;
            gvOnlineOrders.DataBind();

            String displayTotal = "select sum(t.qty_ordered*m.price) as GrandTotal from temp_online_cart t, medicine m where t.med_id = m.med_id and t.cus_id = " + Session["customerID"];
            SqlDataAdapter sqlDa2 = new SqlDataAdapter(displayTotal, con);
            DataTable dtbl2 = new DataTable();
            sqlDa2.Fill(dtbl2);
            gvTotal.DataSource = dtbl2;
            gvTotal.DataBind();
        }


        
        protected void gvOnlineOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //INCREASING REQUESTED ITEM ORDERS
            if (e.CommandName == "increase")
            {

                int crow = Convert.ToInt32(e.CommandArgument.ToString());
                int v = Convert.ToInt32(gvOnlineOrders.Rows[crow].Cells[5].Text);

                String searchPrice = "select price from medicine where med_id = @p";
                SqlCommand comm5 = new SqlCommand(searchPrice, con);
                comm5.Parameters.AddWithValue("p", Convert.ToInt32(gvOnlineOrders.Rows[crow].Cells[1].Text));

                decimal q = 0;

                using (SqlDataReader reader = comm5.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        q = reader.GetDecimal(0);
                    }
                }

                String stockQt = "select qty_stock from temp_online_cart where cus_id = " + Session["customerID"] + " and med_id = " + Convert.ToInt32(gvOnlineOrders.Rows[crow].Cells[1].Text);
                SqlCommand sq = new SqlCommand(stockQt, con);

                int qty = Convert.ToInt32(sq.ExecuteScalar());

                string updateQty = "update temp_online_cart set qty_ordered = " + (v + 1) + ", item_total = " + (q* (v + 1)) + ", qty_stock = " + (qty - 1) + " where cus_id = " + Session["customerID"] + " and med_id = " + Convert.ToInt32(gvOnlineOrders.Rows[crow].Cells[1].Text);
                SqlCommand comm = new SqlCommand(updateQty, con);

                comm.ExecuteNonQuery();

                String queryCart = "select t.Order_Id, t.med_id, t.MED_NAME, t.QTY_STOCK, m.price, t.QTY_ORDERED, m.price*t.qty_ordered as ITEM_TOTAL from temp_online_cart t, medicine m where t.med_id = m.med_id and t.CUS_ID = " + Session["customerID"];
                SqlDataAdapter sqlDa = new SqlDataAdapter(queryCart, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvOnlineOrders.DataSource = dtbl;
                gvOnlineOrders.DataBind();

                String displayTotal = "select sum(t.qty_ordered*m.price) as GrandTotal from temp_online_cart t, medicine m where t.med_id = m.med_id and t.cus_id = " + Session["customerID"];
                SqlDataAdapter sqlDa2 = new SqlDataAdapter(displayTotal, con);
                DataTable dtbl2 = new DataTable();
                sqlDa2.Fill(dtbl2);
                gvTotal.DataSource = dtbl2;
                gvTotal.DataBind();



            }

            //DECREASING REQUESTED ITEM ORDERS
            else if (e.CommandName == "decrease")
            {
                int crow = Convert.ToInt32(e.CommandArgument.ToString());
                int v = Convert.ToInt32(gvOnlineOrders.Rows[crow].Cells[5].Text);

                String searchPrice = "select price from medicine where med_id = @p";
                SqlCommand comm5 = new SqlCommand(searchPrice, con);
                comm5.Parameters.AddWithValue("p", Convert.ToInt32(gvOnlineOrders.Rows[crow].Cells[1].Text));

                decimal q = 0;

                using (SqlDataReader reader = comm5.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        q = reader.GetDecimal(0);
                    }
                }

                if (v != 0)
                {
                    String stockQt = "select qty_stock from temp_online_cart where cus_id = " + Session["customerID"] + " and med_id = " + Convert.ToInt32(gvOnlineOrders.Rows[crow].Cells[1].Text);
                    SqlCommand sq = new SqlCommand(stockQt, con);

                    int qty = Convert.ToInt32(sq.ExecuteScalar());

                    string updateQty = "update temp_online_cart set qty_ordered = " + (v - 1) + ", item_total = " + (q * (v - 1)) + ", qty_stock = " + (qty + 1) + " where cus_id = " + Session["customerID"] + " and med_id = " + Convert.ToInt32(gvOnlineOrders.Rows[crow].Cells[1].Text);
                    SqlCommand comm = new SqlCommand(updateQty, con);

                    comm.ExecuteNonQuery();

                    String queryCart = "select t.Order_Id, t.med_id, t.MED_NAME, t.QTY_STOCK, m.price, t.QTY_ORDERED, m.price*t.qty_ordered as ITEM_TOTAL from temp_online_cart t, medicine m where t.med_id = m.med_id and t.CUS_ID = " + Session["customerID"];
                    SqlDataAdapter sqlDa = new SqlDataAdapter(queryCart, con);
                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    gvOnlineOrders.DataSource = dtbl;
                    gvOnlineOrders.DataBind();

                    String displayTotal = "select sum(t.qty_ordered*m.price) as GrandTotal from temp_online_cart t, medicine m where t.med_id = m.med_id and t.cus_id = " + Session["customerID"];
                    SqlDataAdapter sqlDa2 = new SqlDataAdapter(displayTotal, con);
                    DataTable dtbl2 = new DataTable();
                    sqlDa2.Fill(dtbl2);
                    gvTotal.DataSource = dtbl2;
                    gvTotal.DataBind();
                }
                else {
                    Response.Write("<script>alert('Cannot decrease below 0')</script>");
                }
            }
        }

        //CONTINUE SHOPPING BUTTON
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("viewProductMothers.aspx");
        }

        //CHECKOUT BUTTON
        protected void Button2_Click(object sender, EventArgs e)
        {
            if (gvTotal.Rows[0].Cells[0].Text.Equals("&nbsp;")  || gvTotal.Rows[0].Cells[0].Text.Equals("0.00")) {
                Response.Write("<script>alert('You cannot procced to checkout because total amount is 0')</script>");
            }
            else {
                Response.Write("<script>alert('" + gvTotal.Rows[0].Cells[0].Text + "')</script>");
                Response.Redirect("checkout.aspx");
            }
            
        }
    }
}