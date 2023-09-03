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


public partial class AdminUser: System.Web.UI.Page
{

    public string FirstName { get; set; }
    public string UserEmail { get; set; }

    protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_EMAIL"] != null 
                && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString())
                && !String.IsNullOrEmpty(Session["UserStatus"].ToString()) 
                && Session["UserStatus"].ToString() == "Admin"
            )
            {

                FirstName = Session["FirstName"].ToString();

                GetUserList();

            }
            else
            {
                Session["redirect"] = "admin-home.aspx";
                Response.Redirect("login.aspx");
            }
        }

    public void GetUserList()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        SqlCommand command = new SqlCommand("sv_usp_GetSysViewUsers", con);
        command.CommandType = CommandType.StoredProcedure;
        con.Open();
        command.Connection = con;

        SqlDataReader reader = command.ExecuteReader();
        int i = 0;
        do
        {
            while (reader.Read())
            {
                string userStatus = reader["UserStatus"].ToString();
                string statusBtn;
                switch (userStatus)
                {
                    case "Active":
                        statusBtn = "<span class='badge text-info-light badge-success ml-1 badge-text'>" + userStatus + "</span>";
                        break;
                    case "Inactive":
                        statusBtn = "<span class='badge text-info-light badge-warning ml-1 badge-text'>" + userStatus + "</span>";
                        break;
                    default:
                        statusBtn = "<span class='badge text-danger-light badge-danger ml-1 badge-text'>" + userStatus + "</span>";
                        break;
                }
                
                Userlist.InnerHtml += "<tr>" +
                                            "<td>" + reader["UserName"].ToString() + "</td>" +
                                            "<td>" + reader["FirstName"].ToString() + "</td>" +
                                            "<td>" + reader["LastName"].ToString() + "</td>" +
                                            "<td>" + reader["Email"].ToString() + "</td>" +
                                            "<td>" + reader["Password"].ToString() + "</td>" +
                                            "<td>" + statusBtn + "</td>" +
                                            "<td><a href='admin-user-edit.aspx?userKey=" + reader["UserKey"].ToString() + "' class='btn-icon-o btn-info btn-icon-sm mr-2 mb-2'><i class='fa fa-edit'></i></a></td>" +
                                          "</tr>";
            }
            i++;

        } while (reader.NextResult());

        reader.Close();
        con.Close();
    }

}
