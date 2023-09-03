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
using System.Activities.Statements;
using System.Drawing;
using System.IdentityModel.Claims;

public partial class devices : System.Web.UI.Page
{

    
    static string ReturnVal { get; set; }
    static object ObjJSON { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["USER_EMAIL"] != null
            && !string.IsNullOrEmpty(Session["USER_EMAIL"].ToString())
            && !String.IsNullOrEmpty(Session["UserStatus"].ToString())
            && (Session["UserStatus"].ToString() == "Admin" || Session["UserStatus"].ToString() == "Active")
        )
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
            SqlCommand command = new SqlCommand("sv_usp_GetAllInventory", con);
            command.CommandType = CommandType.StoredProcedure;
            con.Open();
            command.Connection = con;

            SqlDataReader reader = command.ExecuteReader();
            int i = 0;
            do
            {

                while (reader.Read())
                {

                    string deviceStatus = "";
                    deviceStatus = reader["InvStatus"].ToString();
                    string statusBadge;
                    switch (deviceStatus)
                    {
                        case "In Use":
                            statusBadge = "<span class='badge text-white badge-warning ml-1 badge-text '>" + deviceStatus + "</span>";
                            break;
                        case "Decomissioned":
                            statusBadge = "<span class='badge text-white badge-dark ml-1 badge-text'>" + deviceStatus + "</span>";
                            break;
                        case "Lost/Stolen":
                            statusBadge = "<span class='badge text-dark-light badge-dark ml-1 badge-text'>" + deviceStatus + "</span>";
                            break;
                        case "Unassigned":
                            statusBadge = "<span class='badge text-secondary-light badge-secondary ml-1 badge-text'>" + deviceStatus + "</span>";
                            break;
                        case "Repair Complete":
                            statusBadge = "<span class='badge text-white badge-success ml-1 badge-text'>" + deviceStatus + "</span>";
                            break;
                        case "Submitted For Repair":
                            statusBadge = "<span class='badge text-white badge-danger ml-1 badge-text'>" + deviceStatus + "</span>";
                            break;
                        case "Repair In Progress":
                            statusBadge = "<span class='badge text-white badge-danger ml-1 badge-text'>" + deviceStatus + "</span>";
                            break;
                        default:
                            statusBadge = "<span class='badge text-white badge-secondary ml-1 badge-text'>" + deviceStatus + "</span>";
                            break;
                    }

                    Inventorylist.InnerHtml += "<tr>" +
                                                "<td>" + reader["Model"].ToString() + "</td>" +
                                                "<td>" + reader["SerialNum"].ToString() + "</td>" +
                                                "<td>" + reader["AssetTag"].ToString() + "</td>" +
                                                "<td>" + statusBadge + "</td>" +
                                                "<td><button deviceStatus='" + deviceStatus + "' id='" + reader["InventoryKey"].ToString() + "' class='btn btn-danger btn-RepairReq btn-icon-sm'><i class='fa fa-wrench'></i> Repair</button></td>" +
                                              //"<td><a href='/devices.aspx' class='btn btn-sm btn-danger btn-icon mr-1'><i class='fas fa-wrench'></i>Repair</a></td>" +
                                              "</tr>";
                }
                i++;

            } while (reader.NextResult());

            reader.Close();
            con.Close();

        }
        else
        {
            Session["redirect"] = "admin-home.aspx";
            Response.Redirect("login.aspx");
        }
    }

    [WebMethod]
    public static object SearchAssets(string assetNum)
    {
        try
        {
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);

            SqlCommand sqlcom = new SqlCommand("sv_usp_GetInventoryByAssetTag", conn);

            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.AddWithValue("@AssetTag", assetNum);
            conn.Open();

            DataTable asset = new DataTable();

            asset.Load(sqlcom.ExecuteReader());
            conn.Close();
            
                foreach (DataRow item in asset.Rows)
                {
                
                    string invKey = item["InventoryKey"].ToString();
                    string model = item["Model"].ToString();
                    string serialNum = item["SerialNum"].ToString();
                    string mac = item["MAC"].ToString();
                    string useremail = item["UserEmail"].ToString();
                    string imgLink = item["ImgLink"].ToString();
                    string invStatus = item["InvStatus"].ToString();
                    string studentID = item["StudentID"].ToString();

                ReturnVal = "{'inventoryKey':" + "'" + invKey + "'"
                    + ", 'model':" + "'" + model + "'"
                    + ", 'serialNum':" + "'" + serialNum + "'"
                    + ", 'MAC':" + "'" + mac + "'"
                    + ", 'userEmail':" + "'" + useremail + "'"
                    + ", 'imgLink':" + "'" + imgLink + "'"
                    + ", 'invStatus':" + "'" + invStatus + "'"
                    + ", 'studentID':" + "'" + studentID + "'"
                    + "}";

                JavaScriptSerializer j = new JavaScriptSerializer();
                ObjJSON = j.Deserialize(ReturnVal, typeof(object));

            }

            return ObjJSON;
            
        }
        catch (Exception ex)
        {
            return "Error retrieving data from database";
        }
    }

    [WebMethod]
    public static string InsertRepairs(string invkey, string problems, string problemNotes)
    {
        try
        {

            SqlDataReader dataReader;
            string querySelect = "select Model, SerialNum, MAC, UserEmail, AssetTag, StatusID, Location, fkStudentID from sv_Inventory where InventoryKey='" + invkey + "'";

            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TrinoviContext"].ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(querySelect, conn);

            dataReader = cmd.ExecuteReader();

            while (dataReader.Read())
            {
                string Model = dataReader["Model"].ToString();
                string SerialNum = dataReader["SerialNum"].ToString();
                string MAC = dataReader["MAC"].ToString();
                string UserEmail = dataReader["UserEmail"].ToString();
                string fk_AssetTag = dataReader["AssetTag"].ToString();
                string StatusID = dataReader["StatusID"].ToString();
                string Location = dataReader["Location"].ToString();
                string fkStudentID = dataReader["fkStudentID"].ToString();

                SqlCommand cmdInsert = new SqlCommand("insert into sv_Repairs (fk_InventoryKey, Model, SerialNum, MAC, UserEmail, fk_AssetTag, StatusID, Location, fkStudentID, Problems, ProblemNotes) values(@InventoryKey, @Model, @SerialNum, @MAC, @UserEmail, @fk_AssetTag, @StatusID, @Location, @fkStudentID, @Problems, @ProblemNotes)", conn);
                cmdInsert.Parameters.AddWithValue("@InventoryKey", invkey);
                cmdInsert.Parameters.AddWithValue("@Model", Model);
                cmdInsert.Parameters.AddWithValue("@SerialNum", SerialNum);
                cmdInsert.Parameters.AddWithValue("@MAC", MAC);
                cmdInsert.Parameters.AddWithValue("@UserEmail", UserEmail);
                cmdInsert.Parameters.AddWithValue("@fk_AssetTag", fk_AssetTag);
                cmdInsert.Parameters.AddWithValue("@StatusID", StatusID);
                cmdInsert.Parameters.AddWithValue("@Location", Location);
                cmdInsert.Parameters.AddWithValue("@fkStudentID", fkStudentID);
                cmdInsert.Parameters.AddWithValue("@Problems", problems);
                cmdInsert.Parameters.AddWithValue("@ProblemNotes", problemNotes);

                cmdInsert.ExecuteNonQuery();

                SqlCommand cmdInvUpdate = new SqlCommand("update sv_Inventory SET StatusID = 2 WHERE SerialNum ='" + 
                                                            SerialNum + "' " +
                                                         "AND AssetTag='" + 
                                                            fk_AssetTag + "'", conn);
                cmdInvUpdate.ExecuteNonQuery();
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
}