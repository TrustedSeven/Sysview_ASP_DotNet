<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="admin-student-edit.aspx.cs" Inherits="AdminStudentEdit" %>

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
<%--                        <a href='/devices.aspx' class='float-right btn btn-sm btn-info btn-icon'>
                            <i class="fas fa-download"></i>
                            Scan Device

                        </a>--%>
                        <h4>Student Info</h4>
                    </div>
                </div>
            </div>

        </div>
        <div class="container-fluid">
                 <div class="portlet-box portlet-gutter ui-buttons-col mb-30">
                    <div class="portlet-header flex-row flex d-flex align-items-center b-b">
                        <div class="flex d-flex flex-column">
                            <h3>Student detail info</h3> 
                        </div>
                        <a href="#" class="btn btn-danger btn-device" data-toggle="modal" data-target="#studentDevice">Devices</a>
                    </div>
                    <div class="portlet-body">
                        <form id="form1" runat="server" class="edit-student-form">
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
                                <label class="col-sm-2 col-form-label">Grade</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control grade" id="grade" name="grade" required="required" runat="server"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="inputEmail3" class="col-sm-2 col-form-label">Teacher</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control teacher" id="teacher" name="teacher" required="required" runat="server"/>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-form-label col-sm-2 pt-0">User Status</label>
                                <div class="col-sm-10">
									<select class="form-control user-status" name="user_status" runat="server" id="user_status">
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
        <div id="studentDevice" class="modal" role="dialog" aria-hidden="true">
          <div class="modal-dialog modal-lg">

            <!-- Modal content-->
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="studentDevice_title" runat="server">Student Device Info</h4>
              </div>
              <div class="modal-body">
                <div class="bg-white table-responsive table-sm rounded shadow-sm pt-3 pb-3 mb-30 main-panel">
                  <table id="data-table" class="table mb-0 table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Type</th>
                            <th>SerialNum</th>
                            <th>AssetTag</th>
                            <th>Status</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="Devicelist" runat="server">
                    </tbody>
                  </table>
                </div>
                <div class="extra-panel">
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">Comments</label>
                        <div class="col-sm-9">
                            <textarea class="form-control device-comments"></textarea>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">Assign another device</label>
                        <div class="col-sm-9">
                            <label class="custom-checkbox">
                                <input type="checkbox" class="assign-device"/>
                                <span class="checkmark"></span>
                            </label>
                        </div>
                    </div>
                </div>
              </div>
              <div class="modal-footer">
                <%--<button type="button" class="btn btn-info btn-device-update">Assign</button>--%>
                <button type="button" class="btn btn-default " data-dismiss="modal">Close</button>
              </div>
            </div>

          </div>
        </div>
        <script type="text/javascript" src="lib/data-tables/jquery.dataTables.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.bootstrap4.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.responsive.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/responsive.bootstrap4.min.js"></script> 
        <script src="js/plugins-custom/datatables-custom.js"></script>
        <script>
            $(".invRow").click(function () {
                var invKey = $(this).attr("id");
                window.location.href = '/admin-assetdetail.aspx?inventorykey=' + invKey;
            })
            $(".btn-device").click(function () {
                $(".main-panel").show();
                $(".extra-panel").hide();
            });
            $(".student").addClass("active");
            $(".btn-lost-stolen").click(function () {
                $(".main-panel").hide();
                $(".extra-panel").show();
            });
            $(".edit-student-form").submit(function (e) {

                $("#loader-wrapper").show();
                e.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "admin-student-edit.aspx/updateStudent",
                    data: JSON.stringify({
                        firstName: $('.first-name').val(),
                        lastName: $('.last-name').val(),
                        email: $('.email').val(),
                        grade: $('.grade').val(),
                        teacher: $('.teacher').val(),
                        status: $('.user-status').val()
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#loader-wrapper").hide();
                        toastr.success("Student udpated successfully");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(errorThrown);
                        toastr.error("Error updating student. Contact your administrator");
                        $("#loader-wrapper").hide();
                    }
                });
            });
            $(".btn-unassign").click(function () {
                alert("Are you sure you want to unassign this device?");
            });
            $(".btn-device-update").click(function () {

                $("#loader-wrapper").show();
                var firstName = $("table td.first-name").text();
                var lastName = $("table td.last-name").text();
                var model = $("table td.model").text();
                var serialNum = $("table td.serial-num").text();
                var inventoryKey = $(".btn-lost-stolen").data("inventorykey");
                var studentID = $(".btn-lost-stolen").data("studentid");
                var assetTag = $(".btn-lost-stolen").data("assettag");
                var email = $(".btn-lost-stolen").data("email");
                var comments = $(".device-comments").val();
                var status = $(".assign-device").is(':checked');
                $.ajax({
                    type: "POST",
                    url: "admin-student-edit.aspx/updateDevice",
                    data: JSON.stringify({
                        firstName: firstName,
                        lastName: lastName,
                        model: model,
                        serialNum: serialNum,
                        inventoryKey: inventoryKey,
                        studentID: studentID,
                        assetTag: assetTag,
                        email: email,
                        comments:comments,
                        status: status
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#loader-wrapper").hide();
                        $("#studentDevice").modal("hide");
                        $(".modal-backdrop").remove();
                        toastr.success("This device is udpated successfully");
                        window.location.reload();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(errorThrown);
                        toastr.error("Error updating device. Contact your administrator");
                        $("#loader-wrapper").hide();
                    }
                });
            });
            var unassign = document.getElementById("unassign");
            unassign.addEventListener("click", function () {
                studentKey = unassign.getAttribute("data-studentid");
                inventoryKey = unassign.getAttribute("data-inventorykey");
                console.log(studentKey);
                console.log(inventoryKey);
                $.ajax({
                    type: "POST",
                    url: "admin-student-edit.aspx/unassign",
                    data: JSON.stringify({
                        studentKey: studentKey,
                        inventoryKey: inventoryKey
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {                       
                        studentKey = "";
                        inventoryKey = "";
                        $(unassign).closest('tr').html('<td valign="top" colspan="7" class="dataTables_empty">No data available in table</td>');
                        //$(".selectedRow").removeClass("selectedRow");
                        toastr.success("Device unassigned successfully");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(errorThrown);
                        toastr.error("Error unassigning device. Contact your administrator (data error on unassign method)");
                    }

                });
               
            });
            </script>
    </asp:Content>

