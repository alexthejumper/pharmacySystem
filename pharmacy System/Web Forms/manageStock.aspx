<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Admin.Master" AutoEventWireup="true" CodeBehind="manageStock.aspx.cs" Inherits="pharmacy_System.Web_Forms.manageStock" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

    <script>
        $(document).ready(function () {
            $(".stock").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <style>
        .stockTitle {
            margin-left: 10%;
        }

            .searchButt {
            border-radius: 5px;
            background: #20b2aa;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .searchButt:hover {
            background: white;
            color: lightseagreen;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [STOCK] WHERE [Stock_ID] = @Stock_ID" InsertCommand="INSERT INTO [STOCK] ([Stock_ID], [Stock_Desc], [Qty_On_Hand], [Med_ID]) VALUES (@Stock_ID, @Stock_Desc, @Qty_On_Hand, @Med_ID)" SelectCommand="SELECT * FROM [STOCK]" UpdateCommand="UPDATE [STOCK] SET [Stock_Desc] = @Stock_Desc, [Qty_On_Hand] = @Qty_On_Hand, [Med_ID] = @Med_ID WHERE [Stock_ID] = @Stock_ID">
        <DeleteParameters>
            <asp:Parameter Name="Stock_ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Stock_ID" Type="String" />
            <asp:Parameter Name="Stock_Desc" Type="String" />
            <asp:Parameter Name="Qty_On_Hand" Type="Int32" />
            <asp:Parameter Name="Med_ID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Stock_Desc" Type="String" />
            <asp:Parameter Name="Qty_On_Hand" Type="Int32" />
            <asp:Parameter Name="Med_ID" Type="Int32" />
            <asp:Parameter Name="Stock_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <br />


    <asp:Label ID="Label15" CssClass="stockTitle" runat="server" Font-Bold="True" Font-Size="XX-Large" Text="Stock Management"></asp:Label>


    <div class="container">
        <div class="row">
            <div style="border: 1px solid cyan; background-color: #10455b; max-width: 70%; width: 100%; padding-top: 20px;">
                <asp:Label ID="Label1" runat="server" Text="Stock ID" Width ="240px" CssClass="label" ForeColor="White"></asp:Label>
                <asp:TextBox ID="stockID" runat="server" Width="300px"></asp:TextBox>
                &nbsp;<asp:Button ID="Button1" runat="server" CssClass="searchButt" OnClick="Button1_Click" Text="Search Stock" BorderStyle="None" />
                <br />
                <br />
    
                <asp:Label ID="Label3" runat="server" Text="Stock Description" Width ="240px" CssClass="label label-position" ForeColor="White"></asp:Label>
                <asp:TextBox ID="stockDesc" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox>
                &nbsp;<br />
                <br />
                <asp:Label ID="Label6" runat="server" Text="Stock Quantity" Width ="240px" CssClass="label" ForeColor="White"></asp:Label>
                <asp:TextBox ID="stockQty" runat="server" TextMode="Number" Width="300px"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label14" runat="server" ForeColor="White" Text="Medicine ID" Width="240px"></asp:Label>
                <asp:TextBox ID="medID" runat="server" Width="300px"></asp:TextBox>
                <br />
                <br />
                
                <br />
                <div style="max-width: 570px;">
                    <center>
                        <asp:Button CssClass="btn btn-primary btn-lg" ID="uploadButton" runat="server" Text="Upload" OnClick="uploadButton_Click" />
                        <asp:Button CssClass="btn btn-primary btn-lg" ID="Button2" runat="server" OnClick="Button2_Click" Text="Update" />
                    </center>
                </div>
                <br />
                <br />
            </div>

            
            
            </div>

            <br />
            <br />

           <!--GRIDVIEW-->
            <div style="background: white; border-radius: 10px; padding: 10px; margin-bottom: 20px;">
                <asp:GridView ID="GridView1" CssClass="stock dt-responsive table table-striped table-bordered" runat="server" AutoGenerateColumns="False" DataKeyNames="Stock_ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#336666" BorderStyle="None" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                    <Columns>
                        <asp:BoundField DataField="Stock_ID" HeaderText="Stock_ID" ReadOnly="True" SortExpression="Stock_ID" />
                        <asp:BoundField DataField="Stock_Desc" HeaderText="Stock_Desc" SortExpression="Stock_Desc" />
                        <asp:BoundField DataField="Qty_On_Hand" HeaderText="Qty_On_Hand" SortExpression="Qty_On_Hand" />
                        <asp:BoundField DataField="Med_ID" HeaderText="Med_ID" SortExpression="Med_ID" />
                        <asp:CommandField ShowDeleteButton="True" />
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
</asp:Content>
