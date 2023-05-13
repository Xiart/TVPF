using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;


namespace LitReview_ORM
{
    class TestModel_ADO
    {
        public long ID { get; set; }
        public string Value { get; set; }


        public string ADO_Insert(List<TestModel_ADO> lst)
        {
            DateTime StartDate = DateTime.Now;
            SqlCommand cmd = new SqlCommand("ADO_InsertOne", Connection.GetConnection());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            for (int i = 0; i < lst.Count; i++)
            {
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("Id", lst[i].ID);
                cmd.Parameters.AddWithValue("Value", lst[i].Value);
                cmd.ExecuteNonQuery();
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ADO_InsertBatch(List<TestModel_ADO> lst)
        {
            DateTime StartDate = DateTime.Now;
            SqlCommand cmd = new SqlCommand("ADO_InsertBatch", Connection.GetConnection());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            string param = "";
            //if (lst.Count > 1000)
            //{

            //}
            //else {
                for (int i = 0; i < lst.Count; i++)
                {
                    if (i != 0)
                    {
                        param += ",(" + lst[i].ID + ", '" + lst[i].Value + "')";
                    }
                    else
                    {
                        param += "(" + lst[i].ID + ", '" + lst[i].Value + "')";
                    }
                }
                cmd.Parameters.AddWithValue("Vals", param);
                cmd.ExecuteNonQuery();
            //}            
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ADO_Select(int count)
        {
            DateTime StartDate = DateTime.Now;
            SqlCommand cmd = new SqlCommand("ADO_Select", Connection.GetConnection());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("ParamTable1", count);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            System.Data.DataTable dt = new System.Data.DataTable();
            da.Fill(dt);
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        

        public string ADO_Update(List<TestModel_ADO> lst)
        {
            DateTime StartDate = DateTime.Now;
            SqlCommand cmd = new SqlCommand("ADO_Update", Connection.GetConnection());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            for (int i = 0; i < lst.Count; i++)
            {
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("Id", lst[i].ID);
                cmd.Parameters.AddWithValue("Value", lst[i].Value);
                cmd.ExecuteNonQuery();
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ADO_UpdateBatch(List<TestModel_ADO> lst)
        {
            DateTime StartDate = DateTime.Now;
            SqlCommand cmd = new SqlCommand("ADO_UpdateBatch", Connection.GetConnection());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.CommandTimeout = 600;
            string param = "";
            for (int i = 0; i < lst.Count; i++)
            {
                param += "UPDATE Entity SET  Value = '" + lst[i].Value + "' WHERE ID = " + lst[i].ID + ";";
            }
            cmd.Parameters.AddWithValue("Value", param);
            cmd.ExecuteNonQuery();
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }


        public string ADO_Delete(List<TestModel_ADO> lst)
        {
            DateTime StartDate = DateTime.Now;
            SqlCommand cmd = new SqlCommand("ADO_Delete", Connection.GetConnection());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            for (int i = 0; i < lst.Count; i++)
            {
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("Id", lst[i].ID);
                cmd.ExecuteNonQuery();
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ADO_DeleteBatch(List<TestModel_ADO> lst)
        {
            DateTime StartDate = DateTime.Now;
            SqlCommand cmd = new SqlCommand("ADO_DeleteBatch", Connection.GetConnection());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.CommandTimeout = 600;
            string param = "";
            for (int i = 0; i < lst.Count; i++)
            {
                param += "DELETE Entity WHERE Id = "+ lst[i].ID +";";
            }
            cmd.Parameters.AddWithValue("Value", param);
            cmd.ExecuteNonQuery();
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }
    }
}
