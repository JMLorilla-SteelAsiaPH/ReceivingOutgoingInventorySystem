using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SWIV_Web.scripts
{
    public class DatabaseConnection
    {
         
        public static string connectionString = string.Empty;
        public static System.Data.SqlClient.SqlConnection conn;
        //public static string serverName = "200.10.12.40";
        //public static string serverName = "10.10.12.158";
        public static string serverName = "HODBServer01";
        public static string   databaseName= "Truckscale";

        public static Boolean DBConnect()
        {
            connectionString = "Server=" + serverName + ";Database=" + databaseName + ";User Id=userscraps;Password='userscraps';";
            conn = new SqlConnection(connectionString);
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            return false;
        }

        public static bool DBDisconnect()
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            return false;
        }

        public static SqlConnection DBConnectTo(string connectionString)
        {
            System.Data.SqlClient.SqlConnection newConnection = new System.Data.SqlClient.SqlConnection(connectionString);
            if (newConnection.State == ConnectionState.Closed)
                newConnection.Open();
            return newConnection;
        }

        public static bool DBDisconnectTo(SqlConnection connection)
        {
            if (connection.State == ConnectionState.Open)
                connection.Close();
            return true;
        }

        public static DataSet DBSelectQueryToDB(string SQlQuery, List<ParametersWithValue> SQLParameters, string connectionString, bool Exec_SP = false)
        {
            var newConn = DBConnectTo(connectionString);
            DataSet dsResult = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter();
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(SQlQuery, newConn);
            if (Exec_SP == true)
                cmd.CommandType = CommandType.StoredProcedure;
            else
                cmd.CommandType = CommandType.Text;
            if (SQLParameters != null)
            {
                foreach (ParametersWithValue parms in SQLParameters)
                    cmd.Parameters.AddWithValue(parms.ParameterName, parms.ParameterValue);
            }
            da.SelectCommand = cmd;
            da.Fill(dsResult);
            cmd.Dispose();
            da.Dispose();
            DBDisconnectTo(newConn);
            return dsResult;
        }

        // Get data 
        public static DataSet DBSelectQuery(string SQlQuery, List<ParametersWithValue> SQLParameters, bool Exec_SP = false)
        {
            DBConnect();
            if (conn.State == ConnectionState.Connecting)
            {
            }
            DataSet dsResult = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter();
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(SQlQuery, conn);
            if (Exec_SP == true)
                cmd.CommandType = CommandType.StoredProcedure;
            else
                cmd.CommandType = CommandType.Text;

            // set all parameters
            if (SQLParameters != null)
            {
                foreach (ParametersWithValue parms in SQLParameters)
                    cmd.Parameters.AddWithValue(parms.ParameterName, parms.ParameterValue);
            }


            da.SelectCommand = cmd;
            da.Fill(dsResult);
            cmd.Dispose();
            da.Dispose();
            DBDisconnect();
            return dsResult;
        }


        public static DataTable oReturnDataList(string SQLStr)
        {

            connectionString = "Server=" + serverName + ";Database=" + databaseName + ";User Id=sa;Password='';";
            conn = new SqlConnection(connectionString);

            System.Data.SqlClient.SqlCommand oCmd = new System.Data.SqlClient.SqlCommand();
            System.Data.SqlClient.SqlDataAdapter oDA = new System.Data.SqlClient.SqlDataAdapter();
            //DataSet oDS = new DataSet();
            DataTable oDT = new DataTable();

            conn.ConnectionString = connectionString;
            conn.Open();

            //oCmd.Connection = conn;
            //oCmd.CommandText = SQLStr;
            //oCmd.ExecuteNonQuery();

            //oDA.SelectCommand = oCmd;
            oDA = new System.Data.SqlClient.SqlDataAdapter(SQLStr,conn);
            oDA.Fill(oDT);


            conn.Close();
            conn = null/* TODO Change to default(_) if this is not a reference type */;
            oCmd = null/* TODO Change to default(_) if this is not a reference type */;
            oDA = null/* TODO Change to default(_) if this is not a reference type */;

            return oDT;

            //oDS = null/* TODO Change to default(_) if this is not a reference type */;
        }


        //public static bool DBInsertData(string SQlQuery, List<ParametersWithValue> SQLParameters, bool Exec_SP = false)
        //{
        //    try
        //    {
        //        DBConnect();
        //        SqlClient.SqlCommand cmd = new SqlClient.SqlCommand(SQlQuery, conn);
        //        if (Exec_SP == true)
        //            cmd.CommandType = CommandType.StoredProcedure;
        //        else
        //            cmd.CommandType = CommandType.Text;
        //        if (SQLParameters != null)
        //        {
        //            foreach (ParametersWithValue parms in SQLParameters)
        //                cmd.Parameters.AddWithValue(parms.ParameterName, parms.ParameterValue);
        //        }
        //        cmd.ExecuteNonQuery();
        //        cmd.Dispose();
        //        DBDisconnect();
        //    }
        //    catch (Exception ex)
        //    {
        //        return false;
        //    }
        //    return true;
        //}

        //public static DataSet DBInsertDataWithReturnValue(string SQlQuery, List<ParametersWithValue> SQLParameters, bool Exec_SP = false)
        //{
        //    try
        //    {
        //        DBConnect();
        //        SqlClient.SqlCommand cmd = new SqlClient.SqlCommand(SQlQuery, conn);
        //        DataSet dsResult = new DataSet();
        //        SqlDataAdapter da = new SqlDataAdapter();
        //        if (Exec_SP == true)
        //            cmd.CommandType = CommandType.StoredProcedure;
        //        else
        //            cmd.CommandType = CommandType.Text;

        //        foreach (ParametersWithValue parms in SQLParameters)
        //            cmd.Parameters.AddWithValue(parms.ParameterName, parms.ParameterValue);
        //        da.SelectCommand = cmd;
        //        da.Fill(dsResult);
        //        cmd.Dispose();
        //        DBDisconnect();
        //        return dsResult;
        //    }
        //    catch (Exception ex)
        //    {
        //        return null/* TODO Change to default(_) if this is not a reference type */;
        //    }
        //}

        //public static int DBUpdateQuery(string SQlQuery, List<ParametersWithValue> SQLParameters)
        //{
        //    DBConnect();
        //    SqlClient.SqlCommand cmd = new SqlClient.SqlCommand(SQlQuery, conn);
        //    // set all parameters
        //    if (SQLParameters != null)
        //    {
        //        foreach (ParametersWithValue parms in SQLParameters)
        //            cmd.Parameters.AddWithValue(parms.ParameterName, parms.ParameterValue);
        //    }
        //    var affectedRows = Convert.ToInt32(cmd.ExecuteNonQuery());
        //    cmd.Dispose();
        //    DBDisconnect();
        //    return affectedRows;
        //}

        //public static string DBInsertQueryWithRowAffected(string SQlQuery, List<ParametersWithValue> SQLParameters, bool Exec_SP = false)
        //{
        //    DBConnect();
        //    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(SQlQuery, conn);

        //    if (Exec_SP == true)
        //        cmd.CommandType = CommandType.StoredProcedure;
        //    else
        //        cmd.CommandType = CommandType.Text;
        //    // set all parameters
        //    if (SQLParameters != null)
        //    {
        //        foreach (ParametersWithValue parms in SQLParameters)
        //            cmd.Parameters.AddWithValue(parms.ParameterName, parms.ParameterValue);
        //    }
        //    string affectedRows;
        //    try
        //    {
        //        affectedRows = Convert.ToInt32(cmd.ExecuteNonQuery());
        //    }
        //    catch (Exception ex)
        //    {
        //        affectedRows = ex.Message;
        //    }
        //    cmd.Dispose();
        //    DBDisconnect();
        //    return affectedRows;
        //}

        //public static string DBInsertUpdateQueryToDB_WithRowAffected(string SQlQuery, List<ParametersWithValue> SQLParameters, string connectionString, bool Exec_SP = false)
        //{
        //    var newConn = DBConnectTo(connectionString);
        //    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(SQlQuery, newConn);
        //    if (Exec_SP == true)
        //        cmd.CommandType = CommandType.StoredProcedure;
        //    else
        //        cmd.CommandType = CommandType.Text;
        //    // set all parameters
        //    if (SQLParameters != null)
        //    {
        //        foreach (ParametersWithValue parms in SQLParameters)
        //            cmd.Parameters.AddWithValue(parms.ParameterName, parms.ParameterValue);
        //    }
        //    string affectedRows;
        //    try
        //    {
        //      //  affectedRows = Convert.ToInt32(cmd.ExecuteNonQuery());
        //    }
        //    catch (Exception ex)
        //    {
        //        affectedRows = ex.Message;
        //    }
        //    cmd.Dispose();
        //    DBDisconnectTo(newConn);
        //    return affectedRows;
        //}
        //protected static void DBDeleteQuery(string SQlQuery, System.Data.SqlClient.SqlConnection connection)
        //{
        //   // return null;
        //}

        public class ParametersWithValue
        {
            public string ParameterName { get; set; } = string.Empty;
            public object ParameterValue { get; set; }
        }

        public static string SanitizeInput(string input)
        {
            string outputString = string.Empty;
            if (input != null & input != string.Empty)
                outputString = input.ToString().Replace("'", "");
            return outputString;
        }


        public static DataSet CreateDynamicNavBar()
        {
            DataSet ds = new DataSet();
            return ds;
        }
    }
}