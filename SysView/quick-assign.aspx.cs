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


public partial class QuickAssign : System.Web.UI.Page
{

    public string FirstName { get; set; }
    public string UserEmail { get; set; }
    public string StudentName { get; set; }
    public string StudentID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_EMAIL"] != null 
                && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString())
                && !String.IsNullOrEmpty(Session["UserStatus"].ToString()) 
                && Session["UserStatus"].ToString() == "Admin"
            )
            {
                FirstName = Session["FirstName"].ToString();
                GetStudentList();
                FilterAssetList("9");
                GetTeacherList();
            }
            else
            {
                Session["redirect"] = "admin-home.aspx";
                Response.Redirect("login.aspx");
            }
        }
    public void GetTeacherList()
    {
        Teacherlist.Items.Add("");
        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("SELECT LastName FROM sv_Faculty", con))
            {
                con.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string LastName = reader["LastName"].ToString();
                        Console.WriteLine(LastName);
                        Teacherlist.Items.Add(LastName);
                    }
                }
            }
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
                StudentName = reader["LastName"].ToString();
                StudentID = reader["StudentID"].ToString();
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
                
                Studentlist.InnerHtml += "<tr class='studentRow' data-studentkey='" + reader["StudentKey"].ToString() + "'>" +
                                            "<td>" + reader["FirstName"].ToString() + "</td>" +
                                            "<td>" + reader["LastName"].ToString() + "</td>" +
                                            "<td>" + reader["Email"].ToString() + "</td>" +
                                            "<td>" + reader["Grade"].ToString() + "</td>" +
                                            "<td>" + reader["Teacher"].ToString() + "</td>" +
                                            "<td>" + statusBtn + "</td>" +
                                          "</tr>";
            }
            i++;

        } while (reader.NextResult());

        reader.Close();
        con.Close();
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
                DeviceModal.InnerHtml += "<tr class='invRow' data-inventorykey='" + reader["InventoryKey"].ToString() + "'>" + "<td>" + reader["Model"].ToString()
                                                 + "</td>" + "<td>" + reader["SerialNum"].ToString()
                                                 + "</td>"+ "<td>"+"</td>"
                                                 + "<td>" + statusBtn + "</td>" + "<td>" +
                                                 "</span><span class='badge text-success-light bg-primary ml-1 badge-text btn-quick-assign-modal' data-dismiss='modal''>" + "Assign" + "</span>"
                                                 + "</td>" + "</tr>";
                Devicelist.InnerHtml += "<tr class='invRow' data-inventorykey='" + reader["InventoryKey"].ToString() + "'>"+"<td>" + reader["Model"].ToString()
                                                 + "</td>"+"<td>" + reader["SerialNum"].ToString()
                                                 //+ "</td>"+"<td>" + reader["UserEmail"].ToString()
                                                 + "</td>"+"<td>" + statusBtn
                                                 + "</td>"+"</tr>";

            }
            i++;

        } while (reader.NextResult());

        reader.Close();
        con.Close();
    }
    public void FilterModalAssetList(string filterParam)
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
                DeviceModal.InnerHtml += "<tr class='invRow' data-inventorykey='" + reader["InventoryKey"].ToString() + "'>" + "<td>" + reader["Model"].ToString()
                                                 + "</td>" + "<td>" + reader["SerialNum"].ToString()
                                                 + "</td>" + "<td>" + "</td>"
                                                 + "<td>" + statusBtn + "</td>" + "<td>" +
                                                 "</span><span class='badge text-success-light bg-primary ml-1 badge-text btn-quick-assign-modal' data-dismiss='modal''>" + "Assign" + "</span>"
                                                 + "</td>" + "</tr>";
                
            }
            i++;

        } while (reader.NextResult());

        reader.Close();
        con.Close();
    }
    [WebMethod]
    public static string quick_assign(string studentKey, string inventoryKey)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        conn.Open();

        SqlCommand cmd = new SqlCommand("insert into sv_StudentDevice (fkStudentKey, fkInventoryID, StatusID, Date) values (@studentKey, @inventoryKey, '1', @date)", conn);
        cmd.Parameters.AddWithValue("@studentKey", studentKey);
        cmd.Parameters.AddWithValue("@inventoryKey", inventoryKey);
        cmd.Parameters.AddWithValue("@date", DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss"));
        cmd.ExecuteNonQuery();
        string historyEntry = inventoryKey + " assigned to student ID " + studentKey;
        SqlCommand history_cmd = new SqlCommand("insert into sv_EntityHistory (fkEntityID, EntityTypeID, HistoryEntry, EntryDate, EntryStatusID) values ('" + inventoryKey + "', 'Assignment', '" + historyEntry + "', '" + DateTime.Now + "', '1') ", conn);
        history_cmd.ExecuteNonQuery();
        SqlCommand status_cmd = new SqlCommand("UPDATE sv_Inventory SET StatusID = 1 WHERE InventoryKey = " + inventoryKey , conn);
        status_cmd.ExecuteNonQuery();
       
        return "success";
    }

}
