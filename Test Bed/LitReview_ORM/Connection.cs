using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;

namespace LitReview_ORM
{
    static class  Connection
    {
        public static SqlConnection con;
        public static SqlConnection GetConnection()
        {
            if (con == null)
            {
                con = new SqlConnection(@"Data Source=(local); Initial Catalog = Testing; Integrated Security = SSPI;");
            }
            if (con.State == System.Data.ConnectionState.Closed)
            {
                con.Open();
            }
            return con;
        }
    }
}
