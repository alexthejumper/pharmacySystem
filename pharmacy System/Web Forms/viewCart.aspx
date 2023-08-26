<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="viewCart.aspx.cs" Inherits="pharmacy_System.Web_Forms.cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cartButtons {
            border-radius: 5px;
            background: #10455b;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .cartButtons:hover {
            background: white;
            color: lightseagreen;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div>
                <br />
                <asp:Label ID="Label1" runat="server" Text="Cart" Font-Bold="True" Font-Size="XX-Large"></asp:Label>
                <br />
            </div>

            <div>
            <asp:GridView ID="gvOnlineOrders" runat="server" CssClass="dt-responsive table table-striped table-bordered" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="gvOnlineOrders_RowCommand" OnRowDeleting="gvOnlineOrders_RowDeleting">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Order_ID" HeaderText="Order ID">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MED_ID" HeaderText="Medicine ID">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MED_NAME" HeaderText="Name">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="QTY_STOCK" HeaderText="Stock Quantity">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Price" HeaderText="Price">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="QTY_ORDERED" HeaderText="Quantity Ordered">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ITEM_TOTAL" HeaderText="Total">
                    <HeaderStyle ForeColor="White" />
                    </asp:BoundField>
                    <asp:ButtonField CommandName="increase" Text="Increase" />
                    <asp:ButtonField CommandName="decrease" Text="Decrease" />
                    <asp:CommandField ShowDeleteButton="True" />
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
                <div>
                    <asp:GridView ID="gvTotal" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="GrandTotal" HeaderText="Overall Total"/>
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
        </div>
                <asp:Button ID="Button1" runat="server" CssClass="cartButtons" OnClick="Button1_Click" Text="Continue Shopping" BorderStyle="None" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button2" runat="server" CssClass="cartButtons" OnClick="Button2_Click" Text="Go to Check Out" BorderStyle="None" />
        </div>
        </div>
    </div>
</asp:Content>
