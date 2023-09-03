<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="quick-assign.aspx.cs" Inherits="QuickAssign" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <style>
            .studentRow:hover {
                cursor:pointer;
            }
            .selectedRow {
                background: #7a7c93 !important;
                color: white;
            }

            .btn-quick-assign {
                margin: 5px 10px 0 0;
            }

        </style>
         <div class="container-fluid">
            <div class="row align-items-center mb-30 pt-30">
                <div class="col-md-12 mr-auto ml-auto">
                    <div class="mb-0">

                        <h4>Quick Assign</h4>
                        <p>Select a teacher from the drop-down below, then select a student to assign a device.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="list border1 rounded overflow-hidden">
                        <div class="list-item">
                            <div class="list-thumb bg-primary text-primary-light avatar rounded-circle avatar60 shadow-sm">
                                
                                <i class="fas fa-user"></i>
                            </div>
                            <label>Select a Teacher
                                <select id="Teacherlist" runat="server" onchange="handleSelectChange()">                
                                </select>
                            </label>
                        </div>
                    </div>


        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6">
                    <div class="bg-white table-responsive rounded shadow-sm pt-3 pb-3 mb-30">
                        <h6 class="pl-3 pr-3 text-capitalize font400 mb-20">Student list</h6>
               
                
                        <table id="data-table" class="mb-0 table-striped" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>Email</th>
                                    <th>Grade</th>
                                    <th>Teacher</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id="Studentlist" runat="server">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="bg-white table-responsive rounded shadow-sm pt-3 pb-3 mb-30">
                        <h6 class="pl-3 pr-3 text-capitalize font400 mb-20">Device list</h6>
                          <table id="data-table-device" class="mb-0 table-striped" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>Model</th>
                                    <th>Serial</th>
                                    <%--<th>Last User</th>--%>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id="Devicelist" runat="server">
                            </tbody>
                        </table>
                         <button class='float-right btn btn-info btn-quick-assign'>
                            Assign
                        </button>
                    </div>
                </div>
            </div>
        </div>

        
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Select Device</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <div class="row justify-content-center">     
        <p>Scan or enter a serial number</p>
        <input id="search" class="form-control ml-sm-4 mr-sm-4" type="search" placeholder="Serial Number" aria-label="Search"/>       
         <table id="data-table-device-modal" class="mb-0 table-striped" cellspacing="0" width="100%" style="display:none;">
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Serial</th> 
                            <th>AssetTag</th>
                            <th>Status</th>
                            <th>Assign</th>
                        </tr>
                    </thead>
                    <tbody id="DeviceModal" runat="server">
                    </tbody>
                </table>
        </div>
      </div>
      <div class="modal-footer">
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
            //const { select } = require("d3-selection");
             var myInput = document.getElementById("search");
             var keysPressed = [];
             const modal_assign = document.querySelector(".btn-quick-assign-modal");
             myInput.addEventListener("keydown", function (event) {
                 keysPressed.push(event.key);
                 keystring = keysPressed.join("");
                // console.log("Keys pressed:", keysPressed);
                 //console.log(keystring);
                 var modal_table = document.getElementById("data-table-device-modal");
                 modal_table.style.display = "table";
                 var table = $('#data-table-device-modal').DataTable();                 
                 table.search(this.value).draw();
                

             });
        
            $(document).ready(function () {
                 $('#data-table-device').DataTable({});
                $('#myModal').on('shown.bs.modal', function () {
                    
                    $('#search').val('');
                     $('#search').focus();
                 });
                 $('#myModal').on('hidden.bs.modal', function () {
                     var modal_table = document.getElementById("data-table-device-modal");
                     modal_table.style.display = "none";                    
                    
                 });
               
               
             });
            var studentKey = "";
             var inventoryKey = "";
             modal_assign.addEventListener("click", function () {
               
             })


            $(".student").addClass("active");
            $(".studentRow").click(function () {
                $(".studentRow").removeClass("selectedRow");
                $(this).addClass("selectedRow");
                $('#myModal').modal('show');            
                studentKey = $(this).data("studentkey");
                var $nextTDs = $(this).find('td:nth-child(1), td:nth-child(2)');
                var text1 = $nextTDs.eq(0).text();
                var text2 = $nextTDs.eq(1).text();
                $("#myModalLabel").text("Select Device For " + text1 + " " + text2 + " (" + studentKey + ")");
            });
           
             $(".invRow").click(function () {
                $(".invRow").removeClass("selectedRow");
                $(this).addClass("selectedRow");
                 inventoryKey = $(this).data("inventorykey");                
              
             });
            
                    
             $(".btn-quick-assign-modal").click(function () {
                 $(".selectedRow").off('click');
                 $(".selectedRow").css('background-color', 'green');
                 $(".invRow").removeClass("selectedRow");
                 $(this).closest('tr').addClass("selectedRow");
                 let dom = $(this).parents('tr').children().eq(3).children();

                 dom.removeClass("text-secondary-light");
                 dom.removeClass("badge-secondary");
                 dom.addClass("text-info-light");
                 dom.addClass("badge-info");
                 dom.text("In Use");
                 inventoryKey = $(this).closest('tr').data('inventorykey');
                 var valid = true;
                 if (studentKey == "" && inventoryKey != "") {
                     alert("Please select one student.");
                     valid = false;
                 }
                 if (studentKey != "" && inventoryKey == "") {
                     alert("Please select one device.");
                     valid = false;
                 }
                 if (studentKey == "" && inventoryKey == "") {
                     valid = false;
                     alert("Please select one student and one device.");
                 }

                 if (valid) {
                     $(".btn-quick-assign").attr("disabled", "disabled");
                     $(".btn-quick-assign").text("Updating...");
                     $.ajax({
                         type: "POST",
                         url: "quick-assign.aspx/quick_assign",
                         data: JSON.stringify({
                             studentKey: studentKey,
                             inventoryKey: inventoryKey
                         }),
                         contentType: "application/json; charset=utf-8",
                         dataType: "json",
                         success: function (response) {
                             var stud = studentKey;
                             var inv = inventoryKey;
                             $(".btn-quick-assign").removeAttr("disabled");
                             $(".btn-quick-assign").text("Assign");
                             studentKey = "";
                             inventoryKey = "";
                             $(".selectedRow").removeClass("selectedRow");
                             toastr.success("Student ID " + stud + " assigned Device ID " + inv + " successfully.");
                            ('#myModal').modal('hide');
                         },
                         error: function (XMLHttpRequest, textStatus, errorThrown) {
                             console.log(errorThrown);
                             toastr.error("Error assigning record. Contact your administrator (modal assign data missing");
                         }

                     });
                 }

             })
            $(".btn-quick-assign").click(function () {
                var valid = true;
                if (studentKey == "" && inventoryKey != "") {
                    alert("Please select one student.");
                    valid = false;
                }
                if (studentKey != "" && inventoryKey == "") {
                    alert("Please select one device.");
                    valid = false;
                }
                if (studentKey == "" && inventoryKey == "") {
                    valid = false;
                    alert("Please select one student and one device.");
                }

                if (valid) {
                    $(".btn-quick-assign").attr("disabled", "disabled");
                    $(".btn-quick-assign").text("Updating...");
                    $.ajax({
                        type: "POST",
                        url: "quick-assign.aspx/quick_assign",
                        data: JSON.stringify({
                            studentKey: studentKey,
                            inventoryKey: inventoryKey
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                             var stud = studentKey;
                             var inv = inventoryKey;
                            $(".btn-quick-assign").removeAttr("disabled");
                            $(".btn-quick-assign").text("Assign");
                            studentKey = "";
                            inventoryKey = "";
                            $(".selectedRow").removeClass("selectedRow");
                            toastr.success("Device ID " + inv + " assigned successfully.");
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            console.log(errorThrown);
                            toastr.error("Error assigning record. Conact your administrator (quick assign data missing)");
                        }

                    });
                }

            });

             function handleSelectChange() {
                 var table = $('#data-table').DataTable();
                 table.page.len(50).draw();

                 var selectedValue = document.getElementById("ContentPlaceHolder1_Teacherlist").value;
                 console.log(selectedValue);
                 table.column(4).search(selectedValue).draw();
                 // Do something with the selected value
                 // For example, display it in an alert box
             }
         </script>
      
    </asp:Content>

