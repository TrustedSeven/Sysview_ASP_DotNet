<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="false" CodeFile="contestadmin.aspx.cs" Inherits="ContestAdmin" EnableEventValidation="false" %>
<script type="text/javascript">
 
 
      function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57)) {
             alert("Please Enter Only Numeric Value:");
             return false;
         }
 
         return true;
      }
 
   </script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
        .auto-style2 {
            width: 100%;
            height: 288px;
        }
        .auto-style4 {
            width: 100%;
            border-collapse: collapse;
        }
        .auto-style4 td {
    border: 1px solid #eee;
    padding: 3px;
}
        table#DataList1 tbody tr:nth-child(n + 1) {
    border-bottom: 1px solid #000;
}
        .auto-style5 {
            margin-right: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:LinkButton ID="lnk_board" runat="server" OnClick="lnk_pro_Click">Add New</asp:LinkButton>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="lnk_view" runat="server" OnClick="lnk_view_Click">View Data</asp:LinkButton>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="Link_logout" runat="server" OnClick="Link_logout_Click">LogOut</asp:LinkButton>
            <br />
            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                <asp:View ID="View1" runat="server">
                    <table style="width:100%;">
                        <tr>
                            <td>
                                <asp:Label ID="lbl_bid" runat="server" Visible="False"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="20pt" Text="Contest Admin"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" Text="Sport Key"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddl_sportkey" runat="server" AutoPostBack="True" Height="42px" Width="253px">
                                    <asp:ListItem>--Select Sport Name--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rv_sk2" runat="server" ControlToValidate="ddl_sportkey" ErrorMessage="Please Select Sport Name" ForeColor="Red" InitialValue="--Select Sport Name--" ValidationGroup="valid"></asp:RequiredFieldValidator>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label80" runat="server" Text="Contest Type"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlContestType" runat="server" AutoPostBack="True" Height="42px" Width="253px">
                                    <asp:ListItem>--Select Contest Type--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rv_contestType" runat="server" ControlToValidate="ddlContestType" ErrorMessage="Please Select Sport Name" ForeColor="Red" InitialValue="--Select Contest Type--" ValidationGroup="valid"></asp:RequiredFieldValidator>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label89" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td><input type="datetime-local" name="ContestDate" id="ContestDate" runat="server"/></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label4" runat="server" Text="Contest Name"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtContestName" runat="server" Width="253px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rv_sk0" runat="server" ControlToValidate="txtContestName" ErrorMessage="Required" ForeColor="Red" ValidationGroup="valid"></asp:RequiredFieldValidator>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btn_save" runat="server" Height="40px" Text="Save" Width="101px" OnClick="btn_save_Click" ValidationGroup="valid" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="View2" runat="server">
                    <div style="overflow-x: scroll" class="auto-style2">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" PageSize="8">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="glink_edit" runat="server" CommandName="select">Edit</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="link_del" runat="server" CommandName="delete">Delete</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Board_Id" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_contestkey" runat="server" Text='<%# Eval("ContestKey") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SortedAscendingCellStyle BackColor="#EDF6F6" />
                        <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                        <SortedDescendingCellStyle BackColor="#D6DFDF" />
                        <SortedDescendingHeaderStyle BackColor="#002876" />
                    </asp:GridView>
                        </div>
                </asp:View>
                <asp:View ID="View3" runat="server">
                    <asp:DataList ID="DataList1" runat="server" CellPadding="4" CssClass="auto-style5" ForeColor="#333333" DataKeyField="ContestKey" OnDeleteCommand="DataList1_DeleteCommand" OnSelectedIndexChanged="DataList1_SelectedIndexChanged">
                        <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <ItemTemplate>
                            <table class="auto-style4">
                                <tr>
                                     <td>
                                        <asp:Label ID="Label49" runat="server" Text="Date="></asp:Label>
                                        <asp:Label ID="lbl_date" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text="ContestName="></asp:Label>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("ContestName") %>'></asp:Label>
                                    </td>                                   
                                    <td>
                                        <asp:Label ID="Label48" runat="server" Text="FkSportKey="></asp:Label>
                                        <asp:Label ID="lbl_fk_sk" runat="server" Text='<%# Eval("fkSportKey") %>'></asp:Label>
                                    </td>


                                    <td class="auto-style1"></td>
                                </tr>
                                
                            </table>
                            
                        </ItemTemplate>
                        <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    </asp:DataList>
                </asp:View>
               
            </asp:MultiView>
        </div>
    </form>
</body>
</html>
