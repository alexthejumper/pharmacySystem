<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Doctor.Master" AutoEventWireup="true" CodeBehind="viewUploadedPrescription.aspx.cs" Inherits="pharmacy_System.Web_Forms.viewUploadedPrescription" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function () {
            $(".sp").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

    <style>
        .prescSearchButton, .uploadPrescButt {
            border-radius: 5px;
            background: #20b2aa;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .prescSearchButton:hover, .uploadPrescButt:hover {
            background: white;
            color: lightseagreen;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            &nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="Quick Prescriptions" Font-Size="XX-Large"></asp:Label>
            <br />
            <div style="background-color: #10455b; max-width: 70%; width: 100%; padding: 30px; margin-bottom: 50px;">
                <asp:Label ID="Label1" runat="server" Text="Enter Customer NIC" ForeColor="White" Width="240px"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" CssClass="prescSearchButton" Text="Search Prescriptions" OnClick="Button1_Click" BorderStyle="None" />
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" ForeColor="White" Text="Customer ID" Width="240px"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" ReadOnly="True"></asp:TextBox>
            </div>

            <asp:Label ID="Label4" runat="server" Text="Prescriptions List" Font-Size="XX-Large"></asp:Label>
            <br />
            <div style="background: white; border-radius: 10px; padding: 10px; margin-bottom: 50px;">
                <asp:GridView ID="gvSelectPrescription" CssClass="sp" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnRowCommand="gvSelectPrescription_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Presc_ID" HeaderText="Presc ID"/>
                        <asp:BoundField DataField="Presc_Date" HeaderText="Date"/>
                        <asp:BoundField DataField="Med_ID" HeaderText="Med_ID"/>
                        <asp:BoundField DataField="Med_Name" HeaderText="Med_Name"/>
                        <asp:BoundField DataField="Stock_ID" HeaderText="Stock_ID"/>
                        <asp:BoundField DataField="Qty_Presc" HeaderText="Qty Prescribed"/>
                        <asp:TemplateField HeaderText="Med_Image" SortExpression="Med_Image">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Med_Image") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Eval("Med_Image") %>' Width="150px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:ButtonField CommandName="select" Text="Select" />
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
                    <asp:GridView ID="gvPrescCart" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="gvPrescCart_RowCommand">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Cus_ID" HeaderText="Customer_ID"/>
                            <asp:BoundField DataField="Med_Name" HeaderText="Medicine Name"/>
                            <asp:BoundField DataField="Md_ID" HeaderText="Medicine ID"/>
                            <asp:BoundField DataField="Stk_ID" HeaderText="Stock ID"/>
                            <asp:BoundField DataField="Qty" HeaderText="Quantity"/>
                            <asp:ButtonField CommandName="remove" Text="Remove" />
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
            </div>
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
                                <asp:Button ID="Button2" runat="server" CssClass="uploadPrescButt" Text="Upload Prescription" OnClick="Button2_Click" BorderStyle="None" />
                            </center>
                        </div>
        </div>
    </div>
</asp:Content>
