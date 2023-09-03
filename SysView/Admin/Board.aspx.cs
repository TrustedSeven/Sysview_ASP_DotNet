using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;

public partial class Admin_Board : System.Web.UI.Page
{
    //GamblersDenCode GamblerCode = new GamblersDenCode();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
    SqlCommand cmd;
    SqlDataReader rdr;
    SqlDataAdapter adp = new SqlDataAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["Admin"]) == "" || Session["Admin"]==null)
        {
            Response.Redirect("LogIn.aspx");
        }
       
        if (!Page.IsPostBack)
        {
            var localDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm").Replace(' ', 'T');
            MatchDate.Value = localDateTime;
            conn.Open();

            SqlCommand com = new SqlCommand("select * from Sports", conn);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ddl_sportkey.DataTextField = ds.Tables[0].Columns["SportName"].ToString();
            ddl_sportkey.DataValueField = ds.Tables[0].Columns["SportKey"].ToString();
            ddl_sportkey.DataSource = ds.Tables[0];
            ddl_sportkey.DataBind();

            conn.Close();
            Griddata();
            DataListFill();
        }
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
        string sid = ddl_sportkey.SelectedValue.ToString();
        if (btn_save.Text == "Save")
        {
            //GamblerCode.InsertBoard(ddl_sportkey.SelectedValue.ToString(),MatchDate.Value.ToString(), txt_at.Text, txt_ht.Text, txt_mla.Text, txt_mlaf.Text, txt_mlas.Text, txt_mlh.Text, txt_mlhf.Text, txt_mlhs.Text, txt_sa.Text, txt_saf.Text, txt_sas.Text, txt_sao.Text, txt_saof.Text, txt_saos.Text, txt_sh.Text, txt_shf.Text, txt_shs.Text, txt_sho.Text, txt_shof.Text, txt_shos.Text, txt_total.Text, txt_totalUnder.Text, txt_tuf.Text, txt_tus.Text, txt_tot_over.Text, txt_tot_over_first.Text, txt_tot_over_second.Text, txt_mlf.Text, txt_mlff.Text, txt_mlfs.Text, txt_mld.Text, txt_mldf.Text, txt_mlds.Text, txt_wf.Text, txt_ms.Text, txt_is_cw.Text, txt_awaycolor.Text, txt_homecolor.Text, txt_inj_awy.Text, txt_inj_home.Text, txt_commt.Text,txt_matchupkey.Text);
           
            //Response.Write("<script LANGUAGE='JavaScript' >alert('"+GamblerCode.message+"')</script>");
            EmptyTextBoxes(this);
        }
        else if (btn_save.Text == "Update")
        {
            //GamblerCode.UpdateBoard(lbl_bid.Text,ddl_sportkey.SelectedValue.ToString(), MatchDate.Value.ToString(), txt_at.Text, txt_ht.Text, txt_mla.Text, txt_mlaf.Text, txt_mlas.Text, txt_mlh.Text, txt_mlhf.Text, txt_mlhs.Text, txt_sa.Text, txt_saf.Text, txt_sas.Text, txt_sao.Text, txt_saof.Text, txt_saos.Text, txt_sh.Text, txt_shf.Text, txt_shs.Text, txt_sho.Text, txt_shof.Text, txt_shos.Text, txt_total.Text, txt_totalUnder.Text, txt_tuf.Text, txt_tus.Text, txt_tot_over.Text, txt_tot_over_first.Text, txt_tot_over_second.Text, txt_mlf.Text, txt_mlff.Text, txt_mlfs.Text, txt_mld.Text, txt_mldf.Text, txt_mlds.Text, txt_wf.Text, txt_ms.Text, txt_is_cw.Text, txt_awaycolor.Text, txt_homecolor.Text, txt_inj_awy.Text, txt_inj_home.Text, txt_commt.Text,txt_matchupkey.Text);
           
            Response.Write("<script LANGUAGE='JavaScript'>alert('Data Updated Successfully')</script>");
            EmptyTextBoxes(this);
            
            btn_save.Text = "Save";
           
        }
    }
        public void EmptyTextBoxes(Control parent)
        {
            foreach (Control c in parent.Controls)
            {
                if ((c.GetType() == typeof(TextBox)))
                {
                    //Textbox t1=(Textbox)(C);
                    //t1.Text="";
                    ((TextBox)(c)).Text = "";
                }
                //if ((c.GetType() == typeof(DropDownList)))
                //{
                //    ((DropDownList)(c)).SelectedIndex = 0;
                //}
                if ((c.GetType() == typeof(Image)))
                {
                    ((Image)(c)).ImageUrl = "";

                }

                if (c.HasControls())
                {

                    EmptyTextBoxes(c);
                }
            }

        }
    public void Griddata()
    {
        SqlCommand cmd = new SqlCommand("select * from Board", conn);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
    }
    public void DataListFill()
    {
        SqlCommand cmd = new SqlCommand("select * from Board order by BoardKey desc", conn);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        DataList1.DataSource = ds;
        DataList1.DataBind();
        
    }

    protected void lnk_pro_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        EmptyTextBoxes(this);
        
        btn_save.Text = "Save";
        
        
    }

    protected void lnk_view_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 2;
        Griddata();
        DataListFill();
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Label boardkey = (Label)GridView1.SelectedRow.FindControl("lbl_boardkey");
        conn.Open();
        cmd = new SqlCommand("select * from Board where BoardKey=@BoardKey", conn);
        cmd.Parameters.AddWithValue("@BoardKey", boardkey.Text);
       
        rdr = cmd.ExecuteReader();
        if (rdr.Read())
        {
            lbl_bid.Text = boardkey.Text;
            ddl_sportkey.SelectedValue = rdr["fkSportKey"].ToString();
           txt_at.Text=rdr["AwayTeam"].ToString();
             txt_ht.Text = rdr["HomeTeam"].ToString();
             txt_mla.Text = rdr["MoneyLineAway"].ToString();
             txt_mlaf.Text = rdr["MoneyLineAwayFirst"].ToString();
            txt_mlas.Text = rdr["MoneyLineAwaySecond"].ToString();
             txt_mlh.Text = rdr["MoneyLineHome"].ToString();
             txt_mlhf.Text = rdr["MoneyLineHomeFirst"].ToString();
             txt_mlhs.Text = rdr["MoneyLineHomeSecond"].ToString();
            txt_sa.Text = rdr["SpreadAway"].ToString();
             txt_saf.Text = rdr["SpreadAwayFirst"].ToString();
             txt_sas.Text = rdr["SpreadAwaySecond"].ToString();
             txt_sao.Text = rdr["SpreadAwayOdds"].ToString();
             txt_saof.Text = rdr["SpreadAwayOddsFirst"].ToString();
             txt_saos.Text = rdr["SpreadAwayOddsSecond"].ToString();
             txt_sh.Text = rdr["SpreadHome"].ToString();
           txt_shf.Text = rdr["SpreadHomeFirst"].ToString();
             txt_shs.Text = rdr["SpreadHomeSecond"].ToString();
            txt_sho.Text = rdr["SpreadHomeOdds"].ToString();
             txt_shof.Text = rdr["SpreadHomeOddsFirst"].ToString();
            txt_shos.Text = rdr["SpreadHomeOddsSecond"].ToString();
             txt_total.Text = rdr["Total"].ToString();
             txt_totalUnder.Text = rdr["TotalUnder"].ToString();
            txt_tuf.Text = rdr["TotalUnderFirst"].ToString();
             txt_tus.Text = rdr["TotalUnderSecond"].ToString();
             txt_tot_over.Text = rdr["TotalOver"].ToString();
             txt_tot_over_first.Text = rdr["TotalOverFirst"].ToString();
             txt_tot_over_second.Text = rdr["TotalOverSecond"].ToString();

             txt_mlf.Text = rdr["MoneyLineFav"].ToString();
             txt_mlff.Text = rdr["MoneyLineFavFirst"].ToString();
             txt_mlfs.Text = rdr["MoneyLineFavSecond"].ToString();
             txt_mld.Text = rdr["MoneyLineDog"].ToString();
            txt_mldf.Text = rdr["MoneyLineDogFirst"].ToString();
             txt_mlds.Text = rdr["MoneyLineDogSecond"].ToString();
             txt_wf.Text = rdr["WeatherForecast"].ToString();
             txt_ms.Text = rdr["MatchupStatus"].ToString();
            txt_is_cw.Text = rdr["IsCurrentWeek"].ToString();
             txt_awaycolor.Text = rdr["AwayColor"].ToString();
            txt_homecolor.Text = rdr["HomeColor"].ToString();
            txt_inj_awy.Text = rdr["InjuryAway"].ToString();
             txt_inj_home.Text = rdr["InjuryHome"].ToString();
           txt_commt.Text = rdr["Comments"].ToString();
            txt_matchupkey.Text = rdr["MatchupKey"].ToString();
            rdr.Close();
            MultiView1.ActiveViewIndex = 0;
            
            btn_save.Text = "Update";
        }
        conn.Close();

    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        Label l1 = (Label)GridView1.Rows[e.RowIndex].FindControl("lbl_boardkey");
        conn.Open();
        cmd = new SqlCommand("delete from Board where BoardKey=@BoardKey", conn);
        cmd.Parameters.AddWithValue("@BoardKey", l1.Text);
        cmd.ExecuteNonQuery();
        conn.Close();
        Griddata();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        Griddata();
    }

    protected void Link_logout_Click(object sender, EventArgs e)
    {
        Session["Admin"] = null;
        Response.Redirect("LogIn.aspx");
    }

    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Label boardkey = (Label)DataList1.SelectedItem.FindControl("lbl_boardkey");

        
        conn.Open();
        cmd = new SqlCommand("select * from Board where BoardKey=@BoardKey", conn);
        cmd.Parameters.AddWithValue("@BoardKey", boardkey.Text);

        rdr = cmd.ExecuteReader();
        if (rdr.Read())
        {
            lbl_bid.Text = boardkey.Text;
            ddl_sportkey.SelectedValue = rdr["fkSportKey"].ToString();
            txt_at.Text = rdr["AwayTeam"].ToString();
            txt_ht.Text = rdr["HomeTeam"].ToString();
            txt_mla.Text = rdr["MoneyLineAway"].ToString();
            txt_mlaf.Text = rdr["MoneyLineAwayFirst"].ToString();
            txt_mlas.Text = rdr["MoneyLineAwaySecond"].ToString();
            txt_mlh.Text = rdr["MoneyLineHome"].ToString();
            txt_mlhf.Text = rdr["MoneyLineHomeFirst"].ToString();
            txt_mlhs.Text = rdr["MoneyLineHomeSecond"].ToString();
            txt_sa.Text = rdr["SpreadAway"].ToString();
            txt_saf.Text = rdr["SpreadAwayFirst"].ToString();
            txt_sas.Text = rdr["SpreadAwaySecond"].ToString();
            txt_sao.Text = rdr["SpreadAwayOdds"].ToString();
            txt_saof.Text = rdr["SpreadAwayOddsFirst"].ToString();
            txt_saos.Text = rdr["SpreadAwayOddsSecond"].ToString();
            txt_sh.Text = rdr["SpreadHome"].ToString();
            txt_shf.Text = rdr["SpreadHomeFirst"].ToString();
            txt_shs.Text = rdr["SpreadHomeSecond"].ToString();
            txt_sho.Text = rdr["SpreadHomeOdds"].ToString();
            txt_shof.Text = rdr["SpreadHomeOddsFirst"].ToString();
            txt_shos.Text = rdr["SpreadHomeOddsSecond"].ToString();
            txt_total.Text = rdr["Total"].ToString();
            txt_totalUnder.Text = rdr["TotalUnder"].ToString();
            txt_tuf.Text = rdr["TotalUnderFirst"].ToString();
            txt_tus.Text = rdr["TotalUnderSecond"].ToString();
            txt_tot_over.Text = rdr["TotalOver"].ToString();
            txt_tot_over_first.Text = rdr["TotalOverFirst"].ToString();
            txt_tot_over_second.Text = rdr["TotalOverSecond"].ToString();

            txt_mlf.Text = rdr["MoneyLineFav"].ToString();
            txt_mlff.Text = rdr["MoneyLineFavFirst"].ToString();
            txt_mlfs.Text = rdr["MoneyLineFavSecond"].ToString();
            txt_mld.Text = rdr["MoneyLineDog"].ToString();
            txt_mldf.Text = rdr["MoneyLineDogFirst"].ToString();
            txt_mlds.Text = rdr["MoneyLineDogSecond"].ToString();
            txt_wf.Text = rdr["WeatherForecast"].ToString();
            txt_ms.Text = rdr["MatchupStatus"].ToString();
            txt_is_cw.Text = rdr["IsCurrentWeek"].ToString();
            txt_awaycolor.Text = rdr["AwayColor"].ToString();
            txt_homecolor.Text = rdr["HomeColor"].ToString();
            txt_inj_awy.Text = rdr["InjuryAway"].ToString();
            txt_inj_home.Text = rdr["InjuryHome"].ToString();
            txt_commt.Text = rdr["Comments"].ToString();
            txt_matchupkey.Text = rdr["MatchupKey"].ToString();
            var matchdate =Convert.ToDateTime(rdr["Date"].ToString());
            MatchDate.Value = matchdate.ToString("yyyy-MM-dd HH:mm:ss").Replace(' ', 'T');
            rdr.Close();
            MultiView1.ActiveViewIndex = 0;

            btn_save.Text = "Update";
        }
        conn.Close();

    }

    protected void DataList1_DeleteCommand(object source, DataListCommandEventArgs e)
    {
       
        int id = Convert.ToInt16(DataList1.DataKeys[e.Item.ItemIndex].ToString());
       
        conn.Open();
        cmd = new SqlCommand("delete from Board where BoardKey=@BoardKey", conn);
        cmd.Parameters.AddWithValue("@BoardKey", id);
        cmd.ExecuteNonQuery();
        conn.Close();
        DataListFill();
    }

    
    
}