<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Starter.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="pharmacy_System.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/registrationCss.css" rel="stylesheet" />

    <style>
        .sU {
            margin-left: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    

    <div class="container">
        <div class="headertitle">
            <h1>Floride Electronic Pharmacy</h1>
        </div>

        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="150px" src="../images/generaluser.png" />
                                </center>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <center>
                                    <h3>Registration Form</h3>
                                </center>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <hr/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <center>
                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label9" runat="server" Text="Register as"></asp:Label>
                                    </div>
                                    <asp:DropDownList ID="DropDownList1" runat="server">
                                        <asp:ListItem Value="0">Select Account Type</asp:ListItem>
                                        <asp:ListItem Value="CUSTOMER">Customer</asp:ListItem>
                                        <asp:ListItem Value="DOCTOR">Doctor</asp:ListItem>
                                        <asp:ListItem Value="PHARMACIST">Pharmacist</asp:ListItem>
                                    </asp:DropDownList>
                                    <div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" InitialValue="0" runat="server" ControlToValidate="DropDownList1" Display="Dynamic" ErrorMessage="Type of account must be chosed" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                    <br>
                                </div>
                               </center>

                                

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label1" runat="server" Text="Surname"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="surnameTB" runat="server" placeholder ="Surname"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="surnameTB" Display="Dynamic" ErrorMessage="Surname must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <br>
                                </div>

                                

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label2" runat="server" Text="First Name"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="fnameTB" runat="server" placeholder ="First Name"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="fnameTB" Display="Dynamic" ErrorMessage="First Name must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <br>
                                </div>

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label11" runat="server" Text="NIC"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="nicTB" runat="server" placeholder ="NIC"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="nicTB" Display="Dynamic" ErrorMessage="NIC must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <br>
                                </div>

                                

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label3" runat="server" Text="Street"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="streetTB" runat="server" placeholder ="Street"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="streetTB" Display="Dynamic" ErrorMessage="Street address must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <br>
                                </div>

                                

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label8" runat="server" Text="Town"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="townTB" runat="server" placeholder ="Town"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="townTB" Display="Dynamic" ErrorMessage="Town must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <br/>
                                </div>

                                

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label4" runat="server" Text="Mobile Number"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="mobileNumTB" runat="server" placeholder ="Mobile Number" TextMode="Phone" MaxLength="8"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ErrorMessage="Mobile Number must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" ControlToValidate="mobileNumTB"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Mobile Number should start with 5 and has a total of 8 digits" ControlToValidate="mobileNumTB" Display="Dynamic" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(5[0-9]{7})$"></asp:RegularExpressionValidator>
                                    <br>
                                </div>

                                

                                <div class="form-group" id="emailAddress">
                                    <div>
                                        <asp:Label class="label" ID="Label5" runat="server" Text="Email Address"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="emailTB" runat="server" placeholder ="Email"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="emailTB" Display="Dynamic" ErrorMessage="Email Address must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="emailTB" Display="Dynamic" ErrorMessage="The email address is invalid" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    <br>
                                </div>

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label10" runat="server" Text="Username"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="usernameTB" runat="server" placeholder ="Username"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqUsername" runat="server" ControlToValidate="usernameTB" Display="Dynamic" ErrorMessage="Username must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <br>
                                </div>

                                

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label6" runat="server" Text="Password"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="passwordTB" runat="server" placeholder ="Password" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="passwordTB" Display="Dynamic" ErrorMessage="Password must be entered" Font-Italic="True" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Password should contain at least 1 Uppercase, 1 Lowercase, 1 Number, 1 Special character and should have a minimum length of 8" ControlToValidate="passwordTB" Display="Dynamic" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$"></asp:RegularExpressionValidator>
                                    <br>
                                </div>

                                

                                <div class="form-group">
                                    <div>
                                        <asp:Label class="label" ID="Label7" runat="server" Text="Confirm Password"></asp:Label>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="confirmPasswordTB" runat="server" placeholder ="Confirm Password" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="confirmPasswordTB" Display="Dynamic" ErrorMessage="Confirm Password field must not be empty" ForeColor="Red" SetFocusOnError="True" Font-Italic="True"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="passwordTB" ControlToValidate="confirmPasswordTB" Display="Dynamic" ErrorMessage="Passwords do not match" Font-Italic="True" ForeColor="Red"></asp:CompareValidator>
                                    <br>
                                </div>

                                

                                <div style="color: gray">
                                    By clicking an option below, I agree to the <a href="#">Terms of Use</a> and have read the <a href="#">Privacy Statement</a>.
                                    <br/>
                                </div>

                                

                                <div class="form-group">
                                    <div>
                                        <center>
                                            <asp:Button  CssClass="btn btn-primary btn-lg" ID="returnButton" runat="server" Text="Return to Log In" BackColor="LightSeaGreen" BorderColor="LightSeaGreen" ForeColor="White" onmouseover="this.style.opacity=0.8" onmouseout="this.style.opacity=1" CausesValidation="false" OnClick="Button2_Click"/>
                                            <asp:Button  CssClass="btn btn-primary btn-lg sU" ID="signUpButton" runat="server" Text="Sign Up" BackColor="LightSeaGreen" BorderColor="LightSeaGreen" ForeColor="White" onmouseover="this.style.opacity=0.8" onmouseout="this.style.opacity=1" OnClick="Button1_Click"/>
                                        </center>
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

