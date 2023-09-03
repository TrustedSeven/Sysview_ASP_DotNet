using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.Web.Script.Serialization;

public partial class AdminAssetDetail : System.Web.UI.Page
{

    static string ReturnVal { get; set; }
    static object ObjJSON { get; set; }
    public string FirstName { get; set; }
    public static string InventoryKey { get; set; }
    public string problems { get; set; }
    public static string repairKey { get; set; }
    public static string Model { get; set; }
    public static string SerialNum { get; set; }

    public static string loanerFlag { get; set; }
    public static string homeUseFlag { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["USER_EMAIL"] != null
            && !String.IsNullOrEmpty(Session["USER_EMAIL"].ToString())
            && !String.IsNullOrEmpty(Session["UserStatus"].ToString())
            && Session["UserStatus"].ToString() == "Admin"
        )
        {

            FirstName = Session["FirstName"].ToString();

            if (!String.IsNullOrEmpty(Request.QueryString["inventorykey"].ToString())){
                InventoryKey = Request.QueryString["inventorykey"].ToString();
            } else
            {
                Response.Redirect("admin-home.aspx");
            }

            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);

            SqlCommand sqlcom = new SqlCommand("sv_usp_GetInventoryByKey", conn);
            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.AddWithValue("@InventoryKey", InventoryKey);
            conn.Open();

            DataTable asset = new DataTable();

            asset.Load(sqlcom.ExecuteReader());
            string serialNum = "";
            string repairNotes = "";
            foreach (DataRow item in asset.Rows)
            {
                string inventoryKey = item["InventoryKey"].ToString();
                string model = item["Model"].ToString();
                serialNum = item["SerialNum"].ToString();
                string mac = item["MAC"].ToString();
                string useremail = item["UserEmail"].ToString();
                string assetTag = item["AssetTag"].ToString();
                string statusID = item["StatusID"].ToString();
                loanerFlag = item["LoanerFlag"].ToString();
                homeUseFlag = item["HomeUseFlag"].ToString();
                string location = item["Location"].ToString();
                string fkStudentID = item["fkStudentID"].ToString();
                string imgLink = item["ImgLink"].ToString();
                repairNotes = item["RepairNotes"].ToString();
                problems = item["Problems"].ToString();
                repairKey = item["RepairKey"].ToString();
                repair_notes.InnerText = repairNotes;
                txtAssetTag.Value = assetTag;
                txtModel.Value = model;
                Model = item["Model"].ToString();
                SerialNum = item["SerialNum"].ToString();
                txtSerialNum.Value = serialNum;

                switch (statusID)
                {
                    case "1":
                        ddlDeviceStatus.SelectedIndex = 0;
                        break;
                    case "2":
                        ddlDeviceStatus.SelectedIndex = 1;
                        break;
                    case "3":
                        ddlDeviceStatus.SelectedIndex = 2;
                        break;
                    case "4":
                        ddlDeviceStatus.SelectedIndex = 3;
                        break;
                    case "5":
                        ddlDeviceStatus.SelectedIndex = 4;
                        break;
                    case "6":
                        ddlDeviceStatus.SelectedIndex = 5;
                        break;
                    case "7":
                        ddlDeviceStatus.SelectedIndex = 6;
                        break;
                    default:
                        ddlDeviceStatus.SelectedIndex = 0;
                        break;
                }

                if (!String.IsNullOrEmpty(inventoryKey))
                {
                    SqlCommand command = new SqlCommand("sv_usp_GetRepairHistory", conn);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@InventoryKey", InventoryKey);

                    SqlDataReader reader = command.ExecuteReader();
                    int i = 0;
                    do
                    {
                        RepairList.Text = "<table class='table mb-0'>";
                                             //+ "<thead><tr><th>Model</th><th>Serial</th><th>MAC Address</th><th>Last User</th></tr></thead>";

                        while (reader.Read())
                        {
                            string invStatus = reader["InvStatus"].ToString();
                            string SubmitDate = reader["SubmitDate"].ToString();

                            string statusBtn;
                            switch (invStatus)
                            {
                                case "In Use":
                                    statusBtn = "</span><span class='badge text-info-light badge-info ml-1 badge-text '>" + invStatus + "</span>";
                                    break;
                                case "Decomissioned":
                                    statusBtn = "</span><span class='badge text-dark-light badge-dark ml-1 badge-text'>" + invStatus + "</span>";
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
                                    statusBtn = "</span><span class='badge text-success-light badge-success ml-1 badge-text'>" + invStatus + "</span>";
                                    break;
                                default:
                                    statusBtn = "</span><span class='badge text-danger-light badge-danger ml-1 badge-text'>" + invStatus + "</span>";
                                    break;
                            }

                            RepairList.Text += "<tr class='invRow' id='" + reader["InventoryKey"] + "'>"
                             + "</td><td>" + statusBtn
                             + "</td><td>" + SubmitDate
                             + "</td></tr>";
                        }
                        i++;

                        RepairList.Text += "</table>";

                    } while (reader.NextResult());

                    command = new SqlCommand("sv_usp_GetDeviceUsers", conn);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@InventoryKey", InventoryKey);

                    reader = command.ExecuteReader();
                    int s = 0;
                    do
                    {
                        UserList.Text = "<table class='table mb-0'>"
                                              + "<thead><tr><th>Student ID</th><th>First</th><th>Last</th><th>UserName</th><th>Date</th></tr></thead>";

                        while (reader.Read())
                        {

                            UserList.Text += "<tr class='invRow' id='" + reader["StudentID"] + "'>"
                             + "<td>" + reader["StudentID"].ToString()
                             + "</td><td>" + reader["FirstName"].ToString()
                             + "</td><td>" + reader["LastName"].ToString()
                             + "</td><td>" + reader["UserName"].ToString()
                             + "</td><td>" + reader["UpdateDate"].ToString()
                             + "</td></tr>";
                        }
                        s++;

                        UserList.Text += "</table>";
                    } while (reader.NextResult());

                }
            }
            
            

            conn.Close();
        }
        else
        {
            if(!String.IsNullOrEmpty(Session["UserStatus"].ToString()) && Session["UserStatus"].ToString() == "Active")
            {
                Response.Redirect("admin-home.aspx");
            } else
            {
                Session["redirect"] = "admin-home.aspx";
                Response.Redirect("login.aspx");
            }

        }
    }
    [WebMethod]
    public static string UpdateRepair(string problems, string repairNotes)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        conn.Open();
        SqlCommand cmdRepUpdate = new SqlCommand("update sv_Repairs set Problems='" + problems + "', RepairNotes='" + repairNotes+ "' where RepairKey='" + repairKey + "'", conn);
        cmdRepUpdate.ExecuteNonQuery();
        SqlCommand cmdInvUpdate = new SqlCommand("update sv_Inventory set StatusID=3 where InventoryKey='" + InventoryKey + "'", conn);
        cmdInvUpdate.ExecuteNonQuery();
        //SqlCommand cmdHistoryInsert = new SqlCommand("update sv_Inventory set StatusID=3 where InventoryKey='" + InventoryKey + "'", conn);
        //cmdHistoryInsert.ExecuteNonQuery();
        string historyEntry = "Repair Started";
        SqlCommand history_cmd = new SqlCommand("insert into sv_EntityHistory (fkEntityID, EntityTypeID, HistoryEntry, EntryDate, EntryStatusID) values ('" + InventoryKey + "', 'Repair', '" + historyEntry + "', '" + DateTime.Now + "', '1') ", conn);
        history_cmd.ExecuteNonQuery();
        return "success";
    }
    [WebMethod]
    public static string updateAsset(string inventory_key, string asset_tag, string serial_num, string model, string status_id, string loaner_flag, string homeuse_flag)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        conn.Open();
        SqlCommand cmdInvUpdate = new SqlCommand("update sv_Inventory set Model='" + model + "', SerialNum='" + serial_num + "', AssetTag='" + asset_tag + "', StatusID='" + status_id + "', LoanerFlag='" + loaner_flag + "', HomeUseFlag='" + homeuse_flag + "' where InventoryKey='" + inventory_key + "'", conn);
        cmdInvUpdate.ExecuteNonQuery();
        return "success";
    }
    public static void SearchAssets(string invKey)
    {

            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
            SqlCommand sqlcom = new SqlCommand("sv_usp_GetInventoryByKey", conn);
            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.AddWithValue("@InventoryKey", invKey);
            conn.Open();

            DataTable asset = new DataTable();

            asset.Load(sqlcom.ExecuteReader());
            conn.Close();

            foreach (DataRow item in asset.Rows)
            {

                string InventoryKey = item["InventoryKey"].ToString();
                string model = item["Model"].ToString();
                string serialNum = item["SerialNum"].ToString();
                string mac = item["MAC"].ToString();
                string useremail = item["UserEmail"].ToString();
                string assetTag = item["AssetTag"].ToString();
                string statusID = item["StatusID"].ToString();
                string loanerFlag = item["LoanerFlag"].ToString();
                string homeUseFlag = item["HomeUseFlag"].ToString();
                string location = item["Location"].ToString();
                string fkStudentID = item["fkStudentID"].ToString();
                string imgLink = item["ImgLink"].ToString();

            }
            

    }

}