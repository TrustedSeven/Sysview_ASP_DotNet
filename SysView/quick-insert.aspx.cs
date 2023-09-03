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


public partial class QuickInsert : System.Web.UI.Page
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
            //GetStudentList();

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

                /* Studentlist.InnerHtml += "<tr>" +
                                            "<td>" + reader["StudentID"].ToString() + "</td>" +
                                            "<td>" + reader["FirstName"].ToString() + "</td>" +
                                            "<td>" + reader["LastName"].ToString() + "</td>" +
                                            "<td>" + reader["Email"].ToString() + "</td>" +
                                            "<td>" + reader["Grade"].ToString() + "</td>" +
                                            "<td>" + reader["Teacher"].ToString() + "</td>" +
                                            "<td>" + statusBtn + "</td>" +
                                            //"<td><a href='admin-student-edit.aspx?studentKey=" + reader["StudentKey"].ToString() + "' class='btn-icon-o btn-info btn-icon-sm mr-2 mb-2'><i class='fa fa-edit'></i></a><a href='#' data-studentkey='" + reader["StudentKey"].ToString() + "' class='btn-icon-o btn-danger btn-icon-sm mr-2 mb-2 btn-student-del'><i class='fa fa-trash'></i></a></td>" +
                                            "<td><button class='btn btn-primary btn-sm mb-2 btn-lunch' data-studentKey='" + reader["StudentKey"].ToString() + "' data-studentID = '" + reader["StudentID"].ToString() + "'>Lunch</button></td>" +
                                          "</tr>"; */
            }
            i++;

        } while (reader.NextResult());

        reader.Close();
        con.Close();
    }

    [WebMethod]
    public static string addAssets(string make, string model, string invType, string AssetTag, string serialNum)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        int inventory_key = getInventoryKey(make, model, invType, AssetTag, serialNum);
        conn.Open();
        SqlCommand history_cmd = new SqlCommand("insert into sv_EntityHistory (fkEntityID, EntityTypeID, HistoryEntry, EntryDate, EntryStatusID) values ('" + inventory_key + "', 'Device', 'Inventory Inserted', '" + DateTime.Now + "', '1') ", conn);
        history_cmd.ExecuteNonQuery();
        return "success";
    }
    public static int getInventoryKey(string make, string model, string invType, string AssetTag, string serialNum)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
        conn.Open();
        int returnValue = -1;
        using (SqlCommand cmd = new SqlCommand("insert into sv_inventory (Make, Model, InventoryType, AssetTag, SerialNum, StatusID, UpdatedDate) values (@Make, @Model, @InventoryType, @AssetTag, @SerialNum, 1, @UpdatedDate); SELECT SCOPE_IDENTITY();", conn))
        {
            cmd.Parameters.AddWithValue("@Make", make);
            cmd.Parameters.AddWithValue("@Model", model);
            cmd.Parameters.AddWithValue("@InventoryType", invType);
            cmd.Parameters.AddWithValue("@AssetTag", AssetTag);
            cmd.Parameters.AddWithValue("@SerialNum", serialNum);
            cmd.Parameters.AddWithValue("@UpdatedDate", DateTime.Now);

            returnValue = Convert.ToInt32(cmd.ExecuteScalar());
        }
        conn.Close();
        return returnValue;

    }
}
