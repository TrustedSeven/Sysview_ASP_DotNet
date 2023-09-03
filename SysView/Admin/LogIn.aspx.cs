using System;
using System.Collections.Generic;
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
using System.Configuration;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;

public partial class Admin_LogIn : System.Web.UI.Page
{
    string SqlCon = "";
    SqlConnection objsqlconn;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlCon = ConfigurationManager.ConnectionStrings["DB_A17D64_trinovitechEntities"].ToString();
        objsqlconn = new SqlConnection(SqlCon);
        if (!string.IsNullOrEmpty(Request.QueryString["state"]))
        {
            Session["USER_EMAIL"] = null;
            Session["redirect"] = null;
        }
    }

    protected void btnsignin_Click(object sender, EventArgs e)
    {
        Session["USER_EMAIL"] = null;
        Session["Admin"] = null;
        if (String.IsNullOrEmpty(txtusername.Text) || String.IsNullOrEmpty(txtpassword.Text))
        {
            lblmsg.Text = "Please enter a valid email and password";
        }
        else
        {
            SqlDataReader dataReader;
            string query = "select Email, FirstName, UserKey, LastName from sv_Users where Email='" + txtusername.Text.ToString() + "' and Password='" + txtpassword.Text.ToString() + "' and UserStatus='Admin'";
            objsqlconn.Open();
            SqlCommand command = new SqlCommand(query, objsqlconn);
            dataReader = command.ExecuteReader();

            while (dataReader.Read())
            {
                if (dataReader["Email"].ToString() != null)
                {
                    Session["USER_EMAIL"] = dataReader["Email"].ToString().Trim();
                    Session["UserName"] = dataReader["FirstName"].ToString() + " " + dataReader["LastName"].ToString();
                    Session["UserKey"] = dataReader["UserKey"].ToString();
                    Session["Admin"] = "1";
                    Response.Redirect("inventorylist.aspx");
                }
                else
                {
                    lblmsg.Text = "Please enter a valid email and password";
                }

            }
            lblmsg.Text = "Please enter a valid email and password";

            objsqlconn.Close();
        }
    }
}