using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
    public partial class viewUploadedPrescription : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();
        }

        //Search for prescriptions
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!TextBox1.Text.Equals(""))
            {
                string searchCustomer = "select cust_id from customer where cust_nic = @nic";
                SqlCommand comm = new SqlCommand(searchCustomer, con);
                comm.Parameters.AddWithValue("nic", TextBox1.Text.Trim());


                int c = 0, d;

                using (SqlDataReader reader = comm.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        d = reader.GetInt32(0);
                        TextBox2.Text = d.ToString();
                        ++c;
                    }
                }

                if (c != 0)
                {
                    string deleteSql = "delete from temp_presc_cart";
                    SqlCommand co = new SqlCommand(deleteSql, con);
                    co.ExecuteNonQuery();

                    Response.Write("<script>alert('Old Prescriptions deleted')</script>");

                    string searchPresc = "SELECT P.PRESC_ID, P.PRESC_DATE, M.MED_ID, M.MED_NAME, PS.STOCK_ID, PS.QTY_PRESC, M.MED_IMAGE FROM PRESCRIPTION P, PRESCRIPTION_STOCK PS, MEDICINE M, CUSTOMER C WHERE P.CUST_ID = C.CUST_ID AND P.PRESC_ID = PS.PRESC_ID AND M.MED_ID = PS.MED_ID AND C.CUST_NIC = '" + TextBox1.Text + "'";
                    SqlDataAdapter sqlDa = new SqlDataAdapter(searchPresc, con);
                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    gvSelectPrescription.DataSource = dtbl;
                    gvSelectPrescription.DataBind();
                }
                else {
                    Response.Write("<script>alert('Customer not found. Please try re entering a valid NIC')</script>");
                }
                
            }

            else {
                Response.Write("<script>alert('Customer NIC must be entered if you want to search')</script>");
            }
        }

        protected void gvSelectPrescription_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int crow = Convert.ToInt32(e.CommandArgument.ToString());

            string medID = gvSelectPrescription.Rows[crow].Cells[2].Text;
            string stock = gvSelectPrescription.Rows[crow].Cells[4].Text;
            int qtyy = Convert.ToInt32(gvSelectPrescription.Rows[crow].Cells[5].Text);

            if (e.CommandName == "select") {

                string query = "select * from temp_presc_cart where md_id = @medID and stk_id = @stkID";
                SqlCommand comm2 = new SqlCommand(query, con);
                comm2.Parameters.AddWithValue("medID", medID);
                comm2.Parameters.AddWithValue("stkID", stock);


                int d = 0;

                using (SqlDataReader reader = comm2.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        ++d;
                    }
                }

                if (d == 0)
                {
                    string medStockQuery = "select qty_on_hand from stock where med_id = @medID and stock_id = @stockID";
                    SqlCommand comm = new SqlCommand(medStockQuery, con);
                    comm.Parameters.AddWithValue("medID", medID);
                    comm.Parameters.AddWithValue("stockID", stock);


                    int c = 0;

                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            c = reader.GetInt32(0);
                        }
                    }

                    if (c >= qtyy)
                    {
                        string insertPresc = "insert into temp_presc_cart values(@custID, @medN, @medID, @stkID, @q)";
                        SqlCommand comm3 = new SqlCommand(insertPresc, con);
                        comm3.Parameters.AddWithValue("custID", TextBox2.Text);
                        comm3.Parameters.AddWithValue("medN", gvSelectPrescription.Rows[crow].Cells[3].Text);
                        comm3.Parameters.AddWithValue("medID", medID);
                        comm3.Parameters.AddWithValue("stkID", stock);
                        comm3.Parameters.AddWithValue("q", qtyy);
                        comm3.ExecuteNonQuery();


                        Response.Write("<script>alert('Item added to Prescription')</script>");

                        SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT CUS_ID, MED_NAME, MD_ID, STK_ID, QTY FROM TEMP_PRESC_CART", con);
                        DataTable dtbl = new DataTable();
                        sqlDa.Fill(dtbl);
                        gvPrescCart.DataSource = dtbl;
                        gvPrescCart.DataBind();
                    }
                    else
                    {
                        Response.Write("<script>alert('This medicine does not have sufficient stock to match the pre selected prescription's stock quantity.')</script>");
                    }
                }
                else {
                    Response.Write("<script>alert('Cannot insert the same item more than once')</script>");
                }

            }

        }



        //Upload button
        protected void Button2_Click(object sender, EventArgs e)
        {
            string query = "select * from temp_presc_cart";
            SqlCommand comm8 = new SqlCommand(query, con);


            int d = 0;

            using (SqlDataReader reader = comm8.ExecuteReader())
            {
                while (reader.Read())
                {
                    ++d;
                }
            }

            if (d != 0)
            {

                if (!diseaseTextBox.Text.Equals(""))
                {
                    DateTime today = DateTime.Today;

                    string createPresc = "insert into prescription values (@date, @diC, @docC, 'UNPAID', @cusID)";
                    SqlCommand comm5 = new SqlCommand(createPresc, con);
                    comm5.Parameters.AddWithValue("@date", today);
                    comm5.Parameters.AddWithValue("@diC", diseaseTextBox.Text);
                    comm5.Parameters.AddWithValue("@docC", prescCommentsBox.Text);
                    comm5.Parameters.AddWithValue("@cusID", TextBox2.Text);

                    comm5.ExecuteNonQuery();

                    string identity = "select @@identity from prescription";
                    SqlCommand comm6 = new SqlCommand(identity, con);

                    int n = 0;

                    using (SqlDataReader reader3 = comm6.ExecuteReader())
                    {
                        while (reader3.Read())
                        {
                            n = Convert.ToInt32(reader3.GetDecimal(0));
                        }
                    }


                    //
                    string query4 = "select * from temp_presc_cart";
                    SqlCommand comm2 = new SqlCommand(query4, con);

                    using (SqlDataReader reader = comm2.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            //inserting in prescription stock table
                            string insertPresc = "insert into prescription_stock values(@presc_ID, @cusID, @mID, @stockID, @qty)";
                            SqlCommand comm3 = new SqlCommand(insertPresc, con);
                            comm3.Parameters.AddWithValue("presc_ID", n);
                            comm3.Parameters.AddWithValue("cusID", TextBox2.Text);
                            comm3.Parameters.AddWithValue("mID", reader.GetInt32(3));
                            comm3.Parameters.AddWithValue("stockID", reader.GetString(4));
                            comm3.Parameters.AddWithValue("qty", reader.GetInt32(5));

                            comm3.ExecuteNonQuery();


                            //Updating Stock for quantity prescribed

                            string searchStock = "select qty_on_hand from stock where med_id = @med_id and stock_id = @stkID";
                            SqlCommand comm10 = new SqlCommand(searchStock, con);
                            comm10.Parameters.AddWithValue("med_ID", reader.GetInt32(3));
                            comm10.Parameters.AddWithValue("stkID", reader.GetString(4));

                            int stkQty;

                            using (SqlDataReader reader4 = comm10.ExecuteReader())
                            {
                                while (reader4.Read())
                                {
                                    stkQty = reader4.GetInt32(0);


                                    string updatePresc = "update stock set qty_on_hand = @qty where med_id = @medID and stock_id = @stkID";
                                    SqlCommand comm9 = new SqlCommand(updatePresc, con);

                                    comm9.Parameters.AddWithValue("qty", stkQty - reader.GetInt32(5));
                                    comm9.Parameters.AddWithValue("medID", reader.GetInt32(3));
                                    comm9.Parameters.AddWithValue("stkID", reader.GetString(4));
                                    comm9.ExecuteNonQuery();
                                }
                            }
                        }
                    }



                    //Deleting temp_presc_cart
                    Response.Write("<script>alert('Prescription saved succesfully')</script>");

                    string deleteSql = "delete from temp_presc_cart";
                    SqlCommand co = new SqlCommand(deleteSql, con);
                    co.ExecuteNonQuery();

                    gvPrescCart.DataBind();

                    Response.Write("<script>alert('Old Prescriptions deleted')</script>");

                    TextBox1.Text = "";
                    TextBox2.Text = "";
                    diseaseTextBox.Text = "";
                    prescCommentsBox.Text = "";

                }
                else
                {
                    Response.Write("<script>alert('At least disease comments must be provided before sending the prescription')</script>");
                }
            }
            else {
                Response.Write("<script>alert('Prescription item(s) must be selected before sending the prescription')</script>");
            }
        }

        protected void gvPrescCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            int crow = Convert.ToInt32(e.CommandArgument.ToString());

            string medID = gvPrescCart.Rows[crow].Cells[2].Text;
            string stock = gvPrescCart.Rows[crow].Cells[3].Text;

            //Removing item from prescription cart
            if (e.CommandName == "remove")
            {

                string deleteRecord = "delete from temp_presc_cart where md_id = @medID and stk_id = @stockID";
                SqlCommand co = new SqlCommand(deleteRecord, con);
                co.Parameters.AddWithValue("medID", medID);
                co.Parameters.AddWithValue("stockID", stock);
                co.ExecuteNonQuery();

                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT CUS_ID, MED_NAME, MD_ID, STK_ID, QTY FROM TEMP_PRESC_CART", con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvPrescCart.DataSource = dtbl;
                gvPrescCart.DataBind();
            }
        }

    }
}