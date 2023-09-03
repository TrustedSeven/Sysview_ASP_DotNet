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

public partial class ContestAdmin : System.Web.UI.Page
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
            ContestDate.Value = localDateTime;
            conn.Open();

            // FILL SPORTS TYPES
            SqlCommand com = new SqlCommand("select * from Sports", conn);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ddl_sportkey.DataTextField = ds.Tables[0].Columns["SportName"].ToString();
            ddl_sportkey.DataValueField = ds.Tables[0].Columns["SportKey"].ToString();
            ddl_sportkey.DataSource = ds.Tables[0];
            ddl_sportkey.DataBind();

            // FILL CONTEST TYPES
            com = new SqlCommand("select * from ContestTypes", conn);
            da = new SqlDataAdapter(com);
            ds = new DataSet();
            da.Fill(ds);
            ddlContestType.DataTextField = ds.Tables[0].Columns["ContestType"].ToString();
            ddlContestType.DataValueField = ds.Tables[0].Columns["ContestTypeKey"].ToString();
            ddlContestType.DataSource = ds.Tables[0];
            ddlContestType.DataBind();

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
            //GamblerCode.InsertBoard(ddl_sportkey.SelectedValue.ToString(),ContestDate.Value.ToString(), txtContestName.Text, txt_ht.Text, txt_mla.Text, txt_mlaf.Text, txt_mlas.Text, txt_mlh.Text, txt_mlhf.Text, txt_mlhs.Text, txt_sa.Text, txt_saf.Text, txt_sas.Text, txt_sao.Text, txt_saof.Text, txt_saos.Text, txt_sh.Text, txt_shf.Text, txt_shs.Text, txt_sho.Text, txt_shof.Text, txt_shos.Text, txt_total.Text, txt_totalUnder.Text, txt_tuf.Text, txt_tus.Text, txt_tot_over.Text, txt_tot_over_first.Text, txt_tot_over_second.Text, txt_mlf.Text, txt_mlff.Text, txt_mlfs.Text, txt_mld.Text, txt_mldf.Text, txt_mlds.Text, txt_wf.Text, txt_ms.Text, txt_is_cw.Text, txt_awaycolor.Text, txt_homecolor.Text, txt_inj_awy.Text, txt_inj_home.Text, txt_commt.Text,txt_matchupkey.Text);
           
            //Response.Write("<script LANGUAGE='JavaScript' >alert('"+GamblerCode.message+"')</script>");
            EmptyTextBoxes(this);
        }
        else if (btn_save.Text == "Update")
        {
            //GamblerCode.UpdateBoard(lbl_bid.Text,ddl_sportkey.SelectedValue.ToString(), ContestDate.Value.ToString(), txtContestName.Text, txt_ht.Text, txt_mla.Text, txt_mlaf.Text, txt_mlas.Text, txt_mlh.Text, txt_mlhf.Text, txt_mlhs.Text, txt_sa.Text, txt_saf.Text, txt_sas.Text, txt_sao.Text, txt_saof.Text, txt_saos.Text, txt_sh.Text, txt_shf.Text, txt_shs.Text, txt_sho.Text, txt_shof.Text, txt_shos.Text, txt_total.Text, txt_totalUnder.Text, txt_tuf.Text, txt_tus.Text, txt_tot_over.Text, txt_tot_over_first.Text, txt_tot_over_second.Text, txt_mlf.Text, txt_mlff.Text, txt_mlfs.Text, txt_mld.Text, txt_mldf.Text, txt_mlds.Text, txt_wf.Text, txt_ms.Text, txt_is_cw.Text, txt_awaycolor.Text, txt_homecolor.Text, txt_inj_awy.Text, txt_inj_home.Text, txt_commt.Text,txt_matchupkey.Text);
           
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
        SqlCommand cmd = new SqlCommand("select * from Contests WHERE ContestStatusID = 1 ORDER BY Date ASC", conn);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
    }
    public void DataListFill()
    {
        SqlCommand cmd = new SqlCommand("select * from Contests WHERE ContestStatusID = 1 ORDER BY Date ASC", conn);
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
        Label contestkey = (Label)GridView1.SelectedRow.FindControl("lbl_contestkey");
        conn.Open();
        cmd = new SqlCommand("select * from Contests where ContestKey=@ContestKey", conn);
        cmd.Parameters.AddWithValue("@ContestKey", contestkey.Text);
       
        rdr = cmd.ExecuteReader();
        if (rdr.Read())
        {
            lbl_bid.Text = contestkey.Text;
            ddl_sportkey.SelectedValue = rdr["fkSportKey"].ToString();
            ddlContestType.SelectedValue = rdr["ContestTypeKey"].ToString();
            txtContestName.Text=rdr["ContestName"].ToString();

            rdr.Close();
            MultiView1.ActiveViewIndex = 0;
            
            btn_save.Text = "Update";
        }
        conn.Close();

    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        Label l1 = (Label)GridView1.Rows[e.RowIndex].FindControl("lbl_contestkey");
        conn.Open();
        cmd = new SqlCommand("delete from Contests where contestkey=@contestkey", conn);
        cmd.Parameters.AddWithValue("@contestkey", l1.Text);
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
        Label contestkey = (Label)DataList1.SelectedItem.FindControl("lbl_contestkey");

        
        conn.Open();
        cmd = new SqlCommand("select * from Board where contestkey=@contestkey", conn);
        cmd.Parameters.AddWithValue("@contestkey", contestkey.Text);

        rdr = cmd.ExecuteReader();
        if (rdr.Read())
        {
            lbl_bid.Text = contestkey.Text;
            ddl_sportkey.SelectedValue = rdr["fkSportKey"].ToString();
            txtContestName.Text = rdr["ContestName"].ToString();

            var matchdate =Convert.ToDateTime(rdr["Date"].ToString());
            ContestDate.Value = matchdate.ToString("yyyy-MM-dd HH:mm:ss").Replace(' ', 'T');
            rdr.Close();
            conn.Close();
            MultiView1.ActiveViewIndex = 0;

            btn_save.Text = "Update";
        }
    }

    protected void DataList1_DeleteCommand(object source, DataListCommandEventArgs e)
    {
       
        int id = Convert.ToInt16(DataList1.DataKeys[e.Item.ItemIndex].ToString());
       
        conn.Open();
        cmd = new SqlCommand("delete from Board where contestkey=@contestkey", conn);
        cmd.Parameters.AddWithValue("@contestkey", id);
        cmd.ExecuteNonQuery();
        conn.Close();
        DataListFill();
    }

    
    
}