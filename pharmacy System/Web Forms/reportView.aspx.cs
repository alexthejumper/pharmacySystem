using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace pharmacy_System.Web_Forms
{
    public partial class reportView : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();

            String searchCustomer = "select * from customer c, account a where c.acc_id = a.acc_id and acc_username =  @user";
            SqlCommand comm3 = new SqlCommand(searchCustomer, con);
            comm3.Parameters.AddWithValue("user", Session["username"]);

            int d = 0;

            String surname = "", fname = "", street = "", town = "";

            using (SqlDataReader reader = comm3.ExecuteReader())
            {
                while (reader.Read())
                {
                    d = reader.GetInt32(0);
                    surname = reader.GetString(1);
                    fname = reader.GetString(2);
                    street = reader.GetString(4);
                    town = reader.GetString(5);
                }
            }

            DateTime date= DateTime.Now;
            Label1.Text = surname;
            Label2.Text = fname;
            Label3.Text = street;
            Label4.Text = town;
            Label5.Text = date.ToString();
            Label6.Text = d.ToString();

            String selectPay = "select p_id, p_date, p_amount, p_category, reference_id from temp_payment";
            SqlDataAdapter sqlDa2 = new SqlDataAdapter(selectPay, con);
            DataTable dtbl2 = new DataTable();
            sqlDa2.Fill(dtbl2);
            gvViewPayments2.DataSource = dtbl2;
            gvViewPayments2.DataBind();

            gvViewPayments2.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            using (StringWriter sw = new StringWriter())
            
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    this.Page.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                    pdfDoc.Close();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=file.pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }

            
        }
    }
}