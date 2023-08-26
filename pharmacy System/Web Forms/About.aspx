<%@ Page Title="" Language="C#" MasterPageFile="~/Master Pages/HomePage.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="pharmacy_System.Web_Forms.WebForm4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/about.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="aboutTitle" class="container-fluid">
        <h1>Our Pharmacy</h1>
    </div>

    <div class="accordion container-fluid" id="accordionExample">

         <div class="accordion-item">
            <h2 class="accordion-header" id="headingOne">
              <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                Where Floride Pharmacy is found ?
              </button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
              <div class="accordion-body">
                <strong>Floride Pharmacy</strong> is a pharmacy found in Mauritius.
              </div>
            </div>
         </div>

        <br/>
        <br/>

         <div class="accordion-item">
            <h2 class="accordion-header" id="flush-headingTwo">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                Purpose of this Electronic Pharmacy System (EPS)
              </button>
            </h2>
            <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
              <div class="accordion-body">It aims to speed up the process of dispensing drugs to patients in a manner than ensures pharmacological safety and high efficiency.
                  It also provides the time and effort exerted by the staff and ensures the accuracy of the patient's internal medical disbursement as well as the control of the disbursed quantities.</div>
            </div>
         </div>

        <br/>
        <br/>

        <div class="accordion-item">
            <h2 class="accordion-header" id="flush-headingFour">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false" aria-controls="flush-collapseFour">
                How the the system deals with safety and security of drug description process ?
              </button>
            </h2>
            <div id="flush-collapseFour" class="accordion-collapse collapse" aria-labelledby="flush-headingFour" data-bs-parent="#accordionFlushExample">
              <div class="accordion-body">It alerts the doctor to any drug interventions such as drug reactions, and permissible doses.
                  Moreover, documentation about a specific disease's suscpetibility to any medicine of food, helps to increase the medical care provided to the patient.</div>
            </div>
        </div>

        <br/>
        <br/>

        <div class="accordion-item">
            <h2 class="accordion-header" id="flush-headingThree">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
               What about medical stock control ?
              </button>
            </h2>
            <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
              <div class="accordion-body">The pharamcy system provides a precise control of the medical stock, as it is not allowed to request medicines
                  outside the aprrove list or exceed the quantities specified.</div>
            </div>
        </div>

   </div>
</asp:Content>
