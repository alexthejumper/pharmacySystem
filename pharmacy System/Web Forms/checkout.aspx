<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="pharmacy_System.Web_Forms.checkout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

    <script>
        $(document).ready(function () {
            $(".checkout").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <style>
        .ccimage {
            margin-right: 1px;
        }

        .mcb {
            background-color: white;
            padding: 2px;
        }

        .row {
            margin-top: 50px;
        }

        .catButton {
            padding: 2px;
            border-radius: 5px;
        }

        @media(max-width: 992px) {
            .paymentButtons {
                height: 100px !important;
                padding-bottom: 50px;
            }

            .itemSelected {
                margin-top: 50px;
            }
        }
        
        .checkoutButt {
            border-radius: 5px;
            background: #10455b;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .checkoutButt:hover {
            background: white;
            color: lightseagreen;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            
            <div class="col-lg-6">
                 <div  style="background-color: #10455b; border-radius: 10px; height: 100%; padding: 20px 30px 0 30px;">
                    <div>
                    <asp:Label ID="Label10" runat="server" Text="Your Personal Details" Font-Bold="True" Font-Size="X-Large" ForeColor="White"></asp:Label>
                    </div>
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Surname" Width="124px" ForeColor="White"></asp:Label><asp:TextBox ID="TextBox1" runat="server" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="First Name" Width="124px" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="TextBox2" runat="server" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="Label3" runat="server" Text="Street" Width="124px" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="TextBox3" runat="server" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="Label4" runat="server" Text="Town" Width="124px" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="TextBox4" runat="server" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="Label5" runat="server" Text="Mobile" Width="124px" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="TextBox5" runat="server" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="Label6" runat="server" Text="Email" Width="124px" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="TextBox6" runat="server" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                </div>
            </div>

            <div class="col-lg-6"">
                <div class="itemSelected">
                <asp:Label ID="Label11" runat="server" Text="Items Selected" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                </div>
                <br />
                <div style="background-color: white; padding: 20px; border-radius: 5px;">
                    <asp:GridView ID="gvCheckoutOrders" CssClass="checkout" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                <Columns>
                    <asp:BoundField DataField="Med_Name" HeaderText="Med Name"/>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Image ID="Image6" runat="server" ImageUrl ='<%# Eval("Med_Image") %>' Height="85px" Width="90px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Price" HeaderText="Price"/>
                    <asp:BoundField DataField="QTY_ORDERED" HeaderText="Quantity"/>
                    <asp:BoundField DataField="ITEM_TOTAL" HeaderText="Total"/>
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

                    <div style="display:flex; justify-content:flex-end; margin-top: 20px;">
                        <div>
                            <asp:GridView ID="gvCheckoutTotal" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="GrandTotal" HeaderText="Grand Total"/>
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
                </div>

                
            </div>
       </div>


       <div class="row">
           <div>
               <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Payment Method"></asp:Label>
                <br />
           </div>

           <div class="col-lg-6">
               <div style="background-color: #10455b; padding: 30px; border-radius: 10px; margin-bottom: 50px; max-width: 600px;">
                    <div>
                        <asp:RadioButton ID="RadioButton3" runat="server" Text="Paypal" GroupName="payment" ForeColor="White" />
                        <asp:Image ID="Image3" runat="server" Height="20px" ImageUrl="~/images/paypal.png" />
                    </div>
                    <br />

                    <asp:Label ID="Label8" runat="server" CssClass="catButton" Text="Credit Card" Font-Bold="True" BackColor="#00FFCC"></asp:Label>
                    <div>  
                        <asp:RadioButton ID="RadioButton1" runat="server" Text="Master Card" GroupName="payment" ForeColor="White" />  
                        <asp:Image ID="Image2" runat="server" Height="20px" ImageUrl="~/images/mastercard.png" Width="40px" />
                        <asp:RadioButton ID="RadioButton2" runat="server" Text="Visa" GroupName="payment" CssClass="ccimage" ForeColor="White"/>
                        <asp:Image ID="Image1" runat="server" Height="20px" ImageUrl="~/images/visa.jpg" Width="40px" />
                    </div> 

                    <br />

                     <asp:Label ID="Label9" runat="server" CssClass="catButton" Text="Online Banking" Font-Bold="True" BackColor="#00FFCC"></asp:Label>
                    <div>
                        <asp:RadioButton ID="RadioButton4" runat="server" Text="Internet Banking" GroupName="payment" ForeColor="White" /> 
                        <asp:Image ID="Image4" runat="server" Height="20px" CssClass="mcb" ImageUrl="~/images/mcb.png" />
                        <asp:Image ID="Image5" runat="server" Height="20px" ImageUrl="~/images/sbm2.png" Width="40px" />
                    </div>
                </div>
           </div>

           <div class="col-lg-6 paymentButtons" style="height: 230px; display: flex; align-items: center; justify-content:center">
               
                   <asp:Button ID="Button1" runat="server" CssClass="checkoutButt" Text="Add/Remove items" OnClick="Button1_Click" />
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <asp:Button ID="Button2" runat="server" CssClass="checkoutButt" Text="Place and Pay Order" OnClick="Button2_Click" />
               
               
           </div>
                
       </div>
                
            </div>
</asp:Content>
