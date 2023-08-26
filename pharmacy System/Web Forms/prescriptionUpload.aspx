<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Doctor.Master" AutoEventWireup="true" CodeBehind="prescriptionUpload.aspx.cs" Inherits="pharmacy_System.Web_Forms.prescriptionUpload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function () {
            $(".pr").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

    <style>
        .searButt {
            border-radius: 5px;
            background: #20b2aa;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .searButt:hover {
            background: white;
            color: lightseagreen;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [MEDICINE]" DeleteCommand="DELETE FROM [MEDICINE] WHERE [Med_ID] = @Med_ID" InsertCommand="INSERT INTO [MEDICINE] ([Med_Name], [Med_Category], [Med_Description], [Price], [Medicine_Reaction], [Permissible_Dose], [Med_Image]) VALUES (@Med_Name, @Med_Category, @Med_Description, @Price, @Medicine_Reaction, @Permissible_Dose, @Med_Image)" UpdateCommand="UPDATE [MEDICINE] SET [Med_Name] = @Med_Name, [Med_Category] = @Med_Category, [Med_Description] = @Med_Description, [Price] = @Price, [Medicine_Reaction] = @Medicine_Reaction, [Permissible_Dose] = @Permissible_Dose, [Med_Image] = @Med_Image WHERE [Med_ID] = @Med_ID">
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
            <div style="margin-top: 50px;">
                <asp:Label ID="Label3" runat="server" Font-Size="XX-Large" Text="Customer Detail"></asp:Label>
            </div>
                
            <br />

            <div style="background-color: #10455b; max-width: 70%; width: 100%; padding: 30px; margin-bottom: 50px;">
                <asp:Label ID="Label1" runat="server" Width="240px" ForeColor="White">Enter Customer NIC</asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" Width="300px"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" CssClass="searButt" OnClick="Button1_Click" Text="Search Customer" BorderStyle="None" />
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Text="Customer ID" Width="240px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" Width="300px" ReadOnly="True"></asp:TextBox>
                <br />
            </div>
            
            <div style="background: white; border-radius: 10px; padding: 10px; margin-bottom: 20px;">
                <asp:Label ID="Label4" runat="server" Text="Medicines List" Font-Size="XX-Large"></asp:Label>
                <br />
                <asp:GridView ID="GridView1" CssClass="pr dt-responsive table-striped table-bordered" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataKeyNames="Med_ID" DataSourceID="SqlDataSource1" GridLines="Horizontal" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
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
                        <asp:CommandField ShowSelectButton="True" />
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
                <br />
                <br />

                <div>
                    <asp:Label ID="Label5" runat="server" Text="Choose Stock" Font-Size="XX-Large" Visible="False"></asp:Label>
                    <br />
            <asp:GridView ID="gvStock" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnRowCommand="gvStock_RowCommand" OnSelectedIndexChanged="gvStock_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="Stock_ID" HeaderText="Stock ID"/>
                    <asp:BoundField DataField="Stock_Desc" HeaderText="Description"/>
                    <asp:BoundField DataField="Qty_On_Hand" HeaderText="Quantity"/>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:ButtonField Text="Add Item" CommandName="add" />
                    <asp:ButtonField Text="Reduce Item" CommandName="reduce" />
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


                    <div>
                        <asp:Label ID="Label6" runat="server" Text="Prescription Preview" Font-Size="XX-Large" Visible="False"></asp:Label>
                        <asp:GridView ID="gvPrescriptionCart" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDeleting="gvPrescriptionCart_RowDeleting">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Cus_ID" HeaderText="Customer ID"/>
                                <asp:BoundField DataField="Med_Name" HeaderText="Medicine Name"/>
                                <asp:BoundField DataField="Md_ID" HeaderText="Medicine ID"/>
                                <asp:BoundField DataField="Stk_ID" HeaderText="Stock ID"/>
                                <asp:BoundField DataField="Qty" HeaderText="Quantity"/>
                                <asp:CommandField ShowDeleteButton="True" DeleteText="Remove Item" />
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
                        <asp:Label ID="Label9" runat="server" Font-Size="XX-Large" Text="Medical Record &amp; Comments"></asp:Label>
                        <br />

                        <div style="background-color: #10455b; max-width: 70%; width: 100%; padding: 30px; margin-bottom: 50px;">
                            <asp:Label ID="Label7" runat="server" Text="Disease Comments" Width="240px" ForeColor="White"></asp:Label>
                            <asp:TextBox ID="diseaseTextBox" runat="server" TextMode="MultiLine" Width="50%"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Label ID="Label8" runat="server" Text="Your Prescription Comments" Width="240px" ForeColor="White"></asp:Label>
                            <asp:TextBox ID="prescCommentsBox" runat="server" TextMode="MultiLine" Width="50%"></asp:TextBox>
                            <br />
                            <br />
                            <center>
                                <asp:Button ID="Button2" runat="server" Text="Upload Prescription" OnClick="Button2_Click" />
                            </center>
                        </div>
                        
                    </div>
                </div>
        </div>
    </div>
    
    </asp:Content>
