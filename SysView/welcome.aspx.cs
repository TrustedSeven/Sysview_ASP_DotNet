using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Security;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using HtmlAgilityPack;


    public partial class welcome : System.Web.UI.Page
    {

        public string FirstName { get; set; }
        public string UserEmail { get; set; }
        public string TotalAssets { get; set; }
        public string TotalRepairs { get; set; }
        public string TotalDecom { get; set; }
    public string TotalLost { get; set; }

    protected void Page_Load(object sender, EventArgs e)
        {


        if (!string.IsNullOrEmpty(Request.QueryString["state"]))
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("welcome.aspx");
            }

        if (Session["USER_EMAIL"] != null 
                && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString())
                && !String.IsNullOrEmpty(Session["UserStatus"].ToString()) 
                && Session["UserStatus"].ToString() == "Admin"
            )
            {

                FirstName = Session["FirstName"].ToString();
                UserEmail = Session["USER_EMAIL"].ToString();


            }
            else
            {
                Session["redirect"] = "welcome.aspx";
            }
        }




    }
