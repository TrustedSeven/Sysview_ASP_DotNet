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


public partial class Lunch : System.Web.UI.Page
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
                today_date.InnerHtml = DateTime.Now.ToString("ddd, MMM dd, yyyy");
                GetStudentList();
            }
            else
            {
                Session["redirect"] = "admin-home.aspx";
                Response.Redirect("login.aspx");
            }
        }

    public void GetStudentList()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        SqlCommand command = new SqlCommand("sv_usp_GetStudentList", con);
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
                        statusBtn = "<span class='badge text-info-light badge-success ml-1 badge-text '>" + userStatus + "</span>";
                        break;
                    case "Inactive":
                        statusBtn = "<span class='badge text-info-light badge-danger ml-1 badge-text '>" + userStatus + "</span>";
                        break;
                    default:
                        statusBtn = "<span class='badge text-danger-light badge-danger ml-1 badge-text'>" + userStatus + "</span>";
                        break;
                }
                
                Studentlist.InnerHtml += "<tr>" +
                                            "<td>" + reader["StudentID"].ToString() + "</td>" +
                                            "<td>" + reader["FirstName"].ToString() + "</td>" +
                                            "<td>" + reader["LastName"].ToString() + "</td>" +
                                            "<td>" + reader["Email"].ToString() + "</td>" +
                                            "<td>" + reader["Grade"].ToString() + "</td>" +
                                            "<td>" + reader["Teacher"].ToString() + "</td>" +
                                            "<td>" + statusBtn + "</td>" +
                                            //"<td><a href='admin-student-edit.aspx?studentKey=" + reader["StudentKey"].ToString() + "' class='btn-icon-o btn-info btn-icon-sm mr-2 mb-2'><i class='fa fa-edit'></i></a><a href='#' data-studentkey='" + reader["StudentKey"].ToString() + "' class='btn-icon-o btn-danger btn-icon-sm mr-2 mb-2 btn-student-del'><i class='fa fa-trash'></i></a></td>" +
                                            "<td><button class='btn btn-primary btn-sm mb-2 btn-lunch' data-studentKey='" + reader["StudentKey"].ToString() + "' data-studentID = '" + reader["StudentID"].ToString() + "'>Lunch</button></td>" +
                                          "</tr>";
            }
            i++;

        } while (reader.NextResult());

        reader.Close();
        con.Close();
    }
    [WebMethod]
    public static string deleteStudent(string studentKey)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        conn.Open();
        SqlCommand cmd = new SqlCommand("delete from sv_Students where StudentKey='" + studentKey + "'", conn);
        cmd.ExecuteNonQuery();
        return "success";
    }
    [WebMethod]
    public static string addLunch(string studentKey, string studentID)
    {
        string lunch_date = DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss");
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        conn.Open();
        SqlCommand cmd = new SqlCommand("insert into sv_Lunch (LunchDate, StudentKey, StudentID) values ('" + lunch_date + "', '" + studentKey + "', '" + studentID + "')", conn);
        cmd.ExecuteNonQuery();
        return "success";
    }
}
