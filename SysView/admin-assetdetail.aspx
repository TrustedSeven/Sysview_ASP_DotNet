<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="admin-assetdetail.aspx.cs" Inherits="AdminAssetDetail" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <style>
            #divAssetImg{
                text-align:center;
            }
            #divAssetImg img{
                margin:5px 15px 10px 0;
                height: 123px;
                width: auto;
            }

            #divSubmit{
                text-align:center;
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
        <div class="page-subheader mb-10">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-md-7">
                                <div class="list">
                                    <div class="list-item pl-0">
                                        <div class="list-body">
                                            <div class="list-title fs-2x">
                                                <h3>Device Details</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5 d-flex justify-content-end">
                            <a href="javascript:void(0)" class="btn btn-icon btn-primary btn-success mb-2 mr-1 btn-save-asset">
                                            <%--<i class="icon-Calendar-4"></i>--%>
                                            <i class="fas fa-check"></i>
                                            Save
                                        </a>
<%--                            <a href="javascript:void(0)" class="btn btn-icon btn-danger btn-danger mb-2">
                                <i class="fas fa-undo-alt"></i>            
                                            Cancel
                                        </a>--%>
                                        <a href="javascript:void(0);" class="btn btn-danger mb-2" data-toggle="modal" data-target="#startRepair">Start Repair</a>

<%--                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb no-padding bg-trans mb-0">
                                        <li class="breadcrumb-item"><a href="home.aspx"><i class="icon-Home mr-2 fs14"></i></a></li>
                                        <li class="breadcrumb-item active">Admin Device Details </li>
                                    </ol>
                                </nav>--%>
                            </div>
                        </div>
                    </div>
                </div><!-- page-sub-Header end-->
                <div class="page-content">
                    <div class="container-fluid">

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="portlet-box portlet-gutter ui-buttons-col mb-30">
                                    <div class="portlet-header flex-row flex d-flex align-items-center b-b">
                                        <div class="flex d-flex flex-column">
                                            <h3>Device</h3> 
                                            <span class="portlet-subtitle">Basic device ID data</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="form-group">
                                            <label>Asset Tag</label>
                                            <input value="<%= InventoryKey %>" runat="server" id="txtAssetTag" type="text" class="form-control txt-asset-tag" placeholder="Asset Tag"/>
                                        </div>
                                        <div class="form-group">
                                            <label>Serial Num/Service Tag</label>
                                            <input value="" runat="server" id="txtSerialNum" type="text" class="form-control txt-serial-num" placeholder="Serial Number"/>
                                        </div>
                                        <div class="form-group">
                                            <label>Model</label>
                                            <input value="" runat="server" id="txtModel" type="text" class="form-control txt-model" placeholder="Model"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="portlet-box portlet-gutter ui-buttons-col mb-30">
                                    <div class="portlet-header flex-row flex d-flex align-items-center b-b">
                                        <div class="flex d-flex flex-column">
                                            <h3>Status</h3> 
                                            <span class="portlet-subtitle">Device status</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="form-group">
                                            <%--<label>Status</label>--%>
                                            <select id="ddlDeviceStatus" value="" runat="server" class="custom-select bg-light hidden-search ddl-device-status" data-placeholder="Device Status">
                                                <option value="1">In Use</option>
                                                <option value="2">Submitted For Repair</option>
                                                <option value="3">Repair In Progress</option>
                                                <option value="4">Repair Complete</option>
                                                <option value="5">Decomissioned</option>
                                                <option value="6">Lost/Stolen</option>
                                                <option value="8">Unassigned</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="swLoaner" class="custom-checkbox normal-issue">
                                                <span>Loaner</span>
                                                <input id="swLoaner" type="checkbox" <% if (loanerFlag == "1") { %> checked <% } %>/>
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <label for="swHomeUse" class="custom-checkbox normal-issue">
                                                <span>Home Use</span>
                                                <input id="swHomeUse" type="checkbox"<% if (homeUseFlag == "1") { %> checked <% } %>/>
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="portlet-box portlet-gutter ui-buttons-col mb-30">
                                    <div class="portlet-header flex-row flex d-flex align-items-center b-b">
                                        <div class="flex d-flex flex-column">
                                            <h3>User Info</h3> 
                                            <span runat="server" class="portlet-subtitle">Assigned User</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="table-responsive">
                                            <asp:Literal ID ="UserList" runat="server"></asp:Literal>
                                        </div>
<%--                                        <div class="form-group">
                                            <label>Student ID</label>
                                            <input runat="server" id="txtStudentID" type="text" class="form-control">
                                        </div>
                                        <div class="form-group">
                                            <label>Student Name</label>
                                            <input runat="server" id="txtStudentName" type="text" class="form-control">
                                        </div>
                                        <div class="form-group">
                                            <label>Student Email</label>
                                            <input value="" runat="server" id="txtStudentEmail" type="text" class="form-control">
                                        </div>--%>
                                    </div>
                                </div><!--portlet-->
                            </div>
                            <div class="col-md-6">
                                <div class="portlet-box portlet-gutter ui-buttons-col mb-30">
                                    <div class="portlet-header flex-row flex d-flex align-items-center b-b">
                                        <div class="flex d-flex flex-column">
                                            <h3>Repair History</h3> 
                                            <span class="portlet-subtitle">List of repair requests, latest first</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body no-padding">

                                        <div class="table-responsive">
                                            <asp:Literal ID ="RepairList" runat="server"></asp:Literal>
                                        </div>
                                    </div>
                                </div><!--portlet-->
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="row ml-5 mb-2">
                        <div class="col-md-12 text-right">


                        </div>
                    </div>
                        <div class="col-md-12">
                        <div class="portlet-box portlet-gutter ui-buttons-col mb-30">

                        </div>
                        </div>
                    </div>


        <div class="modal" id="startRepair">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">

              <!-- Modal Header -->
              <div class="modal-header">
                <h4 class="modal-title">Start Repair</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
              </div>

              <!-- Modal body -->
              <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                            <h5><%= Model %></h5>
                            Inventory ID: <b><%= InventoryKey %></b><br />
                            Serial Num/Service Tag: <b><%= SerialNum %></b>
                        <div class="form-group">
                            <label>Comments</label>
                            <textarea class="other-issue-content form-control" runat="server" id="repair_notes"></textarea>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="divProbs">
                            <label class="custom-checkbox normal-issue">
                                <span>Screen Damaged</span>
                                <input type="checkbox" <% if (problems != null && problems.Contains("Screen Damaged")) { %> checked <% } %>/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="custom-checkbox normal-issue">
                                <span>Keyboard Not Working</span>
                                <input type="checkbox" <% if (problems != null && problems.Contains("Keyboard Not Working")) { %> checked <% } %>/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="custom-checkbox normal-issue">
                                <span>Keyboard Missing Key(s)</span>
                                <input type="checkbox" <% if (problems != null && problems.Contains("Keyboard Missing Key(s)")) { %> checked <% } %>/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="custom-checkbox normal-issue">
                                <span>Trackpad Not Working</span>
                                <input type="checkbox" <% if (problems != null && problems.Contains("Trackpad Not Working")) { %> checked <% } %>/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="custom-checkbox normal-issue">
                                <span>Hinges Damaged</span>
                                <input type="checkbox" <% if (problems != null && problems.Contains("Hinges Damaged")) { %> checked <% } %>/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="custom-checkbox normal-issue">
                                <span>Apps Missing</span>
                                <input type="checkbox" <% if (problems != null && problems.Contains("Apps Missing")) { %> checked <% } %>/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="custom-checkbox normal-issue">
                                <span>WiFi Not Working</span>
                                <input type="checkbox" <% if (problems != null && problems.Contains("WiFi Not Working")) { %> checked <% } %>/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="custom-checkbox normal-issue">
                                <span>Power Adapter Damaged</span>
                                <input type="checkbox" <% if (problems != null && problems.Contains("Power Adapter Damaged")) { %> checked <% } %>/>
                                <span class="checkmark"></span>
                            </label>
                            <label class="custom-checkbox other-issue">Other
                                <input type="checkbox"/>
                                <span class="checkmark"></span>
                            </label>
                        </div>
                    </div>
                </div>
              </div>

              <!-- Modal footer -->
              <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-detail-update">Update</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>

            </div>
          </div>
        </div>
    <script>


        $(".dash").addClass("active");

        $(function () {
            $(".btn-save-asset").click(function () {
                var inventory_key = '<%= InventoryKey %>';
                var asset_tag = $(".txt-asset-tag").val();
                var serial_num = $(".txt-serial-num").val();
                var model = $(".txt-model").val();
                var status_id = $(".ddl-device-status").val();
                var loaner_flag = ($("#swLoaner").is(":checked")) ? '1' : '0';
                var homeuse_flag = ($("#swHomeUse").is(":checked")) ? '1' : '0';
                console.log(loaner_flag, homeuse_flag);
                $.ajax({
                    type: 'POST',
                    url: "admin-assetdetail.aspx/updateAsset",
                    data: JSON.stringify({ inventory_key: inventory_key, asset_tag: asset_tag, serial_num: serial_num, model: model, status_id: status_id, loaner_flag: loaner_flag, homeuse_flag: homeuse_flag }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#loader-wrapper").hide();
                        toastr.success("Asset Info was updated successfully");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                        $("#loader-wrapper").hide();

                    }
                });
            });
            $(".btn-detail-update").click(function () {
                var repairNotes = $(".other-issue-content").val();
                var problem_arr = [];
                $(".divProbs input:checked").each(function () {
                    problem_arr.push($(this).prev().text());
                });
                var problems = problem_arr.join(",");
                $.ajax({
                    type: "POST",
                    url: "admin-assetdetail.aspx/UpdateRepair",
                    data: JSON.stringify({ problems: problems, repairNotes: repairNotes }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#loader-wrapper").hide();
                        toastr.success("Info was updated successfully");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                        $("#loader-wrapper").hide();

                    }
                });
            });
        });
    </script>
    </asp:Content>

