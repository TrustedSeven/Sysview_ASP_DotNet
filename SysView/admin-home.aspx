<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="admin-home.aspx.cs" Inherits="AdminHome" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <style>
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
                         <a href='/quick-insert.aspx' class='float-right btn btn-sm btn-primary btn-icon'>
                            <i class="fas fa-download"></i>
                            Quick Insert
                        </a>
<%--                        <a href='/devices.aspx' class='float-right btn btn-sm btn-info btn-icon mr-1'>
                            <i class="fas fa-rss"></i>
                            Scan Device
                        </a>--%>
                        <a href='javascript:void(0);' class='float-right btn btn-sm btn-danger btn-icon mr-1' data-toggle="modal" data-target="#addDevice">
                            <i class="fas fa-plus"></i>
                            Add Device
                        </a>

                        <h4>Welcome, <%= FirstName %></h4>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 mb-6 col-md-6 mb-30">
                    <div class="list border1 rounded overflow-hidden">
                        <div class="list-item">
                            <div class="list-thumb bg-primary text-primary-light avatar rounded-circle avatar60 shadow-sm">
                                <%--<i class="icon-Add-Basket"></i>--%>
                                <i class="fas fa-laptop"></i>
                            </div>
                            <div class="list-body text-right">
                                <span class="list-title fs-2x"><%= TotalAssets %></span>
                                <span class="list-content fs14">Total Devices</span>

                            </div>
                        </div>
                    </div>
                </div><!--col-->
                <div class="col-lg-3 mb-6 col-md-6 mb-30">
                    <div class="totRepairs list border1 rounded overflow-hidden">
                        <div class="list-item">
                            <div class="list-thumb bg-danger-active text-danger-light avatar rounded-circle avatar60 shadow-sm">
                                <%--<i class="icon-Truck"></i>--%>
                                <%--<i class="fas fa-medkit"></i>--%>
                                <img src="images/sysview/repairs_mono.png" />
                            </div>
                            <div class="list-body text-right">
                                <span class="list-title fs-2x"><%= TotalRepairs %></span>
                                <span class="list-content  fs14">Repair Status</span>

                            </div>
                        </div>
                    </div>
                </div><!--col-->
                <div class="col-lg-3 mb-6 col-md-6  mb-30">
                    <div class="list border1 rounded overflow-hidden">
                        <div class="list-item">
                            <div class="list-thumb bg-warning-active text-warning-light avatar rounded-circle avatar60 shadow-sm">
                                <i class="fas fa-question-circle"></i>
                            </div>
                            <div class="list-body text-right">
                                <span class="list-title fs-2x"><%= TotalLost %></span>
                                <span class="list-content fs14">Lost/Stolen</span>

                            </div>
                        </div>
                    </div>
                </div><!--col-->
                <div class="col-lg-3 mb-6 col-md-6  mb-30">
                    <div class="list border1 rounded overflow-hidden">
                        <div class="list-item">
                            <div class="list-thumb bg-success-active text-success-light avatar rounded-circle avatar60 shadow-sm">
                                <%--<i class="icon-Money-Bag"></i>--%>
                                <%--<i class="fas fa-home"></i>--%>
                                <i class="fa fa-cubes" aria-hidden="true"></i>
                            </div>
                            <div class="list-body text-right">
                                <span class="list-title fs-2x"><%= TotalDecom %></span>
                                <span class="list-content fs14">Unassigned/Decom</span>

                            </div>
                        </div>
                    </div>
                </div><!--col-->
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="portlet-box portlet-fullHeight mb-30">
                        <div class="portlet-header bg-light flex-row flex d-flex align-items-center">
                            <div class="flex d-flex flex-column">
                                <h3>Inventory List</h3> 
                            </div>
<%--                            <div class="portlet-tools">
                                <ul class="nav">

                                    <li class="nav-item">
                                        <select class="custom-select bg-light hidden-search" data-placeholder="Filter Orders">
                                            <option value="1" selected>Sort By...</option>
                                            <option value="2">Pending Orders</option>
                                            <option value="3">Canceled Orders</option>
                                            <option value="4">Return Orders</option>
                                        </select>
                                    </li>
                                    <li class="nav-item pl-3">
                                        <a href="#" class="btn btn-link">
                                            View all devices
                                        </a>
                                    </li>
                                </ul>
                            </div>--%>
                        </div>
                        <div class="portlet-body no-padding">

                            <div class="table-responsive">
                                <%--<h6 class="pl-3 pr-3 text-capitalize font400 mb-20">Inventory List</h6>--%>
                                <table id="data-table" class="table-compact mb-0 table-striped" cellspacing="0" width="100%">
                                <%--<table id="data-table" class="table mb-0 table-striped" cellspacing="0" width="100%">--%>
                                    <thead>
                                        <tr>
                                            <th>Model</th>
                                            <th>Serial</th>
                                            <th>Asset Tag</th>
                                            <th>Status</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="InventoryList" runat="server">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" id="addDevice">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">

              <!-- Modal Header -->
              <div class="modal-header">
                <h4 class="modal-title">Add Device</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
              </div>

              <!-- Modal body -->
              <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-field mb-2">
                            <span>AssetTag</span>
                            <input type="text" class="form-control asset-tag"/>
                        </div>
                        <div class="form-field mb-2">
                            <span>Serial Num/Service Tag</span>
                            <input type="text" class="form-control serial-num"/>
                        </div>
                        <div class="form-field mb-2">
                            <span>Model</span>
                            <input type="text" class="form-control model"/>
                        </div>
                        <div class="form-field mb-4">
                            <span>Device status</span>
                            <select class="custom-select bg-light hidden-search status" data-placeholder="Device Status">
                                <option value="1">In Use</option>
                                <option value="2">Submitted For Repair</option>
                                <option value="3">Repair In Progress</option>
                                <option value="4">Repair Complete</option>
                                <option value="5">Decomissioned</option>
                                <option value="6">Lost/Stolen</option>
                                <option value="7">Unassigned</option>
                            </select>
                        </div>
                        <div class="form-field">
                            <div class="form-group">
                                <label for="swLoaner" class="custom-checkbox normal-issue">
                                    <span>Loaner</span>
                                    <input id="swLoaner" type="checkbox" />
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="swHomeUse" class="custom-checkbox normal-issue">
                                    <span>Home Use</span>
                                    <input id="swHomeUse" type="checkbox" />
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
              </div>

              <!-- Modal footer -->
              <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-add-device">Insert</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
            $(document).ready(function () {
                $('input[type="search"]').focus();
            });

            $(".invRow").click(function () {
                var invKey = $(this).attr("id");
                window.location.href = '/admin-assetdetail.aspx?inventorykey=' + invKey;
            })
            $(".btn-add-device").click(function () {
                var asset_tag = $(".asset-tag").val();
                var model = $(".model").val();
                var serial_num = $(".serial-num").val();
                var status = $(".status").val();
                var loaner_flag = ($("#swLoaner").is(":checked")) ? '1' : '0';
                var homeuse_flag = ($("#swHomeUse").is(":checked")) ? '1' : '0';
                $.ajax({
                    type: "POST",
                    url: "admin-home.aspx/addDevice",
                    data: JSON.stringify({ asset_tag: asset_tag, model: model, serial_num: serial_num, status: status, loaner_flag: loaner_flag, homeuse_flag: homeuse_flag }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        toastr.success("Info was updated successfully");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                        $("#loader-wrapper").hide();

                    }
                });
            });
            $(".dash").addClass("active");

        </script>
    </asp:Content>

