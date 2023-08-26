using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace pharmacy_System.Web_Forms
{
    public partial class prescriptionUpload : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string query = "SELECT CUST_ID FROM CUSTOMER WHERE CUST_NIC = @NIC";
            SqlCommand comm = new SqlCommand(query, con);
            comm.Parameters.AddWithValue("NIC", TextBox2.Text);

            string n;
            int c = 0;

            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    n = reader.GetInt32(0).ToString();
                    Response.Write("<script>alert('Customer found')</script>");
                    TextBox3.Text = n;
                    ++c;
                }
            }

            if (c == 0)
            {
                Response.Write("<script>alert('Customer not found. Please try re entering NIC')</script>");
            }
            else
            {
                string deleteSql = "delete from temp_presc_cart";
                SqlCommand co = new SqlCommand(deleteSql, con);
                co.ExecuteNonQuery();

                Response.Write("<script>alert('Old Prescriptions deleted')</script>");
            }
        }




        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!TextBox3.Text.Equals(""))
            {
                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT STOCK_ID, STOCK_DESC, QTY_ON_HAND FROM STOCK WHERE MED_ID = " + GridView1.SelectedRow.Cells[0].Text, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvStock.DataSource = dtbl;
                gvStock.DataBind();

                Label5.Visible = true;

                Session["medicine_id"] = GridView1.SelectedRow.Cells[0].Text;
                Session["medicine_name"] = GridView1.SelectedRow.Cells[1].Text;

                Response.Write("<script>alert('" + Session["medicine_id"] + "')</script>");
            }
            else
            {
                Response.Write("<script>alert('Search a Customer first before proceeding with selection of items')</script>");
            }
        }

        //Done



        protected void gvStock_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //Adding to prescription cart
            if (e.CommandName == "add")
            {

                string query = "SELECT QTY FROM TEMP_PRESC_CART WHERE CUS_ID = @cusID AND MD_ID = @medID AND STK_ID = @stockID";
                SqlCommand comm = new SqlCommand(query, con);
                comm.Parameters.AddWithValue("cusID", TextBox3.Text);
                comm.Parameters.AddWithValue("medID", Session["medicine_id"]);
                comm.Parameters.AddWithValue("stockID", Session["StockID"]);


                string q = "";
                int c = 0;

                using (SqlDataReader reader = comm.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        q = reader.GetInt32(0).ToString();
                        ++c;
                    }
                }

                Response.Write("<script>alert('" + q + "')</script>");
                Response.Write("<script>alert('" + Session["qtyStock"] + "')</script>");

                if (Convert.ToInt32(Session["qtyStock"].ToString()) > Convert.ToInt32(q))
                {
                    int crow = Convert.ToInt32(e.CommandArgument.ToString());
                    string v = gvStock.Rows[crow].Cells[0].Text;

                    string query2 = "SELECT QTY_ON_HAND FROM STOCK WHERE MED_ID = @medID AND STOCK_ID = @stockID";
                    SqlCommand comm11 = new SqlCommand(query2, con);
                    comm11.Parameters.AddWithValue("medID", Session["medicine_id"]);
                    comm11.Parameters.AddWithValue("stockID", Session["StockID"]);


                    string r = "";
                    int d = 0;

                    using (SqlDataReader reader = comm11.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            r = reader.GetInt32(0).ToString();
                            ++d;
                        }
                    }

                    string updatePresc3 = "update stock set qty_on_hand = @qty where stock_id = @stockID and med_id = @medID";
                    SqlCommand comm3 = new SqlCommand(updatePresc3, con);
                    comm3.Parameters.AddWithValue("qty", Convert.ToInt32(r) - 1);
                    comm3.Parameters.AddWithValue("medID", Session["medicine_id"]);
                    comm3.Parameters.AddWithValue("stockID", Session["StockID"]);
                    comm3.ExecuteNonQuery();

                    string updatePresc = "update temp_presc_cart set qty = @qty where cus_id = @cusID and md_id = @medID and stk_id = @stockID";
                    SqlCommand comm7 = new SqlCommand(updatePresc, con);
                    comm7.Parameters.AddWithValue("qty", Convert.ToInt32(q) + 1);
                    comm7.Parameters.AddWithValue("cusID", TextBox3.Text);
                    comm7.Parameters.AddWithValue("medID", Session["medicine_id"]);
                    comm7.Parameters.AddWithValue("stockID", Session["StockID"]);
                    comm7.ExecuteNonQuery();

                    Response.Write("<script>alert('Item updated succesfully')</script>");

                    //Refreshing the prescription cart view
                    SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT CUS_ID, MED_NAME, MD_ID, STK_ID, QTY FROM TEMP_PRESC_CART", con);
                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    gvPrescriptionCart.DataSource = dtbl;
                    gvPrescriptionCart.DataBind();

                    //Refreshing the Stocks View
                    SqlDataAdapter sqlDa1 = new SqlDataAdapter("SELECT STOCK_ID, STOCK_DESC, QTY_ON_HAND FROM STOCK WHERE MED_ID = " + Session["medicine_ID"], con);
                    DataTable dtbl1 = new DataTable();
                    sqlDa1.Fill(dtbl1);
                    gvStock.DataSource = dtbl1;
                    gvStock.DataBind();
                }
                else
                {
                    Response.Write("<script>alert('Cannot add more than that. Limit reached as per stock quantity')</script>");
                }


            }



            //Dedcuting from prescription cart
            if (e.CommandName == "reduce")
            {

                string query = "SELECT QTY FROM TEMP_PRESC_CART WHERE CUS_ID = @cusID AND MD_ID = @medID AND STK_ID = @stockID";
                SqlCommand comm = new SqlCommand(query, con);
                comm.Parameters.AddWithValue("cusID", TextBox3.Text);
                comm.Parameters.AddWithValue("medID", Session["medicine_id"]);
                comm.Parameters.AddWithValue("stockID", Session["StockID"]);


                string q = "";
                int c = 0;

                using (SqlDataReader reader = comm.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        q = reader.GetInt32(0).ToString();
                        ++c;
                    }
                }
     


                if (Convert.ToInt32(q) != 0)
                {
                    int crow = Convert.ToInt32(e.CommandArgument.ToString());
                    string v = gvStock.Rows[crow].Cells[0].Text;


                    string query2 = "SELECT QTY_ON_HAND FROM STOCK WHERE MED_ID = @medID AND STOCK_ID = @stockID";
                    SqlCommand comm11 = new SqlCommand(query2, con);
                    comm11.Parameters.AddWithValue("medID", Session["medicine_id"]);
                    comm11.Parameters.AddWithValue("stockID", Session["StockID"]);


                    string r = "";
                    int d = 0;

                    using (SqlDataReader reader = comm11.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            r = reader.GetInt32(0).ToString();
                            ++d;
                        }
                    }

                    string updatePresc3 = "update stock set qty_on_hand = @qty where stock_id = @stockID and med_id = @medID";
                    SqlCommand comm3 = new SqlCommand(updatePresc3, con);
                    comm3.Parameters.AddWithValue("qty", Convert.ToInt32(r) + 1);
                    comm3.Parameters.AddWithValue("medID", Session["medicine_id"]);
                    comm3.Parameters.AddWithValue("stockID", Session["StockID"]);
                    comm3.ExecuteNonQuery();

                    string updatePresc = "update temp_presc_cart set qty = @qty where cus_id = @cusID and md_id = @medID and stk_id = @stockID";
                    SqlCommand comm2 = new SqlCommand(updatePresc, con);
                    comm2.Parameters.AddWithValue("qty", Convert.ToInt32(q) - 1);
                    comm2.Parameters.AddWithValue("cusID", TextBox3.Text);
                    comm2.Parameters.AddWithValue("medID", Session["medicine_id"]);
                    comm2.Parameters.AddWithValue("stockID", Session["StockID"]);
                    comm2.ExecuteNonQuery();

                    Response.Write("<script>alert('Item updated succesfully')</script>");


                    //Refreshing the Prescription Cart View
                    SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT CUS_ID, MED_NAME, MD_ID, STK_ID, QTY FROM TEMP_PRESC_CART", con);
                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    gvPrescriptionCart.DataSource = dtbl;
                    gvPrescriptionCart.DataBind();


                    //Refreshing the Stocks View
                    SqlDataAdapter sqlDa1 = new SqlDataAdapter("SELECT STOCK_ID, STOCK_DESC, QTY_ON_HAND FROM STOCK WHERE MED_ID = " + Session["medicine_ID"], con);
                    DataTable dtbl1 = new DataTable();
                    sqlDa1.Fill(dtbl1);
                    gvStock.DataSource = dtbl1;
                    gvStock.DataBind();
                }
                else
                {
                    Response.Write("<script>alert('Cannot reduce below 0')</script>");
                }


            }
        }



        protected void gvStock_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["StockID"] = gvStock.SelectedRow.Cells[0].Text;
            Session["qtyStock"] = Convert.ToInt32(gvStock.SelectedRow.Cells[2].Text);

            string query = "SELECT CUS_ID, MD_ID, STK_ID FROM TEMP_PRESC_CART WHERE CUS_ID = @cusID AND MD_ID = @medID AND STK_ID = @stockID";
            SqlCommand comm = new SqlCommand(query, con);
            comm.Parameters.AddWithValue("cusID", TextBox3.Text);
            comm.Parameters.AddWithValue("medID", Session["medicine_id"]);
            comm.Parameters.AddWithValue("stockID", Session["StockID"]);

            int c = 0;

            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    ++c;
                }
            }

            if (c == 0)
            {
                string insertPresc = "insert into temp_presc_cart values(@custID, @medN, @medID, @stkID, 0)";
                SqlCommand comm3 = new SqlCommand(insertPresc, con);
                comm3.Parameters.AddWithValue("custID", TextBox3.Text);
                comm3.Parameters.AddWithValue("medN", Session["medicine_name"]);
                comm3.Parameters.AddWithValue("medID", Session["medicine_id"]);
                comm3.Parameters.AddWithValue("stkID", Session["StockID"]);
                comm3.ExecuteNonQuery();


                Response.Write("<script>alert('Item added to Prescription')</script>");

                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT CUS_ID, MED_NAME, MD_ID, STK_ID, QTY FROM TEMP_PRESC_CART", con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvPrescriptionCart.DataSource = dtbl;
                gvPrescriptionCart.DataBind();

                Label5.Visible = true;
                Label6.Visible = true;
            }
            else
            {
                Response.Write("<script>alert('Cannot choose the same product with the same stock more than once')</script>");
            }

        }


        //Delete from cart preview
        protected void gvPrescriptionCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Response.Write("<script>alert('" + TextBox3.Text + " " + gvPrescriptionCart.Rows[e.RowIndex].Cells[2].Text + " " + gvPrescriptionCart.Rows[e.RowIndex].Cells[3].Text + "')</script>");

            string deleteSql = "delete from temp_presc_cart where cus_id = @cID and md_id = @mID and stk_id = @sID";
            SqlCommand co = new SqlCommand(deleteSql, con);
            co.Parameters.AddWithValue("cID", TextBox3.Text);
            co.Parameters.AddWithValue("mID", gvPrescriptionCart.Rows[e.RowIndex].Cells[2].Text);
            co.Parameters.AddWithValue("sID", gvPrescriptionCart.Rows[e.RowIndex].Cells[3].Text);
            co.ExecuteNonQuery();

            string query2 = "SELECT QTY_ON_HAND FROM STOCK WHERE MED_ID = @medID AND STOCK_ID = @stockID";
            SqlCommand comm11 = new SqlCommand(query2, con);
            comm11.Parameters.AddWithValue("medID", Session["medicine_id"]);
            comm11.Parameters.AddWithValue("stockID", Session["StockID"]);


            string r = "";
            int d = 0;

            using (SqlDataReader reader = comm11.ExecuteReader())
            {
                while (reader.Read())
                {
                    r = reader.GetInt32(0).ToString();
                    ++d;
                }
            }

            string updateStock = "update stock set qty_on_hand = @qty where med_id = @medID";
            SqlCommand co1 = new SqlCommand(updateStock, con);
            co1.Parameters.AddWithValue("qty", Convert.ToInt32(r) + Convert.ToInt32(gvPrescriptionCart.Rows[e.RowIndex].Cells[4].Text));
            co1.Parameters.AddWithValue("medID", gvPrescriptionCart.Rows[e.RowIndex].Cells[2].Text);
            co1.ExecuteNonQuery();

            Response.Write("<script>alert('Prescription item deleted')</script>");

            //Refrshing the Prescription Cart Preview
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT CUS_ID, MED_NAME, MD_ID, STK_ID, QTY FROM TEMP_PRESC_CART", con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvPrescriptionCart.DataSource = dtbl;
            gvPrescriptionCart.DataBind();

            //Refreshing the Stocks View
            SqlDataAdapter sqlDa1 = new SqlDataAdapter("SELECT STOCK_ID, STOCK_DESC, QTY_ON_HAND FROM STOCK WHERE MED_ID = " + Session["medicine_ID"], con);
            DataTable dtbl1 = new DataTable();
            sqlDa1.Fill(dtbl1);
            gvStock.DataSource = dtbl1;
            gvStock.DataBind();
        }



        //Upload button
        protected void Button2_Click(object sender, EventArgs e)
        {
            string query = "SELECT CUS_ID, MD_ID, STK_ID FROM TEMP_PRESC_CART WHERE CUS_ID = @cusID AND MD_ID = @medID AND STK_ID = @stockID";
            SqlCommand comm = new SqlCommand(query, con);
            comm.Parameters.AddWithValue("cusID", TextBox3.Text);
            comm.Parameters.AddWithValue("medID", Session["medicine_id"]);
            comm.Parameters.AddWithValue("stockID", Session["StockID"]);

            int c = 0;

            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    ++c;
                }
            }

            if (c != 0 && !(diseaseTextBox.Text.Equals("")))
            {
                DateTime today = DateTime.Today;

                string insertPresc = "insert into prescription values (@date, @disC, @docC, @status, @custID)";
                SqlCommand comm3 = new SqlCommand(insertPresc, con);

                comm3.Parameters.AddWithValue("date", today);
                comm3.Parameters.AddWithValue("disC", diseaseTextBox.Text);
                comm3.Parameters.AddWithValue("docC", prescCommentsBox.Text);
                comm3.Parameters.AddWithValue("status", "UNPAID");
                comm3.Parameters.AddWithValue("custID", TextBox3.Text);
                comm3.ExecuteNonQuery();

                string identity = "select @@identity from prescription";
                SqlCommand comm2 = new SqlCommand(identity, con);

                int n = 0;

                using (SqlDataReader reader3 = comm2.ExecuteReader())
                {
                    while (reader3.Read())
                    {
                        n = Convert.ToInt32(reader3.GetDecimal(0));
                    }
                }



                string query2 = "SELECT CUS_ID, MD_ID, STK_ID, QTY FROM TEMP_PRESC_CART";
                SqlCommand comm5 = new SqlCommand(query2, con);
                comm5.Parameters.AddWithValue("cusID", TextBox3.Text);


                using (SqlDataReader reader2 = comm5.ExecuteReader())
                {
                    while (reader2.Read())
                    {

                        //inserting into prescription stock
                        int actualQty = reader2.GetInt32(3);

                        string insertPresc2 = "insert into prescription_stock values (@prescID, @custID, @medID, @stkID, @qty)";
                        SqlCommand comm8 = new SqlCommand(insertPresc2, con);

                        comm8.Parameters.AddWithValue("prescID", n);
                        comm8.Parameters.AddWithValue("custID", reader2.GetInt32(0));
                        comm8.Parameters.AddWithValue("medID", reader2.GetInt32(1));
                        comm8.Parameters.AddWithValue("stkID", reader2.GetString(2));
                        comm8.Parameters.AddWithValue("qty", actualQty);
                        comm8.ExecuteNonQuery();


                        //Updating Stock for quantity prescribed

                        string searchStock = "select qty_on_hand from stock where med_id = @med_id and stock_id = @stkID";
                        SqlCommand comm10 = new SqlCommand(searchStock, con);
                        comm10.Parameters.AddWithValue("med_ID", reader2.GetInt32(1));
                        comm10.Parameters.AddWithValue("stkID", reader2.GetString(2));

                        int stkQty;

                        using (SqlDataReader reader4 = comm10.ExecuteReader())
                        {
                            while (reader4.Read())
                            {
                                stkQty = reader4.GetInt32(0);


                                string updatePresc = "update stock set qty_on_hand = @qty where med_id = @medID and stock_id = @stkID";
                                SqlCommand comm9 = new SqlCommand(updatePresc, con);

                                comm9.Parameters.AddWithValue("qty", stkQty - actualQty);
                                comm9.Parameters.AddWithValue("medID", reader2.GetInt32(1));
                                comm9.Parameters.AddWithValue("stkID", reader2.GetString(2));
                                comm9.ExecuteNonQuery();
                            }
                        }
                    }

                    Response.Write("<script>alert('Prescription saved succesfully')</script>");

                    string deleteSql = "delete from temp_presc_cart";
                    SqlCommand co = new SqlCommand(deleteSql, con);
                    co.ExecuteNonQuery();

                    gvPrescriptionCart.DataBind();

                    Response.Write("<script>alert('Old Prescriptions deleted')</script>");

                    TextBox2.Text = "";
                    TextBox3.Text = "";
                    diseaseTextBox.Text = "";
                    prescCommentsBox.Text = "";
                }

            }
        }
    }
}