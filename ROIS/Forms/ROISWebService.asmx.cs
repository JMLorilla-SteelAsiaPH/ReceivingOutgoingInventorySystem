using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Data;
using System.Configuration;
using ROIS.Models;

namespace ROIS.Forms
{
    /// <summary>
    /// Summary description for ROISWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ROISWebService : System.Web.Services.WebService
    {
        private static string sdis_connstring = ConfigurationManager.ConnectionStrings["SDISNetConnection"].ConnectionString;
        private static string rois_connstring = ConfigurationManager.ConnectionStrings["ROISConnection"].ConnectionString;

        [WebMethod]
        public void ScanOutgoing(string scanned_barcode)
        {
            List<Outgoing> select_list = new List<Outgoing>();

            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_scan_barcode_outgoing", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ScannedBarcodeTag", scanned_barcode);

                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        Outgoing select = new Outgoing();
                        select.barcodetag = rdr["ID"].ToString();
                        select.referenceno = rdr["reference_no"].ToString();
                        select.prodcode = rdr["prod_code"].ToString();
                        //select.locationcode = (int)rdr["location_id"];
                        select.filenumber = rdr["file_number"].ToString();
                        select.bundlenumber = rdr["bundle_number"].ToString();
                        select.quantity = (double)rdr["quantity"];

                        select_list.Add(select);
                    }
                }
                catch (SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(select_list));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void HallTransfer(int locId, int passUserId, string passBarcode)
        {
            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_hall_transfer", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ItemBarcode", passBarcode);
                    cmd.Parameters.AddWithValue("@SelectedLocId", locId);
                    cmd.Parameters.AddWithValue("@LastUserId", passUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

        [WebMethod]
        public void GetDropDownData(int userId, int transactionMode)
        {
            List<LocationDropDown> select_list = new List<LocationDropDown>();
            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_get_location", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@IN_OUT", transactionMode);
                    con.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while(rdr.Read())
                    {
                        LocationDropDown select = new LocationDropDown();

                        select.locationId = (int)rdr["location_id"];
                        select.locationDesc = rdr["location_desc"].ToString();
                        //select.locationTo = rdr["location_to"].ToString();

                        select_list.Add(select);
                    }
                }
                catch(SqlException ex)
                { 
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(select_list));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void GetLoginSelectData()
        {
            List<LocationDropDown> select_list = new List<LocationDropDown>();
            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_exec_uvw_get_main_location", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        LocationDropDown select = new LocationDropDown();

                        select.locationDesc = rdr["MainLocation"].ToString();

                        select_list.Add(select);
                    }
                }
                catch (SqlException ex)
                {
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(select_list));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void InsertOutgoingData(string passId, string passRefNo, string passProdCd, string passFileNo, int passLocId, string passQty, int passLastUser, int passReasonId)
        {
            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_outgoing_insert", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", passId);
                    cmd.Parameters.AddWithValue("@RefNo", passRefNo);
                    cmd.Parameters.AddWithValue("@ProdCode", passProdCd);
                    cmd.Parameters.AddWithValue("@FileNo", passFileNo);
                    cmd.Parameters.AddWithValue("@LocationID", passLocId);
                    cmd.Parameters.AddWithValue("@Qty", passQty);
                    cmd.Parameters.AddWithValue("@LastUser", passLastUser);
                    cmd.Parameters.AddWithValue("@ReasonID", passReasonId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

        [WebMethod]
        public void CheckIfBarcodeExists(int transType, string scannedBarcode)
        {
            int x = 0;

            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_check_if_existing", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TransactionType", transType);
                    cmd.Parameters.AddWithValue("@ScannedBarcodeTag", scannedBarcode);

                    con.Open();
                    x = (int)cmd.ExecuteScalar();
                }
                catch(SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(x));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void InsertReceivingData(string passId, string passRefNo, string passProdCd, string passFileNo, string passQty, int passLastUser, int passReasonId)
        {
            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_receiving_insert", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", passId);
                    cmd.Parameters.AddWithValue("@RefNo", passRefNo);
                    cmd.Parameters.AddWithValue("@ProdCode", passProdCd);
                    cmd.Parameters.AddWithValue("@FileNo", passFileNo);
                    cmd.Parameters.AddWithValue("@Qty", passQty);
                    cmd.Parameters.AddWithValue("@LastUser", passLastUser);
                    cmd.Parameters.AddWithValue("@ReasonID", passReasonId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch(SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

        [WebMethod]
        public void GenerateInventorySummaryDt(string userLocationDesc)
        {
            List<InventorySummaryDt> select_list = new List<InventorySummaryDt>();

            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_exec_inventory_summary_table", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserLocation", userLocationDesc);
                    //cmd.CommandType = CommandType.Text;

                    con.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        InventorySummaryDt select = new InventorySummaryDt();

                        select.prod_code = rdr["prod_code"].ToString();
                        select.location = rdr["location_desc"].ToString();
                        select.quantity = (double)rdr["quantity"];
                        select.weight = (double)rdr["wt"];

                        select_list.Add(select);
                    }
                }
                catch (SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(select_list));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void GenerateInventoryDt()
        {
            List<InventoryDt> select_list = new List<InventoryDt>();
            InventoryDt select = new InventoryDt();

            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_generate_inventory_table", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        select.RefNo = rdr["RefNo"].ToString();
                        select.ProdCode = rdr["ProdCode"].ToString();
                        //select.LocationId = (int)rdr["LocationID"];
                        select.FileNo = rdr["FileNo"].ToString();
                        select.BundleNo = rdr["BundleNo"].ToString();
                        select.Qty = (double)rdr["Qty"];
                        select.TotalWeight = (double)rdr["TotalWT"];

                        select_list.Add(select);
                    }
                }
                catch(SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(select_list));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void UserAuthentication(string username, string userPass, string userLocation)
        {
            List<LoginAuthResult> authResultList = new List<LoginAuthResult>();
            LoginAuthResult authAttempt = new LoginAuthResult();

            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_user_authentication", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@userPass", userPass);
                    cmd.Parameters.AddWithValue("@location", userLocation);

                    con.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while(rdr.Read())
                    {
                        authAttempt.AuthResult = (int)rdr["ID"];
                    }

                    authResultList.Add(authAttempt);
                }
                catch(SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(authResultList));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void GetReasons(int userId, int transactionMode)
        {
            List<Reasons> select_list = new List<Reasons>();

            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_get_reason", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@IN_OUT", transactionMode);
                    con.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        Reasons select = new Reasons();

                        select.reasonId = (int)rdr["ID"];
                        select.reasonDesc = rdr["reason_desc"].ToString();

                        select_list.Add(select);
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine(ex.Message);
                }
                finally
                {

                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(select_list));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void GetPostedDetails(string scanned_barcode, string userLoc)
        {
            List<DrPostedDetails> select_list = new List<DrPostedDetails>();

            using (SqlConnection con = new SqlConnection(sdis_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_ROIS_Get_barcode_details", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", scanned_barcode);
                    cmd.Parameters.AddWithValue("@Loc", userLoc);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        DrPostedDetails select = new DrPostedDetails();
                        select.DrNo = rdr["DRNo"].ToString();
                        select.ProdCode = rdr["ProdCd"].ToString();
                        select.Qty = (int)rdr["Qty"];
                        select.FileNumber = rdr["FileNumber"].ToString();
                        select.BarcodeNum = rdr["BundleNumber"].ToString();
                        select_list.Add(select);
                    }
                }
                catch (SqlException ex)
                {
                    
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }


            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(select_list));
            Context.Response.Flush();
            Context.Response.End();
        }

        [WebMethod]
        public void GeneratePostedDetailsTable()
        {
            List<PostedDetailsTable> select_list = new List<PostedDetailsTable>();

            using (SqlConnection con = new SqlConnection(sdis_connstring))
            {
                try 
                {
                    SqlCommand cmd = new SqlCommand("usp_vw_Generate_ITRPosted_Table", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        PostedDetailsTable select = new PostedDetailsTable();
                        select.ItrNo = rdr["ITRNo"].ToString();
                        select.ID = rdr["ID"].ToString();
                        select.ProdCd = rdr["ProdCd"].ToString();
                        select.Qty = (int)rdr["Qty"];
                        select.FileNumber = rdr["FileNumber"].ToString();
                        select.BundleNumber = rdr["BundleNumber"].ToString();
                        select.LastUser = rdr["LastUser"].ToString();

                        select_list.Add(select);
                    }
                }
                catch (SqlException ex)
                {

                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "text/event-stream";
            Context.Response.Write(js.Serialize(select_list));
            Context.Response.Flush();
            Context.Response.End();
        }
    }
}
