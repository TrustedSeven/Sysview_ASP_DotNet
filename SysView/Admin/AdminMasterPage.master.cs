using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pageName = Path.GetFileName(Request.Path);
        SetSideMenu(pageName);
        if (Session["USER_EMAIL"] != null && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString()))
        {
            //lnkbtnLogin.Visible = false;
            //Button1.Visible = false;
            //// lblusername.Visible = true;
            //lblusername.Style.Add("display", "block");
            //lblusername.Style.Add("padding", "0 15px 0 0");
            //spIcon.Visible = false;
            //lblusername.Text = Session["UserName"].ToString();
            //LogOutHome.Visible = true;
            //LogOutOther.Visible = true;
            //ModalContainer.Visible = false;
            //ModalProfile.Visible=true;
            //lnkbtnLogin1.Visible = false;
            //lblusername1.Visible = true;
            //lblusername1.Text = Session["UserName"].ToString();
        }
        else
        {
            //Button1.Visible = true;
            ////lnkbtnLogin.Visible = true;
            ////lblusername.Visible = false;
            //spIcon.Visible = true;
            //lblusername.Style.Add("display", "none");
            //LogOutHome.Visible = false;
            //LogOutOther.Visible = false;
            //ModalContainer.Visible = true;
            //ModalProfile.Visible=false;
            //lnkbtnLogin1.Visible = true;
            //lblusername1.Visible = false;
            //Response.Redirect("login.aspx");
        }
    }

    public void SetSideMenu(string PageName)
    {
        if (PageName == "home.aspx")
        {
            //HomeSide.Visible = true;
            //OtherSide.Visible = false;
        }
        else
        {
            //HomeSide.Visible = false;
            //OtherSide.Visible = true;
        }
    }

}
