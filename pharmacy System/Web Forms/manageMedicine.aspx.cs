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
    public partial class manageMedicine : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection();
        string b;
        public string med_ID;
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\ALEXANDRE\\source\\repos\\pharmacy System\\pharmacy System\\App_Data\\OnlinePharmacyDB.mdf\";Integrated Security=True";
            con.Open();

            GridView1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int c = 0;

            if (medNameTB.Text.Trim().Equals(""))
            {
                Label8.Visible = true;
                Label8.Text = "Name cannot be null";
                Label8.BackColor = Color.Red;
                Label8.ForeColor = Color.White;
                ++c;
            }
            else {
                Label8.Text = "";
            }

            if (DropDownList1.SelectedValue == "0")
            {
                Label9.Visible = true;
                Label9.Text = "Category must be selected";
                Label9.BackColor = Color.Red;
                Label9.ForeColor = Color.White;
                ++c;
            }
            else {
                Label9.Text = "";
            }

            if (medDescTB.Text.Trim().Equals(""))
            {
                Label10.Visible = true;
                Label10.Text = "Description must not be null";
                Label10.BackColor = Color.Red;
                Label10.ForeColor = Color.White;
                ++c;
            }
            else {
                Label10.Text = "";
            }

            int d = 0;

            try {
                double pr = Convert.ToDouble(medPriceTB.Text.Trim());

                if (medPriceTB.Text.Trim().Equals("")) {
                    Label11.Visible = true;
                    Label11.Text = "Price is invalid";
                    Label11.BackColor = Color.Red;
                    Label11.ForeColor = Color.White;
                    d = 1;
                    ++c;
                }
            }
            catch (Exception) {
                Label11.Visible = true;
                Label11.Text = "Price is invalid";
                Label11.BackColor = Color.Red;
                Label11.ForeColor = Color.White;
                d = 1;
                ++c;
            }

            if (d == 0) {
                Label11.Text = "";
            }

            if (!FileUpload1.HasFile)
            {
                Label14.Visible = true;
                Label14.Text = "Image needed";
                Label14.BackColor = Color.Red;
                Label14.ForeColor = Color.White;
                ++c;
            }
            else {
                Label14.Text = "";
            }

            if (c == 0) {
                string name = medNameTB.Text;
                string cat = DropDownList1.SelectedValue;
                string desc = medDescTB.Text;
                double price = Convert.ToDouble(medPriceTB.Text);
                string reaction = medReactionTB.Text;
                int dose;

                if (doseTB.Text.Equals("")) {
                    dose = 0;
                }
                else
                {
                    dose = Convert.ToInt32(doseTB.Text);
                }
                

                FileUpload1.SaveAs(Request.PhysicalApplicationPath + "./images2/" + FileUpload1.FileName.ToString());
                b = "~/images2/" + FileUpload1.FileName.ToString();


                SqlCommand cmd2 = new SqlCommand("insert into medicine values(@name, @cat, @desc, @price, @reaction, @dose, @image)", con);

                cmd2.Parameters.AddWithValue("@name", name);
                cmd2.Parameters.AddWithValue("@cat", cat);
                cmd2.Parameters.AddWithValue("@desc", desc);
                cmd2.Parameters.AddWithValue("@price", price);
                cmd2.Parameters.AddWithValue("@reaction", reaction);
                cmd2.Parameters.AddWithValue("@dose", dose);
                cmd2.Parameters.AddWithValue("@image", b.ToString());
                cmd2.ExecuteNonQuery();

                Response.Write("<script>alert('Medicine added successfully !')</script>");
                con.Close();

                medNameTB.Text = "";
                DropDownList1.SelectedValue = "0";
                medDescTB.Text = "";
                medPriceTB.Text = "";
                medReactionTB.Text = "";
                doseTB.Text = "";

                Label8.Visible = false;
                Label9.Visible = false;
                Label10.Visible = false;
                Label11.Visible = false;
                Label12.Visible = false;
                Label13.Visible = false;
                Label14.Visible = false;

                GridView1.DataBind();
            }
                
            }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            med_ID = GridView1.SelectedRow.Cells[0].Text;
            Session["MEDID"] = med_ID;
            medNameTB.Text = GridView1.SelectedRow.Cells[1].Text;
            DropDownList1.SelectedValue = GridView1.SelectedRow.Cells[2].Text;
            medDescTB.Text = GridView1.SelectedRow.Cells[3].Text;
            medPriceTB.Text = GridView1.SelectedRow.Cells[4].Text;
            medReactionTB.Text = GridView1.SelectedRow.Cells[5].Text;
            doseTB.Text = GridView1.SelectedRow.Cells[6].Text;

            Response.Write("<script>alert('" + med_ID + "')</script>");
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            if (!medNameTB.Text.Equals(""))
            {
                string name = medNameTB.Text;
                string cat = DropDownList1.SelectedValue;
                string desc = medDescTB.Text;
                double price = Convert.ToDouble(medPriceTB.Text);
                string reaction = medReactionTB.Text;
                int dose = Convert.ToInt32(doseTB.Text);


                if (FileUpload1.HasFile)
                {
                    FileUpload1.SaveAs(Request.PhysicalApplicationPath + "./images2/" + FileUpload1.FileName.ToString());
                    b = "~/images2/" + FileUpload1.FileName.ToString();

                    SqlCommand cmd2 = new SqlCommand("update medicine set med_name = @name, med_category = @cat, med_description = @desc, price = @price, medicine_reaction = @reaction, permissible_dose = @dose_p, med_image = @image where med_id = " + Session["MEDID"], con);

                    cmd2.Parameters.AddWithValue("@name", name);
                    cmd2.Parameters.AddWithValue("@cat", cat);
                    cmd2.Parameters.AddWithValue("@desc", desc);
                    cmd2.Parameters.AddWithValue("@price", price);
                    cmd2.Parameters.AddWithValue("@reaction", reaction);
                    cmd2.Parameters.AddWithValue("@dose_p", dose);
                    cmd2.Parameters.AddWithValue("@image", b.ToString());
                    cmd2.ExecuteNonQuery();

                    Response.Write("<script>alert('Medicine updated successfully !')</script>");
                    con.Close();

                    medNameTB.Text = "";
                    DropDownList1.SelectedValue = "0";
                    medDescTB.Text = "";
                    medPriceTB.Text = "";
                    medReactionTB.Text = "";
                    doseTB.Text = "";


                    GridView1.DataBind();
                }

                else
                {
                    String update = "update medicine set med_name = @name, med_category = @cat, med_description = @desc, price = @price, medicine_reaction = @reaction, permissible_dose = @dose_p where med_id = @medID";
                    SqlCommand cmd5 = new SqlCommand(update, con);

                    cmd5.Parameters.AddWithValue("@name", name);
                    cmd5.Parameters.AddWithValue("@cat", cat);
                    cmd5.Parameters.AddWithValue("@desc", desc);
                    cmd5.Parameters.AddWithValue("@price", price);
                    cmd5.Parameters.AddWithValue("@reaction", reaction);
                    cmd5.Parameters.AddWithValue("@dose_p", dose);
                    cmd5.Parameters.AddWithValue("@medID", Session["MEDID"]);
                    cmd5.ExecuteNonQuery();


                    Response.Write("<script>alert('Medicine updated successfully !')</script>");
                    con.Close();

                    Label8.Visible = false;
                    Label9.Visible = false;
                    Label10.Visible = false;
                    Label11.Visible = false;
                    Label12.Visible = false;
                    Label13.Visible = false;
                    Label14.Visible = false;

                    medNameTB.Text = "";
                    DropDownList1.SelectedValue = "0";
                    medDescTB.Text = "";
                    medPriceTB.Text = "";
                    medReactionTB.Text = "";
                    doseTB.Text = "";

                    GridView1.DataBind();
                }
            }
            else {
                Response.Write("<script>alert('Cannot update medicine when Medicine is not selected')</script>");
            }
        }
    }
    }