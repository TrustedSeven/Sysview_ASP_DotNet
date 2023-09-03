<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="false" CodeFile="Board.aspx.cs" Inherits="Admin_Board" EnableEventValidation="false" %>
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
                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="20pt" Text="Board"></asp:Label>
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
                                <asp:Label ID="Label89" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td><input type="datetime-local" name="MatchDate" id="MatchDate" runat="server"/></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label4" runat="server" Text="Away Team"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_at" runat="server" Width="253px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rv_sk0" runat="server" ControlToValidate="txt_at" ErrorMessage="Required" ForeColor="Red" ValidationGroup="valid"></asp:RequiredFieldValidator>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text="Home Team"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_ht" runat="server" Width="253px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rv_sk1" runat="server" ControlToValidate="txt_ht" ErrorMessage="Required" ForeColor="Red" ValidationGroup="valid"></asp:RequiredFieldValidator>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label90" runat="server" Text="Matchup Key"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_matchupkey" runat="server" Width="253px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rv_sk3" runat="server" ControlToValidate="txt_matchupkey" ErrorMessage="Required" ForeColor="Red" ValidationGroup="valid"></asp:RequiredFieldValidator>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label6" runat="server" Text="MoneyLineAway"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mla" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label7" runat="server" Text="MoneyLineAwayFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mlaf" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                <asp:Label ID="Label8" runat="server" Text="MoneyLineAwaySecond"></asp:Label>
                            </td>
                            <td class="auto-style1">
                                <asp:TextBox ID="txt_mlas" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label9" runat="server" Text="MoneyLineHome"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mlh" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label10" runat="server" Text="MoneyLineHomeFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mlhf" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label11" runat="server" Text="MoneyLineHomeSecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mlhs" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label12" runat="server" Text="SpreadAway"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_sa" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label13" runat="server" Text="SpreadAwayFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_saf" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label14" runat="server" Text="SpreadAwaySecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_sas" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label15" runat="server" Text="SpreadAwayOdds"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_sao" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label16" runat="server" Text="SpreadAwayOddsFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_saof" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label17" runat="server" Text="SpreadAwayOddsSecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_saos" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label18" runat="server" Text="SpreadHome"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_sh" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label19" runat="server" Text="SpreadHomeFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_shf" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label20" runat="server" Text="SpreadHomeSecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_shs" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label21" runat="server" Text="SpreadHomeOdds"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_sho" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label22" runat="server" Text="SpreadHomeOddsFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_shof" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label23" runat="server" Text="SpreadHomeOddsSecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_shos" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label24" runat="server" Text="Total"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_total" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label25" runat="server" Text="TotalUnder"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_totalUnder" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label26" runat="server" Text="TotalUnderFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_tuf" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label27" runat="server" Text="TotalUnderSecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_tus" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label28" runat="server" Text="TotalOver"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_tot_over" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label29" runat="server" Text="TotalOverFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_tot_over_first" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label30" runat="server" Text="TotalOverSecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_tot_over_second" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label34" runat="server" Text="MoneyLineFav"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mlf" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label35" runat="server" Text="MoneyLineFavFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mlff" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label36" runat="server" Text="MoneyLineFavSecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mlfs" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label37" runat="server" Text="MoneyLineDog"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mld" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label38" runat="server" Text="MoneyLineDogFirst"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mldf" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label39" runat="server" Text="MoneyLineDogSecond"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_mlds" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label40" runat="server" Text="WeatherForecast"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_wf" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label41" runat="server" Text="MatchupStatus"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_ms" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label42" runat="server" Text="IsCurrentWeek"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_is_cw" onkeypress="return isNumberKey(event)" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label43" runat="server" Text="AwayColor"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_awaycolor" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label47" runat="server" Text="HomeColor"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_homecolor" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label44" runat="server" Text="InjuryAway"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_inj_awy" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label45" runat="server" Text="InjuryHome"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_inj_home" runat="server" Width="253px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label46" runat="server" Text="Comments"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_commt" runat="server" Width="253px" Height="79px" TextMode="MultiLine"></asp:TextBox>
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
                                    <asp:Label ID="lbl_boardkey" runat="server" Text='<%# Eval("BoardKey") %>'></asp:Label>
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
                    <asp:DataList ID="DataList1" runat="server" CellPadding="4" CssClass="auto-style5" ForeColor="#333333" DataKeyField="BoardKey" OnDeleteCommand="DataList1_DeleteCommand" OnSelectedIndexChanged="DataList1_SelectedIndexChanged">
                        <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <ItemTemplate>
                            <table class="auto-style4">
                                <tr>
                                    
                                    <td>
                                        <asp:Label ID="Label48" runat="server" Text="FkSportKey="></asp:Label>
                                        <asp:Label ID="lbl_fk_sk" runat="server" Text='<%# Eval("fkSportKey") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label49" runat="server" Text="Date="></asp:Label>
                                        <asp:Label ID="lbl_date" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label50" runat="server" Text="IsCurrentWeek="></asp:Label>
                                        <asp:Label ID="lbl_Is_cw" runat="server" Text='<%# Eval("IsCurrentWeek") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_boardkey" runat="server" Text='<%# Eval("BoardKey") %>' Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="link_edit" runat="server" CommandName="select">Edit</asp:LinkButton>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:LinkButton ID="link_del" runat="server" CommandName="delete">Delete</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label51" runat="server" Text="AwayTeam="></asp:Label>
                                        <asp:Label ID="lbl_at" runat="server" Text='<%# Eval("AwayTeam") %>'></asp:Label>
                                    </td>
                                    <td>&nbsp;<asp:Label ID="Label52" runat="server" Text="MoneyLineAway="></asp:Label>
                                        <asp:Label ID="lbl_mla" runat="server" Text='<%# Eval("MoneyLineAway") %>'></asp:Label>
                                    </td>
                                    <td>&nbsp;<asp:Label ID="Label54" runat="server" Text="MoneyLineAwaySecond="></asp:Label>
                                        <asp:Label ID="lbl_mlas" runat="server" Text='<%# Eval("MoneyLineAwaySecond") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label53" runat="server" Text="MoneyLineAwayFirst="></asp:Label>
                                        <asp:Label ID="lbl_fk_mlaf" runat="server" Text='<%# Eval("MoneyLineAwayFirst") %>'></asp:Label>
                                    </td>
                                    <td></td>
                                </tr>
                               
                                <tr>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label55" runat="server" Text="HomeTeam="></asp:Label>
                                        <asp:Label ID="lbl_ht" runat="server" Text='<%# Eval("HomeTeam") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label56" runat="server" Text="MoneyLineHome="></asp:Label>
                                        <asp:Label ID="lbl_mlh" runat="server" Text='<%# Eval("MoneyLineHome") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label57" runat="server" Text="MoneyLineHomeFirst="></asp:Label>
                                        <asp:Label ID="lbl_mlhf" runat="server" Text='<%# Eval("MoneyLineHomeFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label58" runat="server" Text="MoneyLineHomeSecond="></asp:Label>
                                        <asp:Label ID="lbl_mlhs" runat="server" Text='<%# Eval("MoneyLineHomeSecond") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label32" runat="server" Text="MoneyLineFav="></asp:Label>
                                        <asp:Label ID="lbl_mlf" runat="server" Text='<%# Eval("MoneyLineFav") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label59" runat="server" Text="MoneyLineFavFirst="></asp:Label>
                                        <asp:Label ID="lbl_mlff" runat="server" Text='<%# Eval("MoneyLineFavFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label61" runat="server" Text="MoneyLineFavSecond="></asp:Label>
                                        <asp:Label ID="lbl_mlfs" runat="server" Text='<%# Eval("MoneyLineFavSecond") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label3" runat="server" Text="MoneyLineDog="></asp:Label>
                                        <asp:Label ID="lbl_mld" runat="server" Text='<%# Eval("MoneyLineDog") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label33" runat="server" Text="MoneyLineDogFirst="></asp:Label>
                                        <asp:Label ID="lbl_mldf" runat="server" Text='<%# Eval("MoneyLineDogFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label62" runat="server" Text="MoneyLineDogSecond="></asp:Label>
                                        <asp:Label ID="lbl_mlds" runat="server" Text='<%# Eval("MoneyLineDogSecond") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1"></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label31" runat="server" Text="SpreadAway="></asp:Label>
                                        <asp:Label ID="lbl_sa" runat="server" Text='<%# Eval("SpreadAway") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label63" runat="server" Text="SpreadAwayFirst="></asp:Label>
                                        <asp:Label ID="lbl_saf" runat="server" Text='<%# Eval("SpreadAwayFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label65" runat="server" Text="SpreadAwaySecond="></asp:Label>
                                        <asp:Label ID="lbl_sas" runat="server" Text='<%# Eval("SpreadAwaySecond") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label60" runat="server" Text="SpreadHome="></asp:Label>
                                        <asp:Label ID="lbl_sh" runat="server" Text='<%# Eval("SpreadHome") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label66" runat="server" Text="SpreadHomeFirst="></asp:Label>
                                        <asp:Label ID="lbl_shf" runat="server" Text='<%# Eval("SpreadHomeFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label68" runat="server" Text="SpreadHomeSecond="></asp:Label>
                                        <asp:Label ID="lbl_shs" runat="server" Text='<%# Eval("SpreadHomeSecond") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label64" runat="server" Text="SpreadAwayOdds="></asp:Label>
                                        <asp:Label ID="lbl_sao" runat="server" Text='<%# Eval("SpreadAwayOdds") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label69" runat="server" Text="SpreadAwayOddsFirst="></asp:Label>
                                        <asp:Label ID="lbl_saof" runat="server" Text='<%# Eval("SpreadAwayOddsFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label71" runat="server" Text="SpreadAwayOddsSecond="></asp:Label>
                                        <asp:Label ID="lbl_saos" runat="server" Text='<%# Eval("SpreadAwayOddsSecond") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1"></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label67" runat="server" Text="SpreadHomeOdds="></asp:Label>
                                        <asp:Label ID="lbl_sho" runat="server" Text='<%# Eval("SpreadHomeOdds") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label72" runat="server" Text="SpreadHomeOddsFirst="></asp:Label>
                                        <asp:Label ID="lbl_shof" runat="server" Text='<%# Eval("SpreadHomeOddsFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label74" runat="server" Text="SpreadHomeOddsSecond="></asp:Label>
                                        <asp:Label ID="lbl_shos" runat="server" Text='<%# Eval("SpreadHomeOddsSecond") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1"></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label70" runat="server" Text="Total="></asp:Label>
                                        <asp:Label ID="lbl_total" runat="server" Text='<%# Eval("Total") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label75" runat="server" Text="TotalUnder="></asp:Label>
                                        <asp:Label ID="lbl_tot_under" runat="server" Text='<%# Eval("TotalUnder") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label77" runat="server" Text="TotalUnderFirst="></asp:Label>
                                        <asp:Label ID="lbl_tot_under_first" runat="server" Text='<%# Eval("TotalUnderFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                         <asp:Label ID="Label73" runat="server" Text="TotalUnderSecond="></asp:Label>
                                        <asp:Label ID="lbl_tot_under_sec" runat="server" Text='<%# Eval("TotalUnderSecond") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                   <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label79" runat="server" Text="TotalOver="></asp:Label>
                                        <asp:Label ID="lbl_tot_ov" runat="server" Text='<%# Eval("TotalOver") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label81" runat="server" Text="TotalOverFirst="></asp:Label>
                                        <asp:Label ID="lbl_tot_ov_f" runat="server" Text='<%# Eval("TotalOverFirst") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                         <asp:Label ID="Label83" runat="server" Text="TotalOverSecond="></asp:Label>
                                        <asp:Label ID="lbl_tot_ov_sec" runat="server" Text='<%# Eval("TotalOverSecond") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label88" runat="server" Text="AwayColor="></asp:Label>
                                        <asp:Label ID="lbl_awy_col" runat="server" Text='<%# Eval("AwayColor") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label76" runat="server" Text="InjuryAway="></asp:Label>
                                        <asp:Label ID="lbl_inj_awy" runat="server" Text='<%# Eval("InjuryAway") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        
                                    </td>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        
                                    </td>
                                </tr>
                                <tr>
                                   <td class="auto-style1">
                                        <asp:Label ID="Label78" runat="server" Text="HomeColor="></asp:Label>
                                        <asp:Label ID="lbl_home_col" runat="server" Text='<%# Eval("HomeColor") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:Label ID="Label82" runat="server" Text="InjuryHome="></asp:Label>
                                        <asp:Label ID="lbl_Inj_home" runat="server" Text='<%# Eval("InjuryHome") %>'></asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        
                                    </td>
                                    <td class="auto-style1">
                                       
                                    </td>
                                    <td class="auto-style1">
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">
                                        
                                    </td>
                                    <td class="auto-style1" colspan="4">
                                        <asp:Label ID="Label85" runat="server" Text="Comments="></asp:Label>
                                        <asp:Label ID="lbl_cmt" runat="server" Text='<%# Eval("Comments") %>'></asp:Label>
                                    </td>
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
