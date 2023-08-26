<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="updateCustomer.aspx.cs" Inherits="pharmacy_System.Web_Forms.updateCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .custUpdateButton {
            border-radius: 5px;
            background: #20b2aa;
            color: white;
            text-decoration: none;
            padding: 1% 5%;
        }

        .custUpdateButton:hover {
            background: white;
            color: lightseagreen;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="row" style="margin: 50px 0;">
             <asp:Label ID="Label7" runat="server" Text="Your Profile" Width="236px" ForeColor="Black" Font-Bold="True" Font-Size="XX-Large"></asp:Label>
            <div class="col-12" style="text-align: center; background-color: #10455b; padding-top: 20px; border-radius: 10px;">
                <asp:Label ID="Label1" runat="server" Text="Surname" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Surname must not be empty" ControlToValidate="TextBox1" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>

                <br />

                <br />

                <asp:Label ID="Label2" runat="server" Text="First Name" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="First Name must not be empty" ControlToValidate="TextBox2" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>

                <br />

                <br />

                <asp:Label ID="Label3" runat="server" Text="Street" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Street must not be empty" ControlToValidate="TextBox3" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>


                <br />

                <br />

                <asp:Label ID="Label4" runat="server" Text="Town" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox4" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Town must not be empty" ControlToValidate="TextBox4" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>
                <br />

                <br />

                <asp:Label ID="Label5" runat="server" Text="Mobile" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox5" runat="server" TextMode="Phone" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Mobile number should not be empty" ControlToValidate="TextBox5" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>
                <br />

                <br />

                <asp:Label ID="Label6" runat="server" Text="Email" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox6" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Email should not be empty" ControlToValidate="TextBox6" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>

                <br />
                <br />

                <br />

                <asp:Button ID="Button1" CssClass="custUpdateButton" runat="server" Text="Update" OnClick="Button1_Click" />

                <br />
                <br />
            </div>
        </div>

    </div>
    
</asp:Content>
