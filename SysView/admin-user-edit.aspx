<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="admin-user-edit.aspx.cs" Inherits="AdminUserEdit" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <style>
            .modal-backdrop.in{
                opacity:.5;
            }
            .modal-lg{
                max-width:900px;
            }
            .extra-panel{
                display:none;
            }
            .assign-device{
                width:25px;
                height:25px;
                margin-top:5px;
            }
            .custom-checkbox {
                position: relative;
                padding-left: 40px;
                margin-bottom: 11px;
                cursor: pointer;
                font-size: 16px;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
                display: block;
            }

            /* Hide the browser's default checkbox */
            .custom-checkbox input {
              position: absolute;
              opacity: 0;
              cursor: pointer;
              height: 0;
              width: 0;
            }
            .checkmark {
              position: absolute;
              top: 0;
              left: 0;
              height: 30px;
              width: 30px;
              border: 1px solid grey;
            }

            /* On mouse-over, add a grey background color */
            .custom-checkbox:hover input ~ .checkmark {
              border: 1px solid #2196F3;
            }

            /* When the checkbox is checked, add a blue background */
            .custom-checkbox input:checked ~ .checkmark {
              background-color: #2196F3;
              border:none;
            }

            /* Create the checkmark/indicator (hidden when not checked) */
            .checkmark:after {
              content: "";
              position: absolute;
              display: none;
            }

            /* Show the checkmark when checked */
            .custom-checkbox input:checked ~ .checkmark:after {
              display: block;
            }

            /* Style the checkmark/indicator */
            .custom-checkbox .checkmark:after {
              left: 11px;
              top: 5px;
              width: 9px;
              height: 15px;
              border: solid white;
              border-width: 0 3px 3px 0;
              -webkit-transform: rotate(45deg);
              -ms-transform: rotate(45deg);
              transform: rotate(45deg);
            }
        </style> 
        <div class="container-fluid">
            <div class="row align-items-center mb-30 pt-30">
                <div class="col-md-12 mr-auto ml-auto">
                    <div class="mb-0">
                        <h4>User Info</h4>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid">
                 <div class="portlet-box portlet-gutter ui-buttons-col mb-30">
                    <div class="portlet-header flex-row flex d-flex align-items-center b-b">
                        <div class="flex d-flex flex-column">
                            <h3>User detail info</h3> 
                        </div>
                    </div>
                    <div class="portlet-body">
                        <form id="form1" runat="server" class="edit-user-form">
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">User Name</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control user-name" id="userName" runat="server" required="required"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">First Name</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control first-name" id="firstName" runat="server" required="required"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Last Name</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control last-name" id="lastName" runat="server" required="required"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Email</label>
                                <div class="col-sm-10">
                                    <input type="email" class="form-control email" id="email" name="email" runat="server" required="required"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Password</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control password" id="password" name="password" required="required" runat="server"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-sm-2 pt-0">User Status</label>
                                <div class="col-sm-10">
									<select class="form-control user-status" name="user_status" runat="server" id="user_status">
                                        <option value="Admin">Admin</option>
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
									</select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-2"></div>
                                <div class="col-sm-2">
                                    <button type="submit" class="btn btn-primary btn-block">Update</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
        </div>
        <script type="text/javascript" src="lib/data-tables/jquery.dataTables.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.bootstrap4.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.responsive.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/responsive.bootstrap4.min.js"></script> 
        <script src="js/plugins-custom/datatables-custom.js"></script>
        <script>
            $(".user").addClass("active");
            $(".edit-user-form").submit(function (e) {

                $("#loader-wrapper").show();
                e.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "admin-user-edit.aspx/updateUser",
                    data: JSON.stringify({
                        userName: $('.user-name').val(),
                        firstName: $('.first-name').val(),
                        lastName: $('.last-name').val(),
                        email: $('.email').val(),
                        password: $('.password').val(),
                        status: $('.user-status').val()
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#loader-wrapper").hide();
                        toastr.success("This user is udpated successfully");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(errorThrown);
                        toastr.error("Something wrong");
                        $("#loader-wrapper").hide();
                    }
                });
            });
        </script>
    </asp:Content>

