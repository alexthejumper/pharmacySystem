using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace pharmacy_System.Web_Forms
{
    public partial class requestAppointment : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();

        String mail;
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True;MultipleActiveResultSets=true;";
            con.Open();

            String searchDocType = "select DC.Doc_Cat_ID, DC.Category_Name, D.Doc_Surname, D.Doc_Fname from DOCTOR D, DOC_CATEGORY DC where D.DOC_ID = DC.DOC_ID";
            SqlDataAdapter sqlDa = new SqlDataAdapter(searchDocType, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvDoctorTypes.DataSource = dtbl;
            gvDoctorTypes.DataBind();
        }

        protected void gvDoctorTypes_SelectedIndexChanged(object sender, EventArgs e)
        {
            String docSurname = gvDoctorTypes.SelectedRow.Cells[2].Text;
            String docFname = gvDoctorTypes.SelectedRow.Cells[3].Text;

            String searchDoctor = "select doc_id, doc_email from doctor where doc_surname = @docS and doc_fname = @docF";

            SqlCommand comm = new SqlCommand(searchDoctor, con);
            comm.Parameters.AddWithValue("docS", docSurname);
            comm.Parameters.AddWithValue("docF", docFname);


            int d = 0;

            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    d = reader.GetInt32(0);
                    mail = reader.GetString(1);
                }
            }

            TextBox1.Text = docSurname;
            TextBox2.Text = docFname;
            TextBox3.Text = mail;

            string searchWorks = "SELECT WORKING_DAYS, WORKING_HOURS FROM DOC_HOURS WHERE DOC_ID = " + d;
            SqlDataAdapter sqlDa = new SqlDataAdapter(searchWorks, con);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            gvDoctorWorks.DataSource = dtbl;
            gvDoctorWorks.DataBind();
        }


        //SENDING REQUEST TO DOCTOR VIA EMAIL
        protected void Button1_Click(object sender, EventArgs e)
        {
            String searchCustomerID = "select C.cust_email, C.cust_surname, C.cust_fname from customer C, account A where C.ACC_ID = A.ACC_ID and acc_username = @user";
            SqlCommand comm = new SqlCommand(searchCustomerID, con);
            comm.Parameters.AddWithValue("user", Session["username"]);

            String d = "", surname = "", fname = "";


            using (SqlDataReader reader = comm.ExecuteReader())
            {
                while (reader.Read())
                {
                    d = reader.GetString(0);
                    surname = reader.GetString(1);
                    fname = reader.GetString(2);
                }
            }

            if (!d.Equals(""))
            {
                MailMessage mm = new MailMessage("alexaguero997@gmail.com", TextBox3.Text.Trim());
                mm.Subject = "Appointment Request";
                mm.Body = string.Format("<p>Hello Dr {0} {1},</p> <p>my name is {2} {3} and I would like to request an appointment with you. Send me your answer on my email: {4} </p><br> <p>Regards,</p><p>{5} {6}</p>", TextBox1.Text, TextBox2.Text, surname, fname, d, surname, fname);
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential nc = new NetworkCredential();
                nc.UserName = "alexaguero997@gmail.com";
                nc.Password = "xefzenbazyltsprl";
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = nc;
                smtp.Port = 587;
                smtp.Send(mm);

                Response.Write("<script>alert('Request sent to Doctor')</script>");

            }
            else {
                Response.Write("<script>alert('Cannot send request because no email was found')</script>");
            }
        }
    }
}