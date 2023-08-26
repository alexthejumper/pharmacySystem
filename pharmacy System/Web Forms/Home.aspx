<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="pharmacy_System.Web_Forms.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/homeHome.css" rel="stylesheet" />
    <link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
    <link href="https://fonts.googleapis.com/css2?family=Arvo&display=swap" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid content">
        <div style="display: flex; align-content: center;" class="content-overlay container-fluid">
            <div class="container-fluid welcome">
                <p style="text-align: center;">Welcome to Floride Pharmacy,<br>our well known pharmacy in Mauritius</p>
                <div class="readMore" style="display: flex; justify-content: center;">
                    <a style="text-decoration: none; background-color: white; padding: 0 20px; color: lightseagreen;" href="contact.aspx">Contact Us</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
