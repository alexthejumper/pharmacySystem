<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="viewPayments.aspx.cs" Inherits="pharmacy_System.Web_Forms.viewPayments" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .reportButton {
            border-radius: 5px;
            background: #10455b;
            color: white;
            text-decoration: none;
            padding: 0.5%;
        }

        .reportButton:hover {
            background: white;
            color: lightseagreen;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <div>
            <asp:Label ID="Label1" runat="server" Text="Payments List" Font-Size="X-Large" ForeColor="White"></asp:Label>
        </div>

        <br />

        <div class="row">
            <asp:GridView ID="gvViewPayments" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="P_Id" HeaderText="Payment ID"/>
                     <asp:BoundField DataField="P_Date" HeaderText="Payment Date"/>
                     <asp:BoundField DataField="P_AMOUNT" HeaderText="Amount"/>
                    <asp:BoundField DataField="P_CATEGORY" HeaderText="Category"/>
                     <asp:BoundField DataField="REFERENCE_ID" HeaderText="Transaction Reference"/>
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
        <div style="margin-bottom: 5%;">
            <asp:Button ID="Button1" runat="server" Text="View Report" CssClass="reportButton" OnClick="Button1_Click" OnClientClick="target ='_blank';" BorderColor="#10455B" BorderStyle="None"/>
        </div>
        </div>
</asp:Content>
