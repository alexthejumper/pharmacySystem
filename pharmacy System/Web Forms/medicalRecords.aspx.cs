using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace pharmacy_System.Web_Forms
{
    public partial class medicalRecords : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();
        }

        //Search medical record for mentionned customer
        protected void Button1_Click(object sender, EventArgs e)
        {
            string queryCustomer = "SELECT * FROM CUSTOMER WHERE CUST_NIC = '" + TextBox1.Text + "'";
            SqlCommand comm = new SqlCommand(queryCustomer, con);

            int c = 0;

            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    ++c;
                }
            }

            if (c != 0) {
                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT C.CUST_ID, P.DISEASE_COMMENTS, P.PRESC_DATE, P.PRESC_ID FROM PRESCRIPTION P, CUSTOMER C WHERE P.CUST_ID = C.CUST_ID AND CUST_NIC = '" + TextBox1.Text + "'", con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvMedical.DataSource = dtbl;
                gvMedical.DataBind();
            }
            else
            {
                Response.Write("<script>alert('Customer not found. Please re enter NIC')</script>");
            }
            
        }
    }
}