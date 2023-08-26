using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
    public partial class doctorDetails : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        int d = 0, f = 0, index = 0;

        String hoursWork, daysWork;
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();

            if (!IsPostBack) { 
            String searchAccount = "SELECT ACC_ID FROM ACCOUNT WHERE ACC_USERNAME = @user";
            SqlCommand comm = new SqlCommand(searchAccount, con);
            comm.Parameters.AddWithValue("user", Session["username"]);


            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    d = reader.GetInt32(0);
                }
            }

            String searchDoctor = "SELECT * FROM DOCTOR WHERE ACC_ID = @ID";
            SqlCommand comm2 = new SqlCommand(searchDoctor, con);
            comm2.Parameters.AddWithValue("ID", d);


            using (SqlDataReader reader = comm2.ExecuteReader())
            {
                while (reader.Read())
                {
                    f = reader.GetInt32(0);
                    Session["id"] = f;
                    TextBox4.Text = reader.GetString(1);
                    TextBox5.Text = reader.GetString(2);
                    TextBox6.Text = reader.GetString(4);
                    TextBox7.Text = reader.GetString(5);
                    TextBox8.Text = reader.GetInt32(6).ToString();
                    TextBox9.Text = reader.GetString(7);
                }
            }

            string searchCatDoc = "SELECT DOC_CAT_ID, CATEGORY_NAME FROM DOC_CATEGORY WHERE DOC_ID = " + f;
            SqlDataAdapter sqlDa = new SqlDataAdapter(searchCatDoc, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvCatDoc.DataSource = dtbl;
            gvCatDoc.DataBind();

            string searchWork = "SELECT WORKING_DAYS, WORKING_HOURS FROM DOC_HOURS WHERE DOC_ID = " + f;
            SqlDataAdapter sqlDa2 = new SqlDataAdapter(searchWork, con);
            DataTable dtbl2 = new DataTable();
            sqlDa2.Fill(dtbl2);
            gvWork.DataSource = dtbl2;
            gvWork.DataBind();
            }
        }

        //SAVE NEW DOCTOR CATEGORY
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!TextBox1.Text.Equals(""))
            {
                String insertCat = "insert into doc_category values(@catName,@id)";
                SqlCommand comm3 = new SqlCommand(insertCat, con);

                comm3.Parameters.AddWithValue("catName", TextBox1.Text);
                comm3.Parameters.AddWithValue("id", Session["id"]);

                comm3.ExecuteNonQuery();

                Response.Write("<script>alert('Doctor Category Saved')</script>");

                string searchCatDoc = "SELECT DOC_CAT_ID, CATEGORY_NAME FROM DOC_CATEGORY WHERE DOC_ID = " + Session["id"];
                SqlDataAdapter sqlDa = new SqlDataAdapter(searchCatDoc, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvCatDoc.DataSource = dtbl;
                gvCatDoc.DataBind();
            }
            else {
                Response.Write("<script>alert('Category text box must not be left null')</script>");
            }
        }


        //DELETE DOCTOR CATEGORY
        protected void Button3_Click(object sender, EventArgs e)
        {
            String deleteCat = "delete from doc_category where category_name = @docCatName and doc_id = @docID";
            SqlCommand comm3 = new SqlCommand(deleteCat, con);

            comm3.Parameters.AddWithValue("docCatName", TextBox1.Text);
            comm3.Parameters.AddWithValue("docID", Session["id"]);

            comm3.ExecuteNonQuery();

            Response.Write("<script>alert('Doctor Category Deleted')</script>");

            TextBox1.Text = "";

            string searchCatDoc = "SELECT DOC_CAT_ID, CATEGORY_NAME FROM DOC_CATEGORY WHERE DOC_ID = " + Session["id"];
            SqlDataAdapter sqlDa = new SqlDataAdapter(searchCatDoc, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvCatDoc.DataSource = dtbl;
            gvCatDoc.DataBind();

        }


        //SAVING WORK DAYS AND WORK HOURS
        protected void Button4_Click(object sender, EventArgs e)
        {
            if (TextBox2.Text.Equals("") || TextBox3.Text.Equals("")) {
                Response.Write("<script>alert('No field shoud not be left empty')</script>");
            }
            else {
                String insertWorkDetails = "insert into doc_hours values(@days, @hours, @docID)";
                SqlCommand comm = new SqlCommand(insertWorkDetails, con);

                comm.Parameters.AddWithValue("days", TextBox2.Text);
                comm.Parameters.AddWithValue("hours", TextBox3.Text);
                comm.Parameters.AddWithValue("docID", Session["id"]);

                comm.ExecuteNonQuery();

                Response.Write("<script>alert('Work Details Inserted')</script>");

                string searchWork = "SELECT WORKING_DAYS, WORKING_HOURS FROM DOC_HOURS WHERE DOC_ID = " + Session["id"];
                SqlDataAdapter sqlDa = new SqlDataAdapter(searchWork, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvWork.DataSource = dtbl;
                gvWork.DataBind();

                TextBox2.Text = "";
                TextBox3.Text = "";
            }
            
        }

        //UPDATE WORK DAYS AND WORK HOURS
        protected void Button5_Click(object sender, EventArgs e)

        {
            String updateWork = "update doc_hours set working_days = @days, working_hours = @hours where working_days = @days2 and working_hours = @hours2 and doc_id = @docID";

            SqlCommand comm = new SqlCommand(updateWork, con);

            comm.Parameters.AddWithValue("days", TextBox2.Text);
            comm.Parameters.AddWithValue("hours", TextBox3.Text);
            comm.Parameters.AddWithValue("days2", Session["daysWork"]);
            comm.Parameters.AddWithValue("hours2", Session["hoursWork"]);
            comm.Parameters.AddWithValue("docID", Session["id"]);

            comm.ExecuteNonQuery();

            Response.Write("<script>alert('Work Details updated')</script>");

            string searchWork = "SELECT WORKING_DAYS, WORKING_HOURS FROM DOC_HOURS WHERE DOC_ID = " + Session["id"];
            SqlDataAdapter sqlDa = new SqlDataAdapter(searchWork, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvWork.DataSource = dtbl;
            gvWork.DataBind();

            TextBox2.Text = "";
            TextBox3.Text = "";
        }


        //DELETE WORK DAYS AND WORK HOURS
        protected void Button6_Click(object sender, EventArgs e)
        {
            String deleteWork = "delete from doc_hours where working_days = @days and working_hours = @hours and doc_id = @docID";

            SqlCommand comm = new SqlCommand(deleteWork, con);

            comm.Parameters.AddWithValue("days", Session["daysWork"]);
            comm.Parameters.AddWithValue("hours", Session["hoursWork"]);
            comm.Parameters.AddWithValue("docID", Session["id"]);

            comm.ExecuteNonQuery();

            Response.Write("<script>alert('Work Details deleted')</script>");

            string searchWork = "SELECT WORKING_DAYS, WORKING_HOURS FROM DOC_HOURS WHERE DOC_ID = " + Session["id"];
            SqlDataAdapter sqlDa = new SqlDataAdapter(searchWork, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvWork.DataSource = dtbl;
            gvWork.DataBind();

            TextBox2.Text = "";
            TextBox3.Text = "";
        }


        //UPDATING DOCTOR DETAILS
        protected void Button7_Click(object sender, EventArgs e)
        {
            string updateCustomer = "update doctor set doc_surname = @surname, doc_fname = @fname, doc_street = @street, doc_town = @town, doc_mobile = @mobile, doc_email = @email where doc_id = @id";
            SqlCommand comm3 = new SqlCommand(updateCustomer, con);
            comm3.Parameters.AddWithValue("surname", TextBox4.Text);
            comm3.Parameters.AddWithValue("fname", TextBox5.Text);
            comm3.Parameters.AddWithValue("street", TextBox6.Text);
            comm3.Parameters.AddWithValue("town", TextBox7.Text);
            comm3.Parameters.AddWithValue("mobile", TextBox8.Text);
            comm3.Parameters.AddWithValue("email", TextBox9.Text);
            comm3.Parameters.AddWithValue("id", Session["id"]);

            comm3.ExecuteNonQuery();

            Response.Write("<script>alert('Your Profile has been updated successfully')</script>");
        }

        protected void gvWork_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["daysWork"] = gvWork.SelectedRow.Cells[0].Text;
            Session["hoursWork"] = gvWork.SelectedRow.Cells[1].Text;
            TextBox2.Text = gvWork.SelectedRow.Cells[0].Text;
            TextBox3.Text = gvWork.SelectedRow.Cells[1].Text;
        }

        protected void gvCatDoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            index = Convert.ToInt32(gvCatDoc.SelectedRow.Cells[0].Text);
            Session["docCatID"] = index;
            TextBox1.Text = gvCatDoc.SelectedRow.Cells[1].Text;
        }


        //UPDATE DOCTOR CATEGORY
        protected void Button2_Click(object sender, EventArgs e)
        {
            if (!TextBox1.Text.Equals(""))
            {
                String updateCat = "update doc_category set category_name = @catName where doc_id = @docID and doc_cat_id = @docCid";
                SqlCommand comm3 = new SqlCommand(updateCat, con);

                comm3.Parameters.AddWithValue("catName", TextBox1.Text);
                comm3.Parameters.AddWithValue("docID", Session["id"]);
                comm3.Parameters.AddWithValue("docCid", Session["docCatID"]);

                comm3.ExecuteNonQuery();

                Response.Write("<script>alert('Doctor Category Updated')</script>");

                string searchCatDoc = "SELECT DOC_CAT_ID, CATEGORY_NAME FROM DOC_CATEGORY WHERE DOC_ID = " + Session["id"];
                SqlDataAdapter sqlDa = new SqlDataAdapter(searchCatDoc, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvCatDoc.DataSource = dtbl;
                gvCatDoc.DataBind();
            }
            else
            {
                Response.Write("<script>alert('Category text box must not be left null')</script>");
            }
        }
    }
}