<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Pharmacist.Master" AutoEventWireup="true" CodeBehind="pharmacyPrescriptions.aspx.cs" Inherits="pharmacy_System.Web_Forms.pharmacyPrescriptions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .tot {
            margin-left: 70%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />

    <div class="container">
        <div class="row">
    <asp:Label ID="Label2" runat="server" Text="Prescription Search" Font-Size="XX-Large"></asp:Label>
    <div style="background-color: #10455b; max-width: 70%; width: 100%; padding: 30px; margin-bottom: 50px;">
        <asp:Label ID="Label1" runat="server" Text="Prescription ID" Width="240px" ForeColor="White"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        &nbsp;<asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" />
        <br />
        <br />
        <br />
        </div>

        <div>
            <br />
            <asp:Label ID="Label3" runat="server" Font-Size="XX-Large" Text="Customer Prescription"></asp:Label>
            <asp:GridView ID="gvUPresc" runat="server" CssClass="table-striped table-bordered" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="gvUPresc_RowCommand">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Presc_ID" HeaderText="Presc_ID"/>
                    <asp:BoundField DataField="Cust_ID" HeaderText="Customer_ID"/>
                    <asp:BoundField DataField="Med_ID" HeaderText="Medicine ID"/>
                    <asp:BoundField DataField="Med_Name" HeaderText="Medicine Name"/>
                    <asp:BoundField DataField="Stock_ID" HeaderText="Stock_ID"/>
                    <asp:BoundField DataField="Qty_Presc" HeaderText="Quantity Presc"/>
                    <asp:BoundField DataField="Price" HeaderText="Unit Price"/>
                    <asp:BoundField DataField="TOTAL" HeaderText="Total"/>
                    <asp:TemplateField HeaderText="Med_Image" SortExpression="Med_Image">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Med_Image") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Eval("Med_Image") %>' Width="150px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    <asp:ButtonField CommandName="reduce" Text="Reduce" />
                    <asp:ButtonField CommandName="remove" Text="Remove">
                    <ControlStyle ForeColor="Red" />
                    </asp:ButtonField>
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
            <div>
                <asp:Button ID="Button2" CssClass="btn btn-primary btn-lg" runat="server" OnClick="Button2_Click" Text="Paid" />
            <asp:GridView ID="gvTotal" CssClass="tot table-striped table-bordered" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                <Columns>
                    <asp:BoundField DataField="TOTAL" HeaderText="Total"/>
                </Columns>
                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                <RowStyle BackColor="White" ForeColor="#003399" />
                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                <SortedAscendingCellStyle BackColor="#EDF6F6" />
                <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                <SortedDescendingCellStyle BackColor="#D6DFDF" />
                <SortedDescendingHeaderStyle BackColor="#002876" />
            </asp:GridView>

                <br />
                <br />
        </div>
        </div>
    </div>
    </div>

</asp:Content>
