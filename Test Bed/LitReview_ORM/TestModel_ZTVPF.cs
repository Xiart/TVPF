using System;
using System.Collections.Generic;
using System.Text;
using DatabaseTVP_Core;

namespace LitReview_ORM
{
    class TestModel_ZTVPF
    {
        [TVP]
        public long ID { get; set; }
        [TVP]
        public string Value { get; set; }



        public string ZTVP_Insert(List<TestModel_ZTVPF> lst)
        {
            DateTime StartDate = DateTime.Now;
            foreach (var itm in lst)
            {
                DataBase.ExecuteNonQuery(new { x = itm }, Connection.GetConnection());
            }            
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ZTVP_InsertBatch(List<TestModel_ZTVPF> lst)
        {
            DateTime StartDate = DateTime.Now;
            DataBase.ExecuteNonQuery(new { x = lst }, Connection.GetConnection());
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ZTVP_Select(int Count)
        {
            DateTime StartDate = DateTime.Now;
            List<TestModel_ZTVPF> lst =  DataBase.ExecuteQuery<TestModel_ZTVPF>(new { x = Count }, Connection.GetConnection());
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ZTVP_Update(List<TestModel_ZTVPF> lst)
        {
            DateTime StartDate = DateTime.Now;
            foreach (var itm in lst)
            {
                DataBase.ExecuteNonQuery(new { x = itm }, Connection.GetConnection());
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ZTVP_UpdateBatch(List<TestModel_ZTVPF> lst)
        {
            DateTime StartDate = DateTime.Now;
            DataBase.ExecuteNonQuery(new { x = lst }, Connection.GetConnection());
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ZTVP_Delete(List<TestModel_ZTVPF> lst)
        {
            DateTime StartDate = DateTime.Now;
            foreach (var itm in lst)
            {
                DataBase.ExecuteNonQuery(new { x = itm }, Connection.GetConnection());
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string ZTVP_DeleteBatch(List<TestModel_ZTVPF> lst)
        {
            DateTime StartDate = DateTime.Now;
            DataBase.ExecuteNonQuery(new { x = lst }, Connection.GetConnection());
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }
    }
}
