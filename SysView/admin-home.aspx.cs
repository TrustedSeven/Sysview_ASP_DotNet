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


    public partial class AdminHome : System.Web.UI.Page
    {

        public string FirstName { get; set; }
        public string UserEmail { get; set; }
        public string TotalAssets { get; set; }
        public string TotalRepairs { get; set; }
        public string TotalDecom { get; set; }
    public string TotalLost { get; set; }

    protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_EMAIL"] != null 
                && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString())
                && !String.IsNullOrEmpty(Session["UserStatus"].ToString()) 
                && (Session["UserStatus"].ToString() == "Admin" || Session["UserStatus"].ToString() == "Active")
            )
            {

                FirstName = Session["FirstName"].ToString();

                ShowDashboardTotals();
                FilterAssetList("9");

            }
            else
            {
                Session["redirect"] = "admin-home.aspx";
                Response.Redirect("login.aspx");
            }
        }

    public void ShowDashboardTotals()
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        SqlCommand sqlcom = new SqlCommand("sv_usp_GetAdminDashboardTotals", conn);
        sqlcom.CommandType = CommandType.StoredProcedure;
        conn.Open();

        DataTable asset = new DataTable();

        asset.Load(sqlcom.ExecuteReader());
        conn.Close();

        foreach (DataRow item in asset.Rows)
        {

            TotalAssets = item["TotalAssets"].ToString();
            TotalRepairs = item["TotalRepairs"].ToString();
            TotalDecom = item["TotalDecom"].ToString();
            TotalLost = item["TotalLost"].ToString();
        }
    }
    [WebMethod]
    public static string addDevice(string asset_tag, string model, string serial_num, string status, string loaner_flag, string homeuse_flag)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        conn.Open();
        SqlCommand cmdInvInsert= new SqlCommand("insert into sv_Inventory (Model, SerialNum, AssetTag, StatusID, LoanerFlag, HomeUseFlag) values ('" + model + "', '" + serial_num + "', '" + asset_tag + "', '" + status + "', '" + loaner_flag + "', '" + homeuse_flag + "')", conn);
        cmdInvInsert.ExecuteNonQuery();
        return "success";
    }
    public void FilterAssetList(string filterParam)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        SqlCommand command = new SqlCommand("sv_usp_GetTechList", con);
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@statusList", filterParam);
        con.Open();
        command.Connection = con;

        SqlDataReader reader = command.ExecuteReader();
        int i = 0;
        do
        {
            
            while (reader.Read())
            {
                string invStatus = reader["InvStatus"].ToString();
                string statusBtn;
                switch (invStatus)
                {
                    case "In Use":
                        statusBtn = "</span><span class='badge text-white badge-warning ml-1 badge-text '>" + invStatus + "</span>";
                        break;
                    case "Decomissioned":
                        statusBtn = "</span><span class='badge text-white badge-dark ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Lost/Stolen":
                        statusBtn = "</span><span class='badge text-dark-light badge-dark ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Stolen":
                        statusBtn = "</span><span class='badge text-dark-light badge-dark ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Unassigned":
                        statusBtn = "</span><span class='badge text-secondary-light badge-secondary ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Repair Complete":
                        statusBtn = "</span><span class='badge text-white badge-success ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    case "Submitted For Repair":
                        statusBtn = "</span><span class='badge text-white badge-danger ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                    default:
                        statusBtn = "</span><span class='badge text-white badge-info ml-1 badge-text'>" + invStatus + "</span>";
                        break;
                }

                InventoryList.InnerHtml += "<tr class='invRow' id='" + reader["InventoryKey"] + "'><td>" + reader["Model"].ToString()
                                                 + "</td><td>" + reader["SerialNum"].ToString()
                                                 + "</td><td>" + reader["AssetTag"].ToString()
                                                 //+ "</td><td>" + reader["UserEmail"].ToString()

                                                 //+ "</td><td>" + "<span class='badge badge-warning badge-text'><i class='fa fa-truck mr-1'></i> Pending</span>"
                                                 //+ "</td><td>" + "</span><span class='badge text-danger-light badge-danger ml-1 badge-text anibadge'>Hot</span>"
                                                 + "</td><td>" + statusBtn
                                                 + "<td><a href='admin-assetdetail.aspx?inventorykey=" + reader["InventoryKey"].ToString() + "' class='btn-icon-o btn-info btn-icon-sm mr-2 mb-2'><i class='fa fa-edit'></i></a></td>"
                                                 + "</td></tr>";
            }
            i++;

        } while (reader.NextResult());

        reader.Close();
        con.Close();
    }


    }
