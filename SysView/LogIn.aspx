<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LogIn.aspx.cs" Inherits="User_LogIn" %>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <title>Dashboard</title>    
        <!-- Bootstrap-->
        <link href="lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <!--Common Plugins CSS -->
        <link href="css/plugins/plugins.css" rel="stylesheet"/>
        <!--fonts-->
        <link href="lib/line-icons/line-icons.css" rel="stylesheet"/>
        <link href="lib/toastr/toastr.min.css" rel="stylesheet"/>
        <link href="lib/font-awesome/css/fontawesome-all.min.css" rel="stylesheet"/>
        <link href="css/style.css" rel="stylesheet"/>
        <script type="text/javascript" src="lib/jquery/dist/jquery.min.js"></script>
        <script type="text/javascript" src="js/plugins/plugins.js"></script> 
        <script type="text/javascript" src="js/appUi-custom.js"></script> 
        <script type="text/javascript" src="lib/peity/jquery.peity.min.js"></script>
        <script src="lib/select2/dist/js/select2.min.js"></script>
        <script src="lib/toastr/toastr.min.js"></script>

        <style>
            #loader-wrapper {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 1000;
                background: rgba(0, 0, 0, 0.7);
                display: none; 
            }
            .lds-ripple {
              display: inline-block;
              position: absolute;
              width: 80px;
              height: 80px;
              top: calc(50% - 40px);
              left: calc(50% - 40px);
            }
            .lds-ripple div {
              position: absolute;
              border: 4px solid #fff;
              opacity: 1;
              border-radius: 50%;
              animation: lds-ripple 1s cubic-bezier(0, 0.2, 0.8, 1) infinite;
            }
            .lds-ripple div:nth-child(2) {
              animation-delay: -0.5s;
            }
            @keyframes lds-ripple {
              0% {
                top: 36px;
                left: 36px;
                width: 0;
                height: 0;
                opacity: 1;
              }
              100% {
                top: 0px;
                left: 0px;
                width: 72px;
                height: 72px;
                opacity: 0;
              }
            }

            .sysimg {
                width: inherit;
            }

        </style>
    </head>
    
    <body>

    <form id="form1" runat="server">
       
    <div class="bg-parallax parallax-overlay accounts-page">
        <div class="container">
            <div class="row pb30 pt50">
                <div class="col-lg-4 col-md-6 mr-auto ml-auto col-sm-8 mt-40">
                    <img class="sysimg" src="images/SysViewCloud_Final.png" />
                    <br />
                    <h3 class="text-dark text-center mb30">Login</h3>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="Admin LogIn"></asp:Label>
                    </div>
                    <div class="form-group">
                        <asp:TextBox runat="server" ID="txtusername" CssClass="form-control" placeholder="Email" TextMode="Email"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox runat="server" ID="txtpassword" placeholder="Password" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="lblmsg" ForeColor="Red"></asp:Label>
                    </div>
                    <div class="form-group">
                        <asp:Button runat="server" ID="btnsignin" CssClass="btn btn-rounded btn-primary btn-block" Text="Sign In" OnClick="btnsignin_Click"/>
                    </div>

                   
                    
                    <hr />
                   

                   
                </div>
            </div>
        </div>
    </div>
        </form>
        </body>
    </html>
 
