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


    public partial class AdminUserEdit : System.Web.UI.Page
    {

        public string FirstName { get; set; }
        public string UserEmail { get; set; }
        public static string UserKey { get; set; }
        public string TotalLost { get; set; }
        public string InvKey { get; set; }

    protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_EMAIL"] != null && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString()) && !String.IsNullOrEmpty(Session["UserStatus"].ToString()) && Session["UserStatus"].ToString() == "Admin")
            {

                FirstName = Session["FirstName"].ToString();
                if (Request.QueryString["userKey"] != null)
                {
                    UserKey = Request.QueryString["userKey"].ToString();
                    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);

                    SqlDataReader dataReader;
                    string query = "select * from sv_Users where UserKey='" + UserKey + "'";
                    con.Open();
                    SqlCommand command = new SqlCommand(query, con);
                    dataReader = command.ExecuteReader();

                    while (dataReader.Read())
                    {
                        firstName.Value = dataReader["FirstName"].ToString();
                        userName.Value = dataReader["UserName"].ToString();
                        lastName.Value = dataReader["LastName"].ToString();
                        email.Value = dataReader["Email"].ToString();
                        password.Value = dataReader["Password"].ToString();
                        var o = user_status as System.Web.UI.HtmlControls.HtmlSelect;
                    if (dataReader["UserStatus"].ToString() == "Admin") o.SelectedIndex = 0;
                    else if (dataReader["UserStatus"].ToString() == "Active") o.SelectedIndex = 1;
                    else o.SelectedIndex = 1;
                    }
                    con.Close();
                }
                else 
                { 
                    Response.Redirect("admin-users.aspx");
                }
            }
            else
            {
                Session["redirect"] = "admin-home.aspx";
                Response.Redirect("login.aspx");
            }
        }
        [WebMethod]
        public static string updateUser(string userName, string firstName, string lastName, string email, string password, string status)
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);

            string query = "update sv_Users set UserName=@UserName, FirstName=@FirstName, LastName=@LastName, Email=@Email, Password=@Password, UserStatus=@UserStatus where UserKey='" + UserKey + "'";
            con.Open();
            SqlCommand command = new SqlCommand(query, con);
            command.Parameters.AddWithValue("@UserName", userName);
            command.Parameters.AddWithValue("@FirstName", firstName);
            command.Parameters.AddWithValue("@LastName", lastName);
            command.Parameters.AddWithValue("@Email", email);
            command.Parameters.AddWithValue("@Password", password);
            command.Parameters.AddWithValue("@UserStatus", status);

            command.ExecuteNonQuery();
            con.Close();
            return "success";
        }
    }
