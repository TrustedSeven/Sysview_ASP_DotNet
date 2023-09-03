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
using System.Web.Script.Serialization;


public partial class Repair : System.Web.UI.Page
    {
        public string FirstName { get; set; }
        public string UserEmail { get; set; }
        public static string InvKey { get; set; }
        public string TotalLost { get; set; }
        public string Model { get; set; }
        public string SerialNum { get; set; }
        public string MAC { get; set; }
        public string ImgLink { get; set; }
        public string InvStatus { get; set; }
        public string StudentID { get; set; }
        public string AssetTag { get; set; }

    protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_EMAIL"] != null && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString()) && !String.IsNullOrEmpty(Session["UserStatus"].ToString()) && (Session["UserStatus"].ToString() == "Admin" || Session["UserStatus"].ToString() == "Active"))
            {
                if (Request.QueryString["InventoryKey"] != null)
                {
                    InvKey = Request.QueryString["InventoryKey"].ToString();
                    InvStatus = "";
                SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
                SqlCommand command = new SqlCommand("sv_usp_GetTechList", con);
                command.CommandType = CommandType.StoredProcedure;
                string filterParam = "9";
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

                        InventoryList.InnerHtml += "<tr class='invRow' id='" + reader["InventoryKey"] + "'><td>" + reader["Model"].ToString()
                                                         + "</td><td>" + reader["SerialNum"].ToString()
                                                         //+ "</td><td>" + reader["MAC"].ToString()
                                                         + "</td><td>" + reader["UserEmail"].ToString()

                                                         //+ "</td><td>" + "<span class='badge badge-warning badge-text'><i class='fa fa-truck mr-1'></i> Pending</span>"
                                                         //+ "</td><td>" + "</span><span class='badge text-danger-light badge-danger ml-1 badge-text anibadge'>Hot</span>"
                                                         + "</td><td>" + statusBtn
                                                         + "<td><button class='btn btn-info btn-sm m-1 btn-insert-student-device'>Assign</button></td>"
                                                         + "</td></tr>";
                    }
                    i++;

                } while (reader.NextResult());

                reader.Close();
                con.Close();

                SearchAssets(InvKey);
                
                if (InvStatus == "Submitted For Repair" || InvStatus == "Repair In Progress" || InvStatus == "Repair Complete" || InvStatus == "Lost/Stolen")
                {
                    Response.Redirect("devices.aspx");
                }
            }
                else
                {
                    Response.Redirect("devices.aspx");
                }
        }
        else
        {
            Session["redirect"] = "devices.aspx";
            Response.Redirect("login.aspx");
        }
    }

    public void SearchAssets(string invKey)
    {
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);

            SqlCommand sqlcom = new SqlCommand("sv_usp_GetInventoryByInvKey", conn);

            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.AddWithValue("@InvKey", invKey);
            conn.Open();

            DataTable asset = new DataTable();

            asset.Load(sqlcom.ExecuteReader());
            conn.Close();
        string StudentID = "";
            foreach (DataRow item in asset.Rows)
            {

                 InvKey = item["InventoryKey"].ToString();
                 Model = item["Model"].ToString();
                 SerialNum = item["SerialNum"].ToString();
                 MAC = item["MAC"].ToString();
                 UserEmail = item["UserEmail"].ToString();
                 ImgLink = item["ImgLink"].ToString();
                 InvStatus = item["InvStatus"].ToString();
                 StudentID = item["StudentID"].ToString();
                 AssetTag = item["AssetTag"].ToString();
                
            }
        student_id.Value = StudentID;
    }

    [WebMethod]
    public static string InsertRepairs(string invkey, string problems, string problemNotes)
    {
        try
        {

            SqlDataReader dataReader;
            string querySelect = "select InventoryKey, Model, SerialNum, MAC, UserEmail, AssetTag, StatusID, Location, fkStudentID from sv_Inventory where InventoryKey='" + invkey + "'";

            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(querySelect, conn);

            dataReader = cmd.ExecuteReader();

            while (dataReader.Read())
            {
                string InventoryKey = dataReader["InventoryKey"].ToString();
                string Model = dataReader["Model"].ToString();
                string SerialNum = dataReader["SerialNum"].ToString();
                string MAC = dataReader["MAC"].ToString();
                string UserEmail = dataReader["UserEmail"].ToString();
                string fk_AssetTag = dataReader["AssetTag"].ToString();
                string Location = dataReader["Location"].ToString();
                string fkStudentID = dataReader["fkStudentID"].ToString();

                SqlCommand cmdInsert = new SqlCommand("insert into sv_Repairs (fk_InventoryKey, Model, SerialNum, MAC, UserEmail, fk_AssetTag, StatusID, Location, fkStudentID, Problems, ProblemNotes) values(@InventoryKey, @Model, @SerialNum, @MAC, @UserEmail, @fk_AssetTag, @StatusID, @Location, @fkStudentID, @Problems, @ProblemNotes)", conn);
                cmdInsert.Parameters.AddWithValue("@InventoryKey", invkey);
                cmdInsert.Parameters.AddWithValue("@Model", Model);
                cmdInsert.Parameters.AddWithValue("@SerialNum", SerialNum);
                cmdInsert.Parameters.AddWithValue("@MAC", MAC);
                cmdInsert.Parameters.AddWithValue("@UserEmail", UserEmail);
                cmdInsert.Parameters.AddWithValue("@fk_AssetTag", fk_AssetTag);
                cmdInsert.Parameters.AddWithValue("@StatusID", 3);
                cmdInsert.Parameters.AddWithValue("@Location", Location);
                cmdInsert.Parameters.AddWithValue("@fkStudentID", fkStudentID);
                cmdInsert.Parameters.AddWithValue("@Problems", problems);
                cmdInsert.Parameters.AddWithValue("@ProblemNotes", problemNotes);

                cmdInsert.ExecuteNonQuery();

                SqlCommand cmdInvUpdate = new SqlCommand("update sv_Inventory SET PrevStatusID = StatusID, StatusID = 2, UpdatedDate = getdate()  WHERE InventoryKey=" + invkey, conn);
                cmdInvUpdate.ExecuteNonQuery();
                string historyEntry = "Device Repir";
                SqlCommand history_cmd = new SqlCommand("insert into sv_EntityHistory (fkEntityID, EntityTypeID, HistoryEntry, EntryDate, EntryStatusID) values ('" + InventoryKey + "', 'Repair Started', '" + historyEntry + "', '" + DateTime.Now + "', '1') ", conn);
                history_cmd.ExecuteNonQuery();
            }


            dataReader.Close();
            conn.Close();
            return "success";
        }
        catch (Exception ex)
        {
            Console.Write(ex);
            return "Failure";
        }
    }

    [WebMethod]
    public static string InsertStudentDevice(string invkey, string studentID)
    {
        try
        {
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
            conn.Open();

            SqlCommand cmdInsert = new SqlCommand("insert into sv_StudentDevice (Date, fkStudentKey, fkInventoryID, StatusID) values (@Date, @fkStudentKey, @fkInventoryID, @StatusID)", conn);
            cmdInsert.Parameters.AddWithValue("@Date", DateTime.Now.ToString("yyyy-mm-dd hh:mm:ss"));
            cmdInsert.Parameters.AddWithValue("@fkStudentKey", studentID);
            cmdInsert.Parameters.AddWithValue("@fkInventoryID", invkey);
            cmdInsert.Parameters.AddWithValue("@StatusID", "3");

            cmdInsert.ExecuteNonQuery();

            cmdInsert = new SqlCommand("UPDATE sv_Inventory SET StatusID = 1, UpdatedDate = getdate() WHERE InventoryKey = " + invkey, conn);
            cmdInsert.ExecuteNonQuery();

            conn.Close();
            return "success";
        }
        catch (Exception ex)
        {
            Console.Write(ex);
            return "Failure";
        }
    }
}
