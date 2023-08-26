<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="pharmacy_System.Web_Forms.contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/contact.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid content">
        <div style="background: white; border-radius: 10px;"><h1 class="animate-charcter">We are here to help you</h1></div>
    </div>

    <div class="bottom" style="display: flex; justify-content: center; align-items: center;">
        <h2 style="color: white;">Send Us an Email on <a href="mailto:alexaguero997@gmail.com">alexaguero997@gmail.com</a></h2>
    </div>
</asp:Content>
