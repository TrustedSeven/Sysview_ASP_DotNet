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


    public partial class Home : System.Web.UI.Page
    {
        public string FirstName { get; set; }
        public string UserEmail { get; set; }
        public string TotalAssets { get; set; }
        public string TotalRepairs { get; set; }
        public string TotalLost { get; set; }

    protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_EMAIL"] != null && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString()))
            {

                    FirstName = Session["FirstName"].ToString();
                    UserEmail = Session["USER_EMAIL"].ToString();

            if (!String.IsNullOrEmpty(Session["UserStatus"].ToString()) && Session["UserStatus"].ToString() == "Admin")
                {
                    Response.Redirect("admin-home.aspx");
                }
                else
                {
                ShowDashboardTotals(UserEmail);
                FilterMyAssetList(UserEmail);
            }

            }
            else
            {
                Session["redirect"] = "home.aspx";
                //Response.Redirect("login.aspx");
                Response.Redirect("welcome.aspx");
        }
        }

    public void ShowDashboardTotals(string userEmail)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        SqlCommand sqlcom = new SqlCommand("sv_usp_GetDashboardTotals", conn);

        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@userEmail", UserEmail);
        conn.Open();

        DataTable asset = new DataTable();

        asset.Load(sqlcom.ExecuteReader());
        conn.Close();

        foreach (DataRow item in asset.Rows)
        {
            TotalAssets = item["TotalAssets"].ToString();
            TotalRepairs = item["TotalRepairs"].ToString();
            TotalLost = item["TotalLost"].ToString();
        }
    }

    public void FilterMyAssetList(string filterParam)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        SqlCommand command = new SqlCommand("sv_usp_GetMyInventory", con);
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@userEmail", UserEmail);
        con.Open();
        command.Connection = con;

        SqlDataReader reader = command.ExecuteReader();
        int i = 0;
        do
        {
            UserList.Text = "<table class='table mb-0'>"
                                 + "<thead><tr><th>Model</th><th>Serial</th><th>MAC Address</th><th>Last User</th></tr></thead>";

            while (reader.Read())
            {
                string invStatus = reader["InvStatus"].ToString();
                string statusBtn;
                switch (invStatus)
                {
                    case "In Use":
                        statusBtn = "</span><span class='badge text-info-light badge-info ml-1 badge-text '>" + invStatus + "</span>";
                        break;
                    case "Decomissioned":
                        statusBtn = "</span><span class='badge text-dark-light badge-dark ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Lost":
                        statusBtn = "</span><span class='badge text-dark-light badge-dark ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Stolen":
                        statusBtn = "</span><span class='badge text-dark-light badge-dark ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Unassigned":
                        statusBtn = "</span><span class='badge text-secondary-light badge-secondary ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Repair Complete":
                        statusBtn = "</span><span class='badge text-success-light badge-success ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    default:
                        statusBtn = "</span><span class='badge text-danger-light badge-danger ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                }

                UserList.Text += "<tr class='invRow' id='" + reader["InventoryKey"] + "'><td>" + reader["Model"].ToString()
                                                 + "</td><td>" + reader["SerialNum"].ToString()
                                                 + "</td><td>" + reader["MAC"].ToString()
                                                 + "</td><td>" + reader["UserEmail"].ToString()

                                                 //+ "</td><td>" + "<span class='badge badge-warning badge-text'><i class='fa fa-truck mr-1'></i> Pending</span>"
                                                 //+ "</td><td>" + "</span><span class='badge text-danger-light badge-danger ml-1 badge-text anibadge'>Hot</span>"
                                                 + "</td><td>" + statusBtn
                                                 + "</td></tr>";
            }
            i++;

            UserList.Text += "</table>";

        } while (reader.NextResult());

        reader.Close();
        con.Close();
    }


}
