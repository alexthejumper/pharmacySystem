<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="viewProductChildren.aspx.cs" Inherits="pharmacy_System.Web_Forms.viewProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

    <script>
        $(document).ready(function () {
            $(".child").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

    <style>
        .hyperLink {
            border-radius: 5px;
            background: lightseagreen;
            color: white;
            text-decoration: none;
            padding: 5%;
        }

        .hyperLink:hover {
            background: white;
            color: lightseagreen;
        }

        span {
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div style="background-color: white; margin: 50px 0; padding: 30px; border-radius: 5px;">
                <asp:GridView ID="gvChildProducts" CssClass="child dt-responsive table table-striped table-bordered" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                <Columns>
                    <asp:BoundField DataField="Med_ID" HeaderText="Medicine_ID"/>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-lg-6" style="background-color: #10455b; padding: 6%;">
                                        <div class="row"> 
                                            <div class="col-12">
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Med_Name") %>' Font-Bold="True" Font-Size="Large" ForeColor="White"></asp:Label>
                                            </div>
                                        </div>

                                        <br />

                                        <div class="row">
                                            <div class="col-12">

                                                <span>Price:</span>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Price") %>' ForeColor="White"></asp:Label>

                                            </div>
                                        </div>

                                        <br />

                                        <div class="row">
                                            <div class="col-12">

                                                <span>Description</span>
                                                <br />
                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Med_Description") %>' ForeColor="White"></asp:Label>

                                            </div>
                                        </div>

                                        <br />

                                        <div class="row">
                                            <div class="col-12">

                                                <span>Medicine Reactions</span>
                                                <br />
                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Medicine_Reaction") %>' ForeColor="White"></asp:Label>

                                            </div>
                                        </div>


                                        <br />

                                        <div class="row">
                                            <div class="col-12">
                                                <span>Permissible Dose</span>
                                                <br />
                                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Permissible_Dose") %>' ForeColor="White"></asp:Label>
                                            </div>
                                        </div>

                                        <br />
                                        <br />

                                        <div class="row">
                                            <div class="col-12">
                                                 <asp:HyperLink runat="server" ID="btnGo" CssClass="hyperLink" Text="Add to Cart" NavigateUrl='<%# "viewCart.aspx?pro=" + Eval("Med_ID") %>' />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-6" style="text-align: center; padding: 6%; background-color: #10455b">
                                        <asp:Image class="img-fluid" ID="Image1" runat="server" ImageUrl ='<%# Eval("Med_Image") %>' Height="100%"/>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>     
                    </asp:TemplateField>
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
