using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Drawing;

namespace pharmacy_System.Web_Forms
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True";
            con.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) {
                SqlCommand cmd = new SqlCommand("SELECT CUST_SURNAME, CUST_EMAIL, ACC_PASSWORD FROM CUSTOMER C, ACCOUNT A WHERE C.ACC_ID = A.ACC_ID AND CUST_EMAIL = @email", con);
                cmd.Parameters.AddWithValue("@email", TextBox1.Text);
                SqlDataReader dr = cmd.ExecuteReader();

                String password;
                String surname;
                String email;

                if (dr.Read())
                {
                    password = (string)dr["ACC_PASSWORD"];
                    surname = (string)dr["CUST_SURNAME"];
                    email = (string)dr["CUST_EMAIL"];

                    MailMessage mm = new MailMessage("alexaguero997@gmail.com", TextBox1.Text.Trim());
                    mm.Subject = "Pharmacy Account Password";
                    mm.Body = string.Format("<h1>Hello {0}</h1> <br> <h1>{1}</h1> is your Email Address <br><br> Your password is <h1>{2}</h1>", surname, email, password);
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

                    Label2.Text = "Password has been sent to " + email + ". Please check your mail";
                    Label2.ForeColor = Color.Green;
                }

                else {
                    dr.Close();

                    SqlCommand cmd2 = new SqlCommand("SELECT DOC_SURNAME, DOC_EMAIL, ACC_PASSWORD FROM DOCTOR D, ACCOUNT A WHERE D.ACC_ID = A.ACC_ID AND DOC_EMAIL = @email", con);
                    cmd2.Parameters.AddWithValue("@email", TextBox1.Text.Trim());
                    SqlDataReader dr2 = cmd2.ExecuteReader();

                    if (dr2.Read())
                    {
                        password = (string)dr2["ACC_PASSWORD"];
                        surname = (string)dr2["DOC_SURNAME"];
                        email = (string)dr2["DOC_EMAIL"];

                        MailMessage mm = new MailMessage("alexaguero997@gmail.com", TextBox1.Text.Trim());
                        mm.Subject = "Pharmacy Account Password";
                        mm.Body = string.Format("<h1>Hello {0}</h1> <br> <h1>{1}</h1> is your Email Address <br><br> Your password is <h1>{2}</h1>", surname, email, password);
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

                        Label2.Text = "Password has been sent to " + email + ". Please check your mail";
                        Label2.ForeColor = Color.Green;
                    }

                    else {

                        dr2.Close();

                        SqlCommand cmd3 = new SqlCommand("SELECT PHAR_SURNAME, PHAR_EMAIL, ACC_PASSWORD FROM PHARMACIST P, ACCOUNT A WHERE P.ACC_ID = A.ACC_ID AND PHAR_EMAIL = @email", con);
                        cmd3.Parameters.AddWithValue("@email", TextBox1.Text.Trim());
                        SqlDataReader dr3 = cmd3.ExecuteReader();

                        if (dr3.Read())
                        {
                            password = (string) dr3 ["ACC_PASSWORD"];
                            surname = (string) dr3 ["PHAR_SURNAME"];
                            email = (string) dr3 ["PHAR_EMAIL"];

                            MailMessage mm = new MailMessage("alexaguero997@gmail.com", TextBox1.Text.Trim());
                            mm.Subject = "Pharmacy Account Password";
                            mm.Body = string.Format("<h1>Hello {0}</h1> <br> <h1>{1}</h1> is your Email Address <br><br> Your password is <h1>{2}</h1>", surname, email, password);
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

                            Label2.Text = "Password has been sent to " + email + ". Please check your mail";
                            Label2.ForeColor = Color.Green;

                            dr3.Close();
                        }
                        else {
                            Label2.Text = "Email does not exist in database. Please re enter email";
                            Label2.ForeColor = Color.Red;
                        }
                    }
                }

            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}