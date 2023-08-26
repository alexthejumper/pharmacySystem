<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/Doctor.Master" AutoEventWireup="true" CodeBehind="doctorDetails.aspx.cs" Inherits="pharmacy_System.Web_Forms.doctorDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media (max-width: 768px) {
            .firstContainer {
                margin-top: 50px;
            }
        }

        .work {
            margin-top: 20px;
        }

        .workingButtons {
            border-radius: 5px;
            background: #10455b;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .workingButtons:hover {
            background: white;
            color: lightseagreen;
        }

        .categoryButton {
            border-radius: 5px;
            background: lightseagreen;
            color: white;
            text-decoration: none;
            padding: 1%;
        }

        .categoryButton:hover {
            background: white;
            color: lightseagreen;
        }

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
        <div style="margin: 40px 0;" class="row">
            <asp:Label ID="Label1" runat="server" Text="Your Profile" Width="236px" ForeColor="Black" Font-Bold="True" Font-Size="XX-Large"></asp:Label>
            <div class="col-12" style="text-align: center; background-color: #10455b; padding-top: 20px; border-radius: 10px;">
                <asp:Label ID="Label2" runat="server" Text="Surname" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox4" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Surname must not be empty" ControlToValidate="TextBox4" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>

                <br />

                <br />

                <asp:Label ID="Label8" runat="server" Text="First Name" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox5" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="First Name must not be empty" ControlToValidate="TextBox5" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>

                <br />

                <br />

                <asp:Label ID="Label9" runat="server" Text="Street" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox6" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Street must not be empty" ControlToValidate="TextBox6" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>


                <br />

                <br />

                <asp:Label ID="Label10" runat="server" Text="Town" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox7" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Town must not be empty" ControlToValidate="TextBox7" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>
                <br />

                <br />

                <asp:Label ID="Label11" runat="server" Text="Mobile" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox8" runat="server" TextMode="Phone" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Mobile number should not be empty" ControlToValidate="TextBox8" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>
                <br />

                <br />

                <asp:Label ID="Label12" runat="server" Text="Email" Width="200px" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBox9" runat="server" Width="200px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Email should not be empty" ControlToValidate="TextBox9" Font-Italic="True" ForeColor="Red" SetFocusOnError="True" BackColor="#CCFFFF" Width="300px"></asp:RequiredFieldValidator>

                <br />
                <br />

                <br />

                <asp:Button ID="Button7" CssClass="custUpdateButton" runat="server" Text="Update" OnClick="Button7_Click" />

                <br />
                <br />
            </div>
        </div>

        <div style="margin: 40px 0;" class="row">
            <div class="col-md-6" style="background-color: #468189; padding-bottom: 40px;">

                <asp:Label ID="Label6" runat="server" Font-Size="X-Large" CssClass ="work" ForeColor="White" Text="Working Days &amp; Hours"></asp:Label>
                <br />
                <br />

                <asp:Label ID="Label4" runat="server" ForeColor="White" Text="Enter Working Days" Width="224px"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label5" runat="server" ForeColor="White" Text="Enter Working Hours" Width="224px"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                <br />
                <br />
                <div><asp:Button ID="Button4" runat="server" CssClass="workingButtons" Text="Save Working Days and Hours" OnClick="Button4_Click" BorderStyle="None" /></div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <div><asp:Button ID="Button5" runat="server" CssClass="workingButtons" Text="Update Working Days and Hours" OnClick="Button5_Click" BorderStyle="None" /></div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <div><asp:Button ID="Button6" runat="server" CssClass="workingButtons" Text="Delete Working Days and Hours" OnClick="Button6_Click" BorderStyle="None" />
                    <br />
                    <br />
                    <br />
                    <br />
                </div>

                <div>
                    <asp:GridView ID="gvWork" runat="server" CssClass="dt-responsive table table-striped table-bordered" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvWork_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="WORKING_DAYS" HeaderText="Working Days">
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                            <asp:BoundField DataField="WORKING_HOURS" HeaderText="Working Hours">
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="True" />
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

            <div class="col-md-6  firstContainer"  style="background-color: #10455b; padding-bottom: 40px;" >
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" CssClass="work" ForeColor="White" Text="Doctor Category"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="Enter Doctor Category" ForeColor="White" Width="224px"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                <br />
                <br />
                <div><asp:Button ID="Button1" runat="server" CssClass="categoryButton" Text="Save Doctor Category" OnClick="Button1_Click" BorderStyle="None" /></div>
                <br />
                <br />
                <div> <asp:Button ID="Button2" runat="server" OnClick="Button2_Click"  CssClass="categoryButton" Text="Update Doctor Category" BorderStyle="None" /></div>
                <br />
                <br />
                <div><asp:Button ID="Button3" runat="server" OnClick="Button3_Click" CssClass="categoryButton" Text="Delete Doctor Category" BorderStyle="None" /></div>
                <br />
                <br />

                <br />

                <div style="margin-top: 5.5px;">
                    <asp:GridView ID="gvCatDoc" runat="server" CssClass="dt-responsive table table-striped table-bordered" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvCatDoc_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Doc_Cat_ID" HeaderText="Category ID">
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Category_Name" HeaderText="Doctor Category Name">
                            <HeaderStyle ForeColor="White" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="True" />
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
</asp:Content>
