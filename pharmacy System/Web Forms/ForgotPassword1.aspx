<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Starter.Master" AutoEventWireup="true" CodeBehind="ForgotPassword1.aspx.cs" Inherits="pharmacy_System.Web_Forms.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/forgotPassword.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-sm-8 col-md-6 col-lg-5 col-xl-5 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="form-group">
                                <p>In order to recover your password, we must send it to your email.<br></p>
                                <asp:Label ID="Label1" runat="server" Text="Enter email address"></asp:Label>
                                <br/>
                                <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Email Address must be entered" ControlToValidate="TextBox1" Display="Dynamic" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid email address" ControlToValidate="TextBox1" Display="Dynamic" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                <br/>
                                <center>
                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                </center>
                                <br />
                                <br/>
                                <center>
                                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary btn-lg" Text="Continue" OnClick="Button1_Click"/>
                                    <br />
                                    <br />
                                    <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary btn-lg" Text="Return to Sign In page" CausesValidation="false" OnClick="Button2_Click" />
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
