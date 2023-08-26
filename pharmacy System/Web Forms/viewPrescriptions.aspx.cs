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
    public partial class viewPrescriptions : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null) {
                con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
                con.Open();

                String searchCustomer = "SELECT CUST_ID FROM CUSTOMER C, ACCOUNT A WHERE A.ACC_ID = C.ACC_ID AND ACC_USERNAME = @user";
                SqlCommand comm = new SqlCommand(searchCustomer, con);
                comm.Parameters.AddWithValue("user", Session["username"]);


                int d = 0;

                using (SqlDataReader reader = comm.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        d = reader.GetInt32(0);
                    }
                }

                string searchPresc = "SELECT PRESC_ID, PRESC_DATE, DISEASE_COMMENTS, DOCTOR_COMMENTS FROM PRESCRIPTION WHERE CUST_ID = " + d;
                SqlDataAdapter sqlDa = new SqlDataAdapter(searchPresc, con);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);
                gvYpresc.DataSource = dtbl;
                gvYpresc.DataBind();
            }
        }

        protected void gvYpresc_SelectedIndexChanged(object sender, EventArgs e)
        {
            int presc_id = Convert.ToInt32(gvYpresc.SelectedRow.Cells[0].Text);

            string searchStockPresc = "SELECT M.MED_NAME, STOCK_ID, QTY_PRESC FROM PRESCRIPTION_STOCK PS, MEDICINE M WHERE PS.MED_ID = M.MED_ID AND PRESC_ID = " + presc_id;
            SqlDataAdapter sqlDa = new SqlDataAdapter(searchStockPresc, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvPorders.DataSource = dtbl;
            gvPorders.DataBind();
        }
    }
    }