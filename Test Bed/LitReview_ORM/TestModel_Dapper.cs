using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Dapper;

namespace LitReview_ORM
{
    class TestModel_Dapper
    {
        public long ID { get; set; }
        public string Value { get; set; }


        public string Dapper_Select(int Count)
        {
            DateTime StartDate = DateTime.Now;
            List<TestModel_Dapper> lst = new List<TestModel_Dapper>();
            IDbConnection con = Connection.GetConnection();

            DynamicParameters dp = new DynamicParameters();
            dp.Add("Counter", Count);
            lst = con.Query<TestModel_Dapper>("Dapper_Select", dp, commandType: CommandType.StoredProcedure).AsList();

            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string Dapper_Insert(List<TestModel_Dapper> lst)
        {
            DateTime StartDate = DateTime.Now;
            for (int i = 0; i < lst.Count; i++)
            {
                IDbConnection con = Connection.GetConnection();
                con.Execute("Dapper_Insert", new { Id = lst[i].ID, Value = lst[i].Value }, commandType: CommandType.StoredProcedure);
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string Dapper_InsertBatch(List<TestModel_Dapper> lst)
        {
            DateTime StartDate = DateTime.Now;
            IDbConnection con = Connection.GetConnection();
            var X = lst.Select(m => new { Id = m.ID, Value = m.Value });
            con.Execute("Dapper_InsertBatch", X , commandType: CommandType.StoredProcedure);
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }


        public string Dapper_UpdateOne(List<TestModel_Dapper> lst)
        {
            DateTime StartDate = DateTime.Now;
            for (int i = 0; i < lst.Count; i++)
            {
                IDbConnection con = Connection.GetConnection();
                con.Execute("Dapper_Update", new { Id = lst[i].ID, Value = lst[i].Value }, commandType: CommandType.StoredProcedure);
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string Dapper_UpdateBatch(List<TestModel_Dapper> lst)
        {
            DateTime StartDate = DateTime.Now;
            IDbConnection con = Connection.GetConnection();
            var X = lst.Select(m => new { Id = m.ID, Value = m.Value });
            con.Execute("Dapper_UpdateBatch", X, commandType: CommandType.StoredProcedure);
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string Dapper_DeleteOne(List<TestModel_Dapper> lst)
        {
            DateTime StartDate = DateTime.Now;
            for (int i = 0; i < lst.Count; i++)
            {
                IDbConnection con = Connection.GetConnection();
                con.Execute("Dapper_Delete", new { Id = lst[i].ID }, commandType: CommandType.StoredProcedure);
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string Dapper_DeleteBatch(List<TestModel_Dapper> lst)
        {
            DateTime StartDate = DateTime.Now;
            IDbConnection con = Connection.GetConnection();
            var X = lst.Select(m => new { Id = m.ID });
            con.Execute("Dapper_DeleteBatch", X, commandType: CommandType.StoredProcedure);
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

    }

}
