<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="admin-users.aspx.cs" Inherits="AdminUser" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
         <div class="container-fluid">
            <div class="row align-items-center mb-30 pt-30">
                <div class="col-md-12 mr-auto ml-auto">
                    <div class="mb-0">
                        <h4>Users</h4>
                        <p>Edit user info, assign, and delete user</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="bg-white table-responsive rounded shadow-sm pt-3 pb-3 mb-30">
                <h6 class="pl-3 pr-3 text-capitalize font400 mb-20">User list</h6>
                <table id="data-table" class="table-compact mb-0 table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>UserName</th>
                            <th>First name</th>
                            <th>Last name</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>UserStatus</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="Userlist" runat="server">
                    </tbody>
                </table>
            </div>
        </div>
        <script type="text/javascript" src="lib/data-tables/jquery.dataTables.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.bootstrap4.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.responsive.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/responsive.bootstrap4.min.js"></script> 
        <script src="js/plugins-custom/datatables-custom.js"></script>
        <script>

            $(".user").addClass("active");

        </script>
    </asp:Content>

