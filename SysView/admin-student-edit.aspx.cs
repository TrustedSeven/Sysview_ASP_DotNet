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


    public partial class AdminStudentEdit : System.Web.UI.Page
    {

        public string FirstName { get; set; }
        public string UserEmail { get; set; }
        public static string StudentKey { get; set; }
        public string TotalLost { get; set; }
        public string InvKey { get; set; }

    protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_EMAIL"] != null && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString()) && !String.IsNullOrEmpty(Session["UserStatus"].ToString()) && (Session["UserStatus"].ToString() == "Admin" || Session["UserStatus"].ToString() == "Active"))
            {

                FirstName = Session["FirstName"].ToString();
                if (Request.QueryString["studentKey"] != null)
                {
                    StudentKey = Request.QueryString["studentKey"].ToString();
                    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);

                    SqlDataReader dataReader;
                    string query = "select * from sv_Students where StudentKey='" + StudentKey + "'";
                    con.Open();
                    SqlCommand command = new SqlCommand(query, con);
                    dataReader = command.ExecuteReader();

                    while (dataReader.Read())
                    {
                        firstName.Value = dataReader["FirstName"].ToString();
                        lastName.Value = dataReader["LastName"].ToString();
                        email.Value = dataReader["Email"].ToString();
                        grade.Value = dataReader["Grade"].ToString();
                        teacher.Value = dataReader["Teacher"].ToString();
                        var o = user_status as System.Web.UI.HtmlControls.HtmlSelect;
                        if (dataReader["UserStatus"].ToString() == "Active") o.SelectedIndex = 0;
                        else o.SelectedIndex = 1;
                    }
                    SqlCommand com = new SqlCommand("sv_usp_GetStudentDevices", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@studentKey", StudentKey);
                    com.Connection = con;
                    SqlDataReader reader = com.ExecuteReader();
                    while (reader.Read())
                    {

                        InvKey = reader["InventoryKey"].ToString();
                        string userStatus = reader["InvStatus"].ToString();
                        string statusBtn;
                        switch (userStatus)
                        {
                            case "In Use":
                                statusBtn = "<span class='badge text-info-light badge-success ml-1 badge-text '>" + userStatus + "</span>";
                                break;
                            default:
                                statusBtn = "<span class='badge text-danger-light badge-danger ml-1 badge-text'>" + userStatus + "</span>";
                                break;
                        }
                        string btn_lost_stolen = "<a href='javascript:void(0);' data-studentid='" + reader["StudentKey"].ToString() + "' data-assettag='" + reader["AssetTag"].ToString() + "' data-email='" + reader["Email"].ToString() + "' data-inventorykey='" + reader["InventoryKey"].ToString() + "' class='btn btn-danger btn-lost-stolen'>Lost/Stolen</a>";
                        string btn_unassign = "<button id='unassign' data-studentid='" + reader["StudentKey"].ToString() + "' data-assettag='" + reader["AssetTag"].ToString() + "' data-email='" + reader["Email"].ToString() + "' data-inventorykey='" + reader["InventoryKey"].ToString() + "' class='btn btn-info btn-unassign'>Unassign</button>";
                    if (userStatus == "Lost/Stolen")
                        {
                        btn_lost_stolen = "";
                        studentDevice_title.InnerText = "Device";
                        }
                        Devicelist.InnerHtml += "<tr>" +
                                                    "<td class='model'>" + reader["Model"].ToString() + "</td>" +
                                                    "<td class='type'>" + reader["InventoryType"].ToString() + "</td>" +
                                                    "<td class='serial-num'>" + reader["SerialNum"].ToString() + "</td>" +
                                                    "<td class='asset-tag'>" + reader["AssetTag"].ToString() + "</td>" +
                                                    "<td>" + statusBtn + "</td>" +
                                                    "<td>" + btn_lost_stolen + "</td>" +
                                                    "<td>" + btn_unassign + "</td>" +
                                                  "</tr>";
                    }
                    con.Close();
                }
                else 
                { 
                    Response.Redirect("admin-student.aspx");
                }
            }
            else
            {
                Session["redirect"] = "admin-home.aspx";
                Response.Redirect("login.aspx");
            }
        }
        [WebMethod]
        public static string updateStudent(string firstName, string lastName, string email, string grade, string teacher, string status)
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);

            string query = "update sv_Students set FirstName=@FirstName, LastName=@LastName, Email=@Email, Grade=@Grade, Teacher=@Teacher, UserStatus=@UserStatus where StudentKey='" + StudentKey + "'";
            con.Open();
            SqlCommand command = new SqlCommand(query, con);
            command.Parameters.AddWithValue("@FirstName", firstName);
            command.Parameters.AddWithValue("@LastName", lastName);
            command.Parameters.AddWithValue("@Email", email);
            command.Parameters.AddWithValue("@Grade", grade);
            command.Parameters.AddWithValue("@Teacher", teacher);
            command.Parameters.AddWithValue("@UserStatus", status);

            command.ExecuteNonQuery();
            con.Close();
            return "success";
        }
        [WebMethod]
        public static string updateDevice(string firstName, string lastName, string model, string serialNum, string inventoryKey, string studentID, string assetTag, string email, string comments, bool status)
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
            con.Open();

            SqlCommand cmdInsert = new SqlCommand("insert into sv_Repairs (Model, SerialNum, MAC, UserEmail, fk_AssetTag, StatusID, fkStudentID, Problems, ProblemNotes) values(@Model, @SerialNum, @MAC, @UserEmail, @fk_AssetTag, @StatusID, @fkStudentID, @Problems, @ProblemNotes)", con);
            cmdInsert.Parameters.AddWithValue("@Model", model);
            cmdInsert.Parameters.AddWithValue("@SerialNum", serialNum);
            cmdInsert.Parameters.AddWithValue("@MAC", "");
            cmdInsert.Parameters.AddWithValue("@UserEmail", email);
            cmdInsert.Parameters.AddWithValue("@fk_AssetTag", assetTag);
            cmdInsert.Parameters.AddWithValue("@StatusID", 6);
            cmdInsert.Parameters.AddWithValue("@fkStudentID", studentID);
            cmdInsert.Parameters.AddWithValue("@Problems", "");
            cmdInsert.Parameters.AddWithValue("@ProblemNotes", comments);

            cmdInsert.ExecuteNonQuery();
    

            string query = "update sv_Inventory set StatusID=@StatusID where InventoryKey='" + inventoryKey + "'";
            SqlCommand cmdUpdate = new SqlCommand(query, con);
            cmdUpdate.Parameters.AddWithValue("@StatusID", 6);

            cmdUpdate.ExecuteNonQuery();
            con.Close();
            return "success";
        }
    [WebMethod]
    public static string unassign(string studentKey, string inventoryKey)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        conn.Open();
        SqlCommand cmd = new SqlCommand("DELETE FROM sv_StudentDevice WHERE fkStudentKey = @studentKey AND fkInventoryID = @inventoryKey", conn);
        cmd.Parameters.AddWithValue("@studentKey", studentKey);
        cmd.Parameters.AddWithValue("@inventoryKey", inventoryKey);        
        cmd.ExecuteNonQuery();
        string historyEntry = inventoryKey + " unassigned to student ID " + studentKey;
        SqlCommand history_cmd = new SqlCommand("insert into sv_EntityHistory (fkEntityID, EntityTypeID, HistoryEntry, EntryDate, EntryStatusID) values ('" + inventoryKey + "', 'Unassignment', '" + historyEntry + "', '" + DateTime.Now + "', '1') ", conn);
        history_cmd.ExecuteNonQuery();
        SqlCommand status_cmd = new SqlCommand("UPDATE sv_Inventory SET StatusID = 8, LoanerFlag = 1 WHERE InventoryKey = " + inventoryKey, conn);
        status_cmd.ExecuteNonQuery();
        return "success";
    }

}
