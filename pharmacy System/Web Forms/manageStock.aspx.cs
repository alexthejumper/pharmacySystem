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
    public partial class manageStock : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True";
            con.Open();

            GridView1.DataBind();
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            GridView1.DataBind();
        }


        protected void uploadButton_Click(object sender, EventArgs e)
        {
                string stkID = stockID.Text;
                string desc = stockDesc.Text;
                string qty = stockQty.Text;
                string med = medID.Text;

                SqlCommand cmd2 = new SqlCommand("insert into stock values(@stkID, @stkDesc, @stkQty, @medID)", con);

                cmd2.Parameters.AddWithValue("@stkID", stkID);
                cmd2.Parameters.AddWithValue("@stkDesc", desc);
                cmd2.Parameters.AddWithValue("@stkQty", qty);
                cmd2.Parameters.AddWithValue("@medID", med);
                cmd2.ExecuteNonQuery();

                Response.Write("<script>alert('Stock added successfully !')</script>");

                GridView1.DataBind();

            stockID.Text = "";
            stockDesc.Text = "";
            stockQty.Text = "";
            medID.Text = "";

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string query = "SELECT * FROM STOCK WHERE STOCK_ID = @stkID";
            SqlCommand comm = new SqlCommand(query, con);
            comm.Parameters.AddWithValue("stkID", stockID.Text);

            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    stockID.Text = reader.GetString(0);
                    stockDesc.Text = reader.GetString(1);
                    stockQty.Text = reader.GetInt32(2).ToString();
                    medID.Text = reader.GetInt32(3).ToString();
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string query = "UPDATE STOCK SET STOCK_ID = @s_ID, STOCK_DESC = @s_desc, QTY_ON_HAND = @s_qty, MED_ID = @m_id WHERE STOCK_ID = @s_ID";
            SqlCommand comm = new SqlCommand(query, con);
            comm.Parameters.AddWithValue("s_ID", stockID.Text);
            comm.Parameters.AddWithValue("s_desc", stockDesc.Text);
            comm.Parameters.AddWithValue("s_qty", stockQty.Text);
            comm.Parameters.AddWithValue("m_id", medID.Text);

            comm.ExecuteNonQuery();

            Response.Write("<script>alert('Stock updated successfully !')</script>");

            GridView1.DataBind();
        }
    }

}