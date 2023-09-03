using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPagePublic : System.Web.UI.MasterPage
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Role { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        string pageName = Path.GetFileName(Request.Path);
        SetSideMenu(pageName);
        if (Session["USER_EMAIL"] != null && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString()))
        {
            FirstName = Session["FirstName"].ToString();
            LastName = Session["LastName"].ToString();
            Role = "User";
            if (!String.IsNullOrEmpty(Session["UserStatus"].ToString()))
                Role = Session["UserStatus"].ToString();

        }
        else
        {

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
