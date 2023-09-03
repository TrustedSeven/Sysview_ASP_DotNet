<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="repair.aspx.cs" Inherits="Repair" %>

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
                        <h4>Submit Repair Request</h4>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" class="student-id" runat="server" id="student_id" />

        <div class="container-fluid">
            <div class="row deviceDisplay">
                <div class="col-sm-12">
                    <div class="portlet-box portlet-gutter ui-buttons-col mb-30">
                        <div class="portlet-header flex-row flex align-items-center b-b ml-10">
                            <div class="row">
                                <div class="col-md-3">
                                    <h2><span id="spnModel" style="font-weight:100;"></span><%= Model %> </h2>
                                </div>
                                <div class="col-md-2">
                                    <span id="spnAssetTag" style="font-weight:100;">Asset Tag </span><br /><h3><%= AssetTag %> </h3>
                                </div>
                                <div class="col-md-3">
                                    <span id="spnSerialNum" style="font-weight:100;">Serial </span><br /><h3><%= SerialNum %> </h3>
                                </div>
                                <div class="col-md-3">
                                    <span id="spnUserEmail" style="font-weight:100;">User Email </span><br /><h3><%= UserEmail %> </h3>
                                </div>
                                <span class="portlet-subtitle"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="portlet-body">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <input type="hidden" id="invkey" />
                                            <div class="divProbs">
                                                <b>Check all that apply:</b>
                                                <p></p>
                                                <label class="custom-checkbox normal-issue">
                                                    <span>Screen Damaged</span>
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                                <label class="custom-checkbox normal-issue">
                                                    <span>Keyboard Not Working</span>
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                                <label class="custom-checkbox normal-issue">
                                                    <span>Keyboard Missing Key(s)</span>
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                                <label class="custom-checkbox normal-issue">
                                                    <span>Trackpad Not Working</span>
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                                <label class="custom-checkbox normal-issue">
                                                    <span>Hinges Damaged</span>
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                                <label class="custom-checkbox normal-issue">
                                                    <span>Apps Missing</span>
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                                <label class="custom-checkbox normal-issue">
                                                    <span>WiFi Not Working</span>
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                                <label class="custom-checkbox normal-issue">
                                                    <span>Power Adapter Damaged</span>
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                                <label class="custom-checkbox other-issue">Other
                                                    <input type="checkbox"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                            </div>
                                        </div>

                                        <div class="col-sm-8">
                                            <div class="flex d-flex flex-column mb-20">
                                                <div class="divAssetInfo2">
                                                    <b>Enter "Other" Notes:</b>
                                                    <div class="assetInfo">
                                                        <textarea style="width:87%;" class="other-issue-content"></textarea>
                                                    </div>
                                                </div>
                                                <div class="divImg">
                                                    <div id="divAssetImg"></div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="btnGroup">
                                        <button class="btn btn-primary mr-1 mb-2 repair-req-btn">Submit</button>
                                        <button onclick="javascript:searchAssets();" type="button" class="btn btn-danger mr-1 mb-2">Cancel</button>
                                    </div>

                                    <div class="msgSubmitted" style="display:none;">
                                        <h1>Your repair request has been submitted</h1>
                                        <a href="javascript:void(0)" class="btn btn-icon btn-xl btn-primary mb-2 btn-another-assign">
                                            <i class="fas fa-laptop"></i>
                                            Assign another device to this user?
                                        </a>
                                    </div>
                                    <div class="another-assign-list-container" style="display:none;">
                                        <div class="table-responsive">
                                            <table id="data-table" class="table-compact mb-0 table-striped" cellspacing="0" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th>Model</th>
                                                        <th>Serial</th>
                                                        <th>Last User</th>
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
                </div>
            </div>
        </div>

        <script type="text/javascript" src="lib/data-tables/jquery.dataTables.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.bootstrap4.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.responsive.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/responsive.bootstrap4.min.js"></script> 
        <script src="js/plugins-custom/datatables-custom.js"></script>
        <script>

            //$(".other-issue input").click(function () {
            //    $(".other-issue-content").slideToggle();
            //});

            $(".normal-issue input, .other-issue input").click(function () {
                $(this).toggleClass("checked");
            });

            function init() {
                $("#txtModel, #txtSerialNum, #txtStudentID, #txtStudent").text("");
                $("#txtAssetTag").val("");
                $(".custom-checkbox input").each(function () {
                    if ($(this).attr("class") == "checked") $(this).trigger("click");
                });
            }
            $(".btnSearchAssets").click(function () {
                searchAssets();
            });

            //THIS IS WHERE WE LEFT OFF, NEED TO MAKE ASSIGN NOTHER DEVICE MORE SMOOTH
            $(".btn-another-assign").click(function () {
                $(".another-assign-list-container").show();
                $(".portlet-header").html("<h2>Select another device to assign</h2><p>Scan a device, or select one from the list below.");
                $(this).parent().hide();
                $("input[type='search']").focus();
            });
            function searchAssets() {
                $("#loader-wrapper").show();

                $.ajax({
                    type: "POST",
                    url: "repair.aspx/SearchAssets",
                    data: JSON.stringify({ assetNum: $('#txtAssetTag').val() }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d) {
                            console.log(response.d);
                            var strResponse = JSON.stringify(response.d);
                            var strParse = JSON.parse(strResponse);
                            $("#divNoResults").hide();
                            if ($(".deviceDisplay").is(":hidden")) {
                                $(".deviceDisplay").slideToggle();
                            }
                            $("#invkey").val(strParse.inventoryKey);
                            $("#txtStatus").text(strParse.invStatus);
                            var deviceStatus = strParse.invStatus;
                            $("#txtModel").text(strParse.model);
                            $("#txtStudent").text(strParse.userEmail);
                            $("#txtStudentID").text(strParse.studentID);
                            $("#txtSerialNum").text(strParse.serialNum);
                            $(".txtModel").text(strParse.model);
                            $(".txtStudent").text(strParse.userEmail);
                            $(".txtSerialNum").text(strParse.serialNum);
                            $("#spnAssetTag").html('&nbsp <span>Asset# ' + $('#txtAssetTag').val() + '</span>');
                            $("#divAssetImg").html('<img src="' + strParse.imgLink + '" />');
                            $("#txtAssetTag").val("");
                            $(".custom-checkbox input").each(function () {
                                if ($(this).attr("class") == "checked") $(this).trigger("click");
                            });

                            $(".assetInfo").show();
                            $(".divAssetInfo2").hide();

                            $(".divImg").show();
                            $(".divProbs").hide();
                            $(".btnGroup").hide();
                            if (deviceStatus == 'Submitted For Repair') {
                                $(".btnRepairReq").hide();
                            } else {
                                $(".btnRepairReq").show();
                            }
                            $(".msgSubmitted").hide();

                        } else {
                            $("#divNoResults").show();
                            console.log(response.d);
                        }
                        $("#loader-wrapper").hide();

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                        $("#loader-wrapper").hide();

                    }
                });
            }
            $(".repair-req-btn").click(function () {
                var inventoryKey = <%= InvKey %>;
                var problem_arr = [];
                var problemNotes = "";
                var searchAssetTag = $('#txtAssetTag').val();
                $(".normal-issue").each(function () {
                    //alert("whats happening here");
                    if ($(this).children("input").attr("class") == "checked") problem_arr.push($(this).children("span:first-child").text());
                });
                var problems = (problem_arr.length > 0) ? problem_arr.join(",") : "";
                //if ($(".other-issue input").attr("class") == "checked")
                problemNotes = $(".other-issue-content").val();

                if (problems == "" && problemNotes == "") {
                    toastr.warning("Please select a reason to be repaired");
                } else {
                    $("#loader-wrapper").show();
                    $.ajax({
                        type: "POST",
                        url: "repair.aspx/InsertRepairs",
                        data: JSON.stringify({ invkey: inventoryKey, problems: problems, problemNotes: problemNotes }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d) {
                                toastr.success("Request was sent successfully");
                                init();
                                $(".divAssetInfo2").toggle("slide");
                                $(".divImg").toggle("slide");
                                $(".divProbs").slideToggle();
                                $(".btnGroup").slideToggle();
                                $(".msgSubmitted").show();
                            } else {
                                toastr.warning("OOPS... Something went wrong during repair request");
                            }

                            $("#loader-wrapper").hide();

                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            toastr.danger("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                            $("#loader-wrapper").hide();
                        }
                    });
                }

            });

            $(".btn-insert-student-device").click(function () {
                var invKey = $(this).parent().parent().attr("id");
                var studentID = $(".student-id").val();
                $("#loader-wrapper").show();
                $.ajax({
                    type: "POST",
                    url: "repair.aspx/InsertStudentDevice",
                    data: JSON.stringify({ invkey: invKey, studentID: studentID }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d) {
                            toastr.success("Loaner Assigned to student  ID ", studentID);
                            setTimeout(function () {
                                window.location.href = "/devices.aspx";
                                window.clearTimeout(tID);		// clear time out.
                            }, 3000);
                        } else {
                            toastr.warning("Something went wrong. This is not your fault. Tell your admin the device user could not be inserted.");
                        }

                        $("#loader-wrapper").hide();

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        toastr.danger("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                        $("#loader-wrapper").hide();
                    }
                });
            })
            $(".btn-device").click(function () {
                $(".main-panel").show();
                $(".extra-panel").hide();
            });
            $(".devices").addClass("active");
            $(".btn-lost-stolen").click(function () {
                $(".main-panel").hide();
                $(".extra-panel").show();
            });

        </script>
    </asp:Content>

