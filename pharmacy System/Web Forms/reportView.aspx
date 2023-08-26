<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reportView.aspx.cs" Inherits="pharmacy_System.Web_Forms.reportView" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>

    <style>
        .downloadButton {
            border-radius: 5px;
            background: lightseagreen;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .downloadButton:hover {
            background: white;
            color: lightseagreen;
        }
    </style>

</head>

<body>
    <form id="form1" runat="server">
        <div>
            <div style="text-align: center; margin-top: 3%;">
                <h1 style="color: lightseagreen">Floride Pharmacy Payment Report</h1>
                <h2 style="color: mediumseagreen;"><i>Last 3 Months</i></h2>
            </div>
                
            <br />
            <br />

            <div style="padding-left: 5%;">
                <p><b>Patient ID: </b><asp:Label ID="Label6" runat="server" Text="Label"></asp:Label></p>
                <p><b>Name: </b><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></p>
                <p><b>Address: </b><asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp; <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label></p>
                <p><b>Date & Time: </b><asp:Label ID="Label5" runat="server" Text="Label"></asp:Label></p>

            </div>

            <br />
            

            <center>
                

                <asp:GridView ID="gvViewPayments2" runat="server" CssClass="dt-responsive table-striped table-bordered" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="P_Id" HeaderText="Payment ID">
                         <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:BoundField DataField="P_Date" HeaderText="Payment Date">
                         <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:BoundField DataField="P_AMOUNT" HeaderText="Amount">
                        <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="P_CATEGORY" HeaderText="Category">
                         <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                         <asp:BoundField DataField="REFERENCE_ID" HeaderText="Transaction Reference">
                        <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" HorizontalAlign="Center"/>
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
            </center>
                
            
        </div>
        
        <br />
        <br />

        <center><asp:Button ID="Button1" CssClass="downloadButton" runat="server" Text="Download PDF Report" OnClick="Button1_Click" /></center>    
        
        
    </form>
</body>
</html>
