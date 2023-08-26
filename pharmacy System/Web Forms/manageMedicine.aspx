<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Admin.Master" AutoEventWireup="true" CodeBehind="manageMedicine.aspx.cs" Inherits="pharmacy_System.Web_Forms.manageMedicine" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function () {
            $(".med").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

    <style>
        @media (min-width: 1200px){
            .label {
            width: 240px;
            text-align: center;
        }

            .rd {
                display: flex;
            }
        }

        .medTitle {
            margin-left: 10%;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [MEDICINE] WHERE [Med_ID] = @Med_ID" InsertCommand="INSERT INTO [MEDICINE] ([Med_Name], [Med_Category], [Med_Description], [Price], [Medicine_Reaction], [Permissible_Dose], [Med_Image]) VALUES (@Med_Name, @Med_Category, @Med_Description, @Price, @Medicine_Reaction, @Permissible_Dose, @Med_Image)" SelectCommand="SELECT * FROM [MEDICINE]" UpdateCommand="UPDATE [MEDICINE] SET [Med_Name] = @Med_Name, [Med_Category] = @Med_Category, [Med_Description] = @Med_Description, [Price] = @Price, [Medicine_Reaction] = @Medicine_Reaction, [Permissible_Dose] = @Permissible_Dose, [Med_Image] = @Med_Image WHERE [Med_ID] = @Med_ID">
        <DeleteParameters>
            <asp:Parameter Name="Med_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Med_Name" Type="String" />
            <asp:Parameter Name="Med_Category" Type="String" />
            <asp:Parameter Name="Med_Description" Type="String" />
            <asp:Parameter Name="Price" Type="Decimal" />
            <asp:Parameter Name="Medicine_Reaction" Type="String" />
            <asp:Parameter Name="Permissible_Dose" Type="Int32" />
            <asp:Parameter Name="Med_Image" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Med_Name" Type="String" />
            <asp:Parameter Name="Med_Category" Type="String" />
            <asp:Parameter Name="Med_Description" Type="String" />
            <asp:Parameter Name="Price" Type="Decimal" />
            <asp:Parameter Name="Medicine_Reaction" Type="String" />
            <asp:Parameter Name="Permissible_Dose" Type="Int32" />
            <asp:Parameter Name="Med_Image" Type="String" />
            <asp:Parameter Name="Med_ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <br />

    &nbsp;<asp:Label ID="medManageTitle" runat="server" CssClass="medTitle" Font-Bold="True" Font-Size="XX-Large" Text="Add a new Medicine"></asp:Label>
    <br />

    <br />

    <div class="container">
        <div class="row">
            <div style="border: 1px solid cyan; background-color: #10455b; max-width: 70%; width: 100%; padding-top: 20px;" class="col">
                <asp:Label ID="Label1" runat="server" Text="Medicine Name" Width ="240px" CssClass="label" ForeColor="White"></asp:Label>
                <asp:TextBox ID="medNameTB" runat="server" Width="300px"></asp:TextBox>
                &nbsp;<asp:Label ID="Label8" runat="server"></asp:Label>
                <br />
                <br />
                <div class="rd">
                    <asp:Label ID="Label2" runat="server" Text="Medicine Category" Width ="245px" CssClass="label" ForeColor="White"></asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="300px">
                        <asp:ListItem Value="0">SELECT CATEGORY</asp:ListItem>
                        <asp:ListItem Value="MOTHER">MOTHER</asp:ListItem>
                        <asp:ListItem Value="CHILDREN">CHILDREN</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;<asp:Label ID="Label9" runat="server"></asp:Label>
                    <br />
                </div>
                <br />
    
                <asp:Label ID="Label3" runat="server" Text="Medicine Description" Width ="240px" CssClass="label label-position" ForeColor="White"></asp:Label>
                <asp:TextBox ID="medDescTB" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox>
                &nbsp;<asp:Label ID="Label10" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label4" runat="server" Text="Medicine Price" Width ="240px" CssClass="label" ForeColor="White"></asp:Label>
                <asp:TextBox ID="medPriceTB" runat="server" TextMode="SingleLine" Width="300px"></asp:TextBox>
                &nbsp;<asp:Label ID="Label11" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label5" runat="server" Text="Medicine Reactions" Width ="240px" CssClass="label label-position" ForeColor="White"></asp:Label>
                <asp:TextBox ID="medReactionTB" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox>
                <asp:Label ID="Label12" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label6" runat="server" Text="Permissible Dose" Width ="240px" CssClass="label" ForeColor="White"></asp:Label>
                <asp:TextBox ID="doseTB" runat="server" TextMode="Number" Width="300px"></asp:TextBox>
                <asp:Label ID="Label13" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label7" runat="server" Text="Medicine Image" Width ="240px" CssClass="label" ForeColor="White"></asp:Label>
                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="" ForeColor="White" />
                <asp:Label ID="Label14" runat="server"></asp:Label>
                <br />
                <br />
                <div style="max-width: 570px;">
                    <center>
                        <asp:Button CssClass="btn btn-primary btn-lg" ID="uploadButton" runat="server" OnClick="Button1_Click" Text="Upload" />
                        <asp:Button CssClass="btn btn-primary btn-lg" ID="Button1" runat="server" OnClick="Button1_Click1" Text="Update" />
                    </center>
                </div>
                <br />
                <br />
            </div>


           <!--GRIDVIEW-->
            <div style="background: white; border-radius: 10px; padding: 10px; margin-bottom: 20px;">
                <asp:GridView ID="GridView1" CssClass="med dt-responsive table-striped table-bordered" runat="server" AutoGenerateColumns="False" DataKeyNames="Med_ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#336666" BorderStyle="None" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="Med_ID" HeaderText="Med_ID" InsertVisible="False" ReadOnly="True" SortExpression="Med_ID" />
                        <asp:BoundField DataField="Med_Name" HeaderText="Med_Name" SortExpression="Med_Name" />
                        <asp:BoundField DataField="Med_Category" HeaderText="Med_Category" SortExpression="Med_Category" />
                        <asp:BoundField DataField="Med_Description" HeaderText="Med_Description" SortExpression="Med_Description" />
                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                        <asp:BoundField DataField="Medicine_Reaction" HeaderText="Medicine_Reaction" SortExpression="Medicine_Reaction" />
                        <asp:BoundField DataField="Permissible_Dose" HeaderText="Permissible_Dose" SortExpression="Permissible_Dose" />
                        <asp:TemplateField HeaderText="Med_Image" SortExpression="Med_Image">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Med_Image") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Eval("Med_Image") %>' Width="150px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" />
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
