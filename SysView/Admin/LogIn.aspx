<%@ Page Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="LogIn.aspx.cs" Inherits="Admin_LogIn" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <form id="form1" runat="server">
       
    <div class="bg-parallax parallax-overlay accounts-page">
        <div class="container">
            <div class="row pb30 pt50">
                <div class="col-lg-4 col-md-6 mr-auto ml-auto col-sm-8">
                    <br />
                    <h3 class="text-dark text-center mb30">Login</h3>
                    <%-- <form id="form1" runat="server">--%>
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
</asp:Content>
