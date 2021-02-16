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
        public void GetDropDownData()
        {
            List<LocationDropDown> select_list = new List<LocationDropDown>();
            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_get_location", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while(rdr.Read())
                    {
                        LocationDropDown select = new LocationDropDown();

                        select.locationId = (int)rdr["location_id"];
                        select.locationDesc = rdr["location_desc"].ToString();
                        select.locationTo = rdr["location_to"].ToString();

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
        public void InsertOutgoingData(string passId, string passRefNo, string passProdCd, string passFileNo, string passBundleNo, int passLocId, string passQty, int passLastUser)
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
                    cmd.Parameters.AddWithValue("@BundleNo", passBundleNo);
                    cmd.Parameters.AddWithValue("@LocationID", passLocId);
                    cmd.Parameters.AddWithValue("@Qty", passQty);
                    cmd.Parameters.AddWithValue("@LastUser", passLastUser);

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
        public void InsertReceivingData(string passId, string passRefNo, string passProdCd, string passFileNo, string passBundleNo, string passQty, int passLastUser)
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
                    cmd.Parameters.AddWithValue("@BundleNo", passBundleNo);
                    cmd.Parameters.AddWithValue("@Qty", passQty);
                    cmd.Parameters.AddWithValue("@LastUser", passLastUser);

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
        public void GenerateInventorySummaryDt()
        {
            List<InventorySummaryDt> select_list = new List<InventorySummaryDt>();

            using (SqlConnection con = new SqlConnection(rois_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SELECT prod_code, location_desc, CAST(quantity AS int) AS quantity, cast(wt AS varchar) AS wt FROM uvw_generate_inventory_summary", con);
                    //cmd.CommandType = CommandType.StoredProcedure;
                    //cmd.CommandType = CommandType.Text;

                    con.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        InventorySummaryDt select = new InventorySummaryDt();

                        select.prod_code = rdr["prod_code"].ToString();
                        select.location = rdr["location_desc"].ToString();
                        select.quantity = (int)rdr["quantity"];
                        select.weight = rdr["wt"].ToString();

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
        public void UserAuthentication(string username, string userPass)
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
        public void GetPostedSubdetails(string scanned_barcode)
        {
            List<ITRLTPostedSubdetails> select_list = new List<ITRLTPostedSubdetails>();

            using (SqlConnection con = new SqlConnection(sdis_connstring))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_get_ITRLTPostedSubDetail", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ScannedBarcodeTag", scanned_barcode);

                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        ITRLTPostedSubdetails select = new ITRLTPostedSubdetails();
                        select.barcodetag = rdr["ITRNo"].ToString();
                        select.prodcode = rdr["ProdCd"].ToString();
                        select.locationcode = rdr["ActWHLocationCd"].ToString();
                        select.quantity = int.Parse(rdr["Qty"].ToString());
                        select.filenumber = rdr["FileNumber"].ToString();
                        select.bundlenumber = rdr["BundleNumber"].ToString();

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
