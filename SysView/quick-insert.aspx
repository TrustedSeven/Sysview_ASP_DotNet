<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="quick-insert.aspx.cs" Inherits="QuickInsert" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
         <div class="container-fluid">
            <div class="row align-items-center pt-30">
                <div class="col-md-12 mr-auto ml-auto">
                    <div class="mb-0">
                        <h4>Quick Insert</h4>
                        <p>Use this form to quickly insert devices into the database. You must insert the Asset Tag and Serial Number</p>
                    </div>
                </div>
            </div>

        </div>
        <div class="container-fluid">
                 <div class="portlet-box portlet-gutter ui-buttons-col mb-30">
                    <div class="portlet-header flex-row flex d-flex align-items-center b-b">
                        <div class="flex d-flex flex-column">
                            <h3>Insert detail info</h3> 
                        </div>
                    </div>
                    <div class="portlet-body">
                        <form id="form1" class="quick-insert-form">
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Make</label>
                                <div class="col-sm-10">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input make" type="radio" name="make" id="dell" value="Dell" checked/>
                                        <label class="form-check-label" for="dell">Dell</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input make" type="radio" name="make" id="acer" value="Acer" />
                                        <label class="form-check-label" for="acer">Acer</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input make" type="radio" name="make" id="hp" value="Hp" />
                                        <label class="form-check-label" for="hp">HP</label>
                                    </div>

                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-sm-2 pt-0">Model</label>
                                <div class="col-sm-10">
									<select class="form-control model" name="model" id="model">
                                        <option value="Chromebook">Chromebook</option>
                                        <option value="Elitebook">Elitebook</option>
									</select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-sm-2 pt-0">Type</label>
                                <div class="col-sm-10">
									<select class="form-control type" name="invType" id="invType">
                                        <option value="3110">3110</option>
                                        <option value="3100">3100</option>
                                        <option value="C740">C740</option>
                                        <option value="C732">C732</option>
                                        <option value="C8315">C8315</option>
                                        <option value="C721">C721</option>
									</select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="AssetTag" class="col-sm-2 col-form-label">AssetTag</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control AssetTag" id="AssetTag" name="AssetTag" required="required" autofocus/>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="SerialNum" class="col-sm-2 col-form-label">Serial Number</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control SerialNum" id="SerialNum" name="SerialNum" required="required" autofocus/>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-2"></div>
                                <div class="col-sm-2">
                                    <button type="button" class="btn btn-primary btn-block btn-assets-quick-insert">Insert</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
        </div>
        <div class="container-fluid">
            <div class="bg-white table-responsive rounded shadow-sm p-3 mb-30">
                <h6 class="pr-3 text-capitalize font400 mb-20">List</h6>
                <table id="data-table" class="table-compact mb-0 table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>Make</th>
                            <th>Model</th>
                            <th>Type</th>
                            <th>Serial Num</th>
                            <th>Asset Tag</th>
                        </tr>
                    </thead>
                    <tbody id="Assetslist">
                    </tbody>
                </table>
            </div>
        </div>
        <!-- <script type="text/javascript" src="lib/data-tables/jquery.dataTables.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.bootstrap4.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/dataTables.responsive.min.js"></script> 
        <script type="text/javascript" src="lib/data-tables/responsive.bootstrap4.min.js"></script> 
        <script src="js/plugins-custom/datatables-custom.js"></script> -->
        <script>
            $(".btn-assets-quick-insert").click(function () {
                var make = $(".make:checked").val();
                var model = $("#model").val();
                var invType = $("#invType").val();
                var assetTag = $("#AssetTag").val();
                var serialNum = $("#SerialNum").val();
                if (serialNum != "") {
                    $("#loader-wrapper").show();
                    $.ajax({
                        type: "POST",
                        url: "quick-insert.aspx/addAssets",
                        data: JSON.stringify({
                            make: make,
                            model: model,
                            invType: invType,
                            AssetTag: assetTag,
                            serialNum: serialNum
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            $("#loader-wrapper").hide();
                            toastr.success("Asset inserted");
                            $("tbody#Assetslist").append("<tr><td>" + make + "</td><td>" + invType + "</td><td>" + assetTag + "</td><td>" + serialNum + "</td></tr>");
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            console.log(errorThrown);
                            toastr.error("Error inserting asset. Please contact support");
                            $("#loader-wrapper").hide();
                        }
                    });
                } else {
                    alert("Please insert serial number");
                }
            });

        </script>
    </asp:Content>

