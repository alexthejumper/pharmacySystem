<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="requestAppointment.aspx.cs" Inherits="pharmacy_System.Web_Forms.requestAppointment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function () {
            $(".docType").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">
        
    <style>
        .requestAppointmentButton {
            border-radius: 5px;
            background: #20b2aa;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .requestAppointmentButton:hover {
            background: white;
            color: lightseagreen;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div style="margin-top: 50px;">
                 <asp:Label ID="Label1" runat="server" Text="Doctors List" Font-Size="XX-Large" ForeColor="Black"></asp:Label>
            </div>
           
            <div style="background-color: white; margin-top: 20px; margin-bottom: 50px; padding: 20px; border-radius: 5px;">
                 <asp:GridView ID="gvDoctorTypes" runat="server" CssClass="docType" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvDoctorTypes_SelectedIndexChanged">
                     <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Doc_Cat_ID" HeaderText="Doctor Category ID"/>
                        <asp:BoundField DataField="Category_Name" HeaderText="Category"/>
                        <asp:BoundField DataField="Doc_Surname" HeaderText="Doctor Surname"/>
                        <asp:BoundField DataField="Doc_Fname" HeaderText="Doctor First Name"/>
                        <asp:CommandField ShowSelectButton="True" />
                    </Columns>
                     <EditRowStyle BackColor="#7C6F57" />
                     <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                     <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                     <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                     <RowStyle BackColor="#E3EAEB" />
                     <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                     <SortedAscendingCellStyle BackColor="#F8FAFA" />
                     <SortedAscendingHeaderStyle BackColor="#246B61" />
                     <SortedDescendingCellStyle BackColor="#D4DFE1" />
                     <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
            </div>

            <br />
            <br />

            <asp:Label ID="Label2" runat="server" Text="Working Days & Working Hours" Font-Size="Large" ForeColor="Black" Font-Bold="True"></asp:Label>
            <div style="margin-top: 20px;">
                <asp:GridView ID="gvDoctorWorks" runat="server" CssClass="dt-responsive table table-striped table-bordered" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                <Columns>
                    <asp:BoundField DataField="WORKING_DAYS" HeaderText="Working Days">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="WORKING_HOURS" HeaderText="Working Hours">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
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

            <br />
            <br />
            <div style="background-color: #10455b; margin-bottom: 40px; border-radius: 5px;">
            <div style="margin-bottom: 30px; margin-top: 30px;">
                <asp:Label ID="Label3" runat="server" Text="Doctor Surname" Width="224px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" ReadOnly="True"></asp:TextBox>
                <br />
            </div>

            <div style="margin-bottom: 30px;">
                <asp:Label ID="Label4" runat="server" Text="Doctor First Name" Width="224px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" ReadOnly="True"></asp:TextBox>
                <br />
            </div>

            <div style="margin-bottom: 30px;">
                <asp:Label ID="Label5" runat="server" Text="Doctor Email" Width="224px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" ReadOnly="True"></asp:TextBox>
                <br />
            </div>

            <div style="margin-bottom: 60px;">
                <asp:Button ID="Button1" runat="server" CssClass="requestAppointmentButton" Text="Request Appointment" OnClick="Button1_Click" BorderStyle="None" />
            </div>

            </div>
            
        </div>
    </div>
</asp:Content>
