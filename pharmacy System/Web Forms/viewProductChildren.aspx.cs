using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
    public partial class viewProducts : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();

            String searchMed = "select Med_ID, Med_Name, Med_Description, Price, Medicine_Reaction, Permissible_Dose, Med_Image from medicine where med_category = 'CHILDREN'";
            SqlDataAdapter sqlDa = new SqlDataAdapter(searchMed, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvChildProducts.DataSource = dtbl;
            gvChildProducts.DataBind();
        }
    }
}