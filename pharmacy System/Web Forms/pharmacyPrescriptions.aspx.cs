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
    public partial class pharmacyPrescriptions : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();
        }

        //Search Prescription which is still unpaid
        protected void Button1_Click(object sender, EventArgs e)

        {

            

            if (!TextBox1.Text.Equals(""))
            {
                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT P.PRESC_ID, PS.CUST_ID, M.MED_ID, M.MED_NAME, PS.STOCK_ID, PS.QTY_PRESC, M.PRICE, M.PRICE * PS.QTY_PRESC AS TOTAL, M.MED_IMAGE FROM PRESCRIPTION P, PRESCRIPTION_STOCK PS, MEDICINE M WHERE P.PRESC_ID = PS.PRESC_ID AND PS.MED_ID = M.MED_ID AND P.STATUS = 'UNPAID' AND P.PRESC_ID = " + TextBox1.Text, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvUPresc.DataSource = dtbl;
                gvUPresc.DataBind();

                SqlDataAdapter sqlDa2 = new SqlDataAdapter("SELECT SUM(PRICE * QTY_PRESC) AS TOTAL FROM MEDICINE M, PRESCRIPTION P, PRESCRIPTION_STOCK PS WHERE M.MED_ID = PS.MED_ID AND P.PRESC_ID = PS.PRESC_ID AND P.STATUS = 'UNPAID' AND PS.Presc_ID = " + TextBox1.Text, con);
                DataTable dtbl3 = new DataTable();
                sqlDa2.Fill(dtbl3);
                gvTotal.DataSource = dtbl3;
                gvTotal.DataBind();
            }
            else {
                Response.Write("<script>alert('Prescription ID must be typed')</script>");
            }
            
        }

        protected void gvUPresc_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int crow = Convert.ToInt32(e.CommandArgument.ToString());

            string medID = gvUPresc.Rows[crow].Cells[2].Text;
            string stock = gvUPresc.Rows[crow].Cells[4].Text;
            int qtyy = Convert.ToInt32(gvUPresc.Rows[crow].Cells[5].Text);
            int prescc = Convert.ToInt32(gvUPresc.Rows[crow].Cells[0].Text);
            int cus = Convert.ToInt32(gvUPresc.Rows[crow].Cells[1].Text);

            if (e.CommandName == "reduce") {
                

                string query = "SELECT QTY_ON_HAND FROM STOCK WHERE MED_ID = @medID AND STOCK_ID = @stockID";
                SqlCommand comm = new SqlCommand(query, con);
                comm.Parameters.AddWithValue("medID", medID);
                comm.Parameters.AddWithValue("stockID", stock);


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
                    string updatePresc = "update stock set qty_on_hand = @qty where stock_id = @stockID and med_id = @medID";
                    SqlCommand comm2 = new SqlCommand(updatePresc, con);
                    comm2.Parameters.AddWithValue("qty", Convert.ToInt32(q) + 1);
                    comm2.Parameters.AddWithValue("medID",medID);
                    comm2.Parameters.AddWithValue("stockID", stock);
                    comm2.ExecuteNonQuery();

                    Response.Write("<script>alert('Item reduced succesfully')</script>");

                    string updatePresc2 = "update prescription_stock set qty_presc = @qty where presc_id = @prescID and cust_id = @custID and stock_id = @stockID and med_id = @medID";
                    SqlCommand comm3 = new SqlCommand(updatePresc2, con);
                    comm3.Parameters.AddWithValue("qty", qtyy - 1);
                    comm3.Parameters.AddWithValue("prescID", prescc);
                    comm3.Parameters.AddWithValue("custID", cus);
                    comm3.Parameters.AddWithValue("stockID", stock);
                    comm3.Parameters.AddWithValue("medID", medID);
                    
                    comm3.ExecuteNonQuery();

                    SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT P.PRESC_ID, PS.CUST_ID, M.MED_ID, M.MED_NAME, PS.STOCK_ID, PS.QTY_PRESC,  M.PRICE, M.PRICE * PS.QTY_PRESC AS TOTAL, M.MED_IMAGE FROM PRESCRIPTION P, PRESCRIPTION_STOCK PS, MEDICINE M WHERE P.PRESC_ID = PS.PRESC_ID AND PS.MED_ID = M.MED_ID AND P.STATUS = 'UNPAID' AND P.PRESC_ID = " + TextBox1.Text, con);
                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    gvUPresc.DataSource = dtbl;
                    gvUPresc.DataBind();

                    Response.Write("<script>alert('updated')</script>");

                    SqlDataAdapter sqlDa2 = new SqlDataAdapter("SELECT SUM(PRICE * QTY_PRESC) AS TOTAL FROM MEDICINE M, PRESCRIPTION P, PRESCRIPTION_STOCK PS WHERE M.MED_ID = PS.MED_ID AND P.PRESC_ID = P.PRESC_ID AND P.STATUS = 'UNPAID' AND PS.Presc_ID = " + TextBox1.Text, con);
                    DataTable dtbl3 = new DataTable();
                    sqlDa2.Fill(dtbl3);
                    gvTotal.DataSource = dtbl3;
                    gvTotal.DataBind();
                }
                else
                {
                    Response.Write("<script>alert('Cannot reduce below 0')</script>");
                }
            }


            if (e.CommandName == "remove") {

                string query = "SELECT QTY_ON_HAND FROM STOCK WHERE MED_ID = @medID AND STOCK_ID = @stockID";
                SqlCommand comm = new SqlCommand(query, con);
                comm.Parameters.AddWithValue("medID", medID);
                comm.Parameters.AddWithValue("stockID", stock);


                int q = 0;

                using (SqlDataReader reader = comm.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        q = Convert.ToInt32(reader.GetInt32(0).ToString());
                    }
                }

                string updateStock = "update stock set qty_on_hand = @qty where stock_id = @stockID and med_id = @medID";
                SqlCommand command= new SqlCommand(updateStock, con);
                command.Parameters.AddWithValue("qty", q + qtyy);
                command.Parameters.AddWithValue("stockID", stock);
                command.Parameters.AddWithValue("medID", medID);

                command.ExecuteNonQuery();



                string deletePresc = "delete from prescription_stock where presc_id = @prescID and cust_id = @custID and stock_id = @stockID and med_id = @medID";
                SqlCommand comm3 = new SqlCommand(deletePresc, con);
                comm3.Parameters.AddWithValue("prescID", prescc);
                comm3.Parameters.AddWithValue("custID", cus);
                comm3.Parameters.AddWithValue("stockID", stock);
                comm3.Parameters.AddWithValue("medID", medID);

                comm3.ExecuteNonQuery();

                Response.Write("<script>alert('Removed succesfully')</script>");

                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT P.PRESC_ID, PS.CUST_ID, M.MED_ID, M.MED_NAME, PS.STOCK_ID, PS.QTY_PRESC, M.PRICE, M.PRICE * PS.QTY_PRESC AS TOTAL, M.MED_IMAGE FROM PRESCRIPTION P, PRESCRIPTION_STOCK PS, MEDICINE M WHERE P.PRESC_ID = PS.PRESC_ID AND PS.MED_ID = M.MED_ID AND P.STATUS = 'UNPAID' AND P.PRESC_ID = " + TextBox1.Text, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvUPresc.DataSource = dtbl;
                gvUPresc.DataBind();

                SqlDataAdapter sqlDa2 = new SqlDataAdapter("SELECT SUM(PRICE * QTY_PRESC) AS TOTAL FROM MEDICINE M, PRESCRIPTION P, PRESCRIPTION_STOCK PS WHERE M.MED_ID = PS.MED_ID AND P.PRESC_ID = PS.PRESC_ID AND P.STATUS = 'UNPAID' AND PS.Presc_ID = " + TextBox1.Text, con);
                DataTable dtbl3 = new DataTable();
                sqlDa2.Fill(dtbl3);
                gvTotal.DataSource = dtbl3;
                gvTotal.DataBind();
            }
        }


        //Paid button
        protected void Button2_Click(object sender, EventArgs e)
        {
            


            if (TextBox1.Text != "")
            {
                string s = "SELECT SUM(PRICE * QTY_PRESC) AS TOTAL FROM MEDICINE M, PRESCRIPTION P, PRESCRIPTION_STOCK PS WHERE M.MED_ID = PS.MED_ID AND P.PRESC_ID = PS.PRESC_ID AND P.STATUS = 'UNPAID' AND PS.Presc_ID = " + TextBox1.Text;
                SqlCommand sq = new SqlCommand(s, con);

                double q = 0;

                using (SqlDataReader reader = sq.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        //To correct paid button (check values in the table befroe uploading)
                        if (reader[0] != DBNull.Value)
                        {
                            q = 1;
                        }
                    }
                }


                if (q != 0)
                {
                    DateTime date = DateTime.Now;

                    string updatePrescPaid = "update prescription set status = 'PAID' where presc_id = " + TextBox1.Text;
                    SqlCommand comm4 = new SqlCommand(updatePrescPaid, con);
                    comm4.ExecuteNonQuery();

                    decimal tot = 0;

                    foreach (GridViewRow row in gvTotal.Rows)
                    {
                        tot = Convert.ToDecimal(row.Cells[0].Text);
                    }

                    String insertPrescPayment = "insert into payment values(@date, @total, @prescID, NULL)";
                    SqlCommand sqc = new SqlCommand(insertPrescPayment, con);
                    sqc.Parameters.AddWithValue("@date", date);
                    sqc.Parameters.AddWithValue("@total", tot);
                    sqc.Parameters.AddWithValue("@prescID", TextBox1.Text);

                    sqc.ExecuteNonQuery();

                    Response.Write("<script>alert('Prescription paid succesfully')</script>");

                    SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT P.PRESC_ID, PS.CUST_ID, M.MED_ID, M.MED_NAME, PS.STOCK_ID, PS.QTY_PRESC, M.PRICE, M.PRICE * PS.QTY_PRESC AS TOTAL, M.MED_IMAGE FROM PRESCRIPTION P, PRESCRIPTION_STOCK PS, MEDICINE M WHERE P.PRESC_ID = PS.PRESC_ID AND PS.MED_ID = M.MED_ID AND P.STATUS = 'UNPAID' AND P.PRESC_ID = " + TextBox1.Text, con);
                    DataTable dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    gvUPresc.DataSource = dtbl;
                    gvUPresc.DataBind();

                    SqlDataAdapter sqlDa2 = new SqlDataAdapter("SELECT SUM(PRICE * QTY_PRESC) AS TOTAL FROM MEDICINE M, PRESCRIPTION P, PRESCRIPTION_STOCK PS WHERE M.MED_ID = PS.MED_ID AND P.PRESC_ID = PS.PRESC_ID AND P.STATUS = 'UNPAID' AND PS.Presc_ID = " + TextBox1.Text, con);
                    DataTable dtbl3 = new DataTable();
                    sqlDa2.Fill(dtbl3);
                    gvTotal.DataSource = dtbl3;
                    gvTotal.DataBind();
                }
                else {
                    Response.Write("<script>alert('Prescription cannot be paid because there are no item(s) for it')</script>");
                }
                
            }

            else {
                Response.Write("<script>alert('Prescription must be searched first')</script>");
            }
            
        }
    }
}