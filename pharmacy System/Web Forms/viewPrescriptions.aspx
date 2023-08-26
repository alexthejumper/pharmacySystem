<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="viewPrescriptions.aspx.cs" Inherits="pharmacy_System.Web_Forms.viewPrescriptions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function () {
            $(".yourPresc").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="margin-top: 70px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label1" runat="server" Text="Your Prescriptions" Font-Size="XX-Large"></asp:Label></div>
    

    <div class="container">
        <div class="row">
            <div style="background: white; border-radius: 10px; padding: 10px; margin-bottom: 50px;">
            <asp:GridView ID="gvYpresc" CssClass="yourPresc" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvYpresc_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Presc_ID" HeaderText="Prescription ID"/>
                    <asp:BoundField DataField="Presc_Date" HeaderText="Date"/>
                    <asp:BoundField DataField="Disease_Comments" HeaderText="Disease"/>
                    <asp:BoundField DataField="Doctor_Comments" HeaderText="Doctor Comments"/>
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
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Font-Size="X-Large" Text="Prescription Items"></asp:Label>
                <br />


                <asp:GridView ID="gvPorders" CssClass="stock dt-responsive table table-striped table-bordered" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                <Columns>
                    <asp:BoundField DataField="Med_Name" HeaderText="Medicine Name">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Stock_ID" HeaderText="Stock ID">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Qty_Presc" HeaderText="Quantity">
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
    </div>
    </div>
</asp:Content>
