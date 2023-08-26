<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Starter.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="pharmacy_System.Web_Forms.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/Login.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
 
        <div class="container">
            <div class="row">

                <div>
                    <h1 style="margin-bottom: 10%; text-align: center; margin-top: 3.5%;">Floride Electronic Pharmacy</h1>
                </div>

                <div class="col-sm-8 col-md-6 col-lg-5 col-xl-5 mx-auto">
                    <div style="margin-top: 1%; margin-bottom: 4%;" class="card">
                        <div class="card-body">
                            <div class = "row">
                                <div class="col">

                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="Username"></asp:Label>
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Username must be entered" Display="Dynamic" Font-Italic="True" EnableViewState="True" SetFocusOnError="True" ControlToValidate="TextBox1" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>

                                    <br>

                                    <div class="form-group">
                                        <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>
                                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password must be entered" Display="Dynamic" Font-Italic="True" ControlToValidate="TextBox2" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>

                                    <br>

                                    <center>
                                         <div class="d-grid gap-2 col-6 mx-auto">
                                             <asp:Button ID="Button1" runat="server" Text="Log In" CssClass="btn btn-primary btn-lg" BackColor="LightSeaGreen" BorderColor="LightSeaGreen" OnClick="Button1_Click" />
                                        </div>
                                    </center>

                                    <br/>
                                    <br/>

                                    <div class="row">
                                        <div class="col">
                                            <a href="Registration.aspx">Register</a>
                                        </div>
                                        
                                        <div id="forgotP" class="col">
                                            <a href="ForgotPassword1.aspx">Forgot Password ?</a>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>   
        </div>
</asp:Content>
