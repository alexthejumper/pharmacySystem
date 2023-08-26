<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Pharmacist.Master" AutoEventWireup="true" CodeBehind="medicalRecordsPharmacist.aspx.cs" Inherits="pharmacy_System.Web_Forms.medicalRecordsPharmacist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

    <script>
        $(document).ready(function () {
            $(".medical").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <style>
        .searchMedical {
            border-radius: 5px;
            background: lightseagreen;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .searchMedical:hover {
            background: white;
            color: lightseagreen;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <br />
        <div class="row">
            <asp:Label ID="Label2" runat="server" Text="View Medical Records for a Customer" Font-Size="XX-Large"></asp:Label>
            <div style="background-color: #10455b; max-width: 70%; width: 100%; padding: 30px; margin-bottom: 50px;">
                <asp:Label ID="Label1" Width="240px" runat="server" Text="Enter Customer NIC" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" CssClass="searchMedical" Text="Search Medical Records" OnClick="Button1_Click" BorderStyle="None" />
            </div>

            <br />
            <div style="background: white; border-radius: 10px; padding: 10px; margin-bottom: 20px;">
            <asp:GridView ID="gvMedical" CssClass="medical" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                <Columns>
                    <asp:BoundField DataField="Cust_ID" HeaderText="Customer ID"/>
                    <asp:BoundField DataField="Disease_Comments" HeaderText="Disease Comments"/>
                    <asp:BoundField DataField="Presc_Date" HeaderText="Date of Prescription"/>
                    <asp:BoundField DataField="Presc_ID" HeaderText="Prescription ID"/>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#333333" />
                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#487575" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#275353" />
            </asp:GridView>
        </div>
        </div>
    </div>
</asp:Content>
