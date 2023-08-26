<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="paymentSuccesful.aspx.cs" Inherits="pharmacy_System.Web_Forms.paymentSuccesful" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

        <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/2077ce66f0.js" crossorigin="anonymous"></script>


    <style>

        body {
            height: 100vh;
            background-image: linear-gradient(35deg, #00ff87, #60efff);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .circle {
          border: 2px solid cyan;
          border-radius: 5px;
          max-width: 600px;
          width: 100%;
          background: #fff;
          margin: 20px auto;
          box-shadow: 1px 1px 2px rgba(0,0,0,0.125);
        }

        .tick {
            color: #3cf5d2;
            margin: 30px 0;
        }

        .homeButton {
            border-radius: 5px;
            background: lightseagreen;
            color: white;
            text-decoration: none;
            padding: 10px;
            transition: background 0.3s ease-in-out;
        }

        .homeButton:hover {
            background: #0f68a9;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="circle">
                    <center>
                        <h1>Payment Successfull</h1>
                        <div class="tick-box"><i class="fa-solid fa-circle-check fa-8x tick"></i></div>
                    </center>

                    <h5>Amount&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </h5>
                    <br />
                    <center><asp:Button ID="Button1" runat="server" CssClass="homeButton" Text="Return to Home Page" BorderStyle="None" OnClick="Button1_Click" /></center>
                    <br />
                </div>
            </div>
        </div>
        
    </form>
</body>
</html>
