using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Runtime.CompilerServices;
using System.IO;
using System.Data.SqlClient;



namespace DatabaseTVP_Core
{
    public static class DataBase
    {
        #region Execute Query
        /// <summary>
        ///Execute Stored Procedure
        /// of same name as method name where this is invoked
        /// </summary>
        /// <typeparam name="ResultClass">Retrieve Data as List of ResultClass</typeparam>
        /// <returns></returns>

        [MethodImpl(MethodImplOptions.NoInlining)]
        private static List<ResultClass> PExecuteQuery<ResultClass>(SqlConnection connection, string MethodName)
            where ResultClass : new()
        {            
                        
            string StoredProcedure = MethodName;
            DataTable SelectTable = new DataTable();
            SqlCommand SelectCommand = new SqlCommand(StoredProcedure, connection);
            SelectCommand.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter SelectAdapter = new SqlDataAdapter();
            SelectAdapter.SelectCommand = SelectCommand;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            SelectAdapter.Fill(SelectTable);
            connection.Close();
            return ToList<ResultClass>(SelectTable);
        }

        /// <summary>
        ///Execute Stored Procedure
        /// of same name as method name where this is invoked
        /// </summary>
        /// <typeparam name="ResultClass">Retrieve Data as List of ResultClass</typeparam>
        /// <returns></returns>
        [MethodImpl(MethodImplOptions.NoInlining)]
        public static List<ResultClass> ExecuteQuery<ResultClass>(SqlConnection connection, [CallerMemberName] string MethodName = "")
            where ResultClass : new()
        {
            return PExecuteQuery<ResultClass>(connection, MethodName);
        }


        [MethodImpl(MethodImplOptions.NoInlining)]
        private static List<ResultClass> PExecuteQuery<ResultClass>(object p, SqlConnection connection, string MethodName)
            where ResultClass : new()
        {

            string StoredProcedure = MethodName;
            DataTable SelectTable = new DataTable();
            SqlCommand SelectCommand = new SqlCommand(StoredProcedure, connection);
            SelectCommand.CommandType = CommandType.StoredProcedure;
            int i = 1;
            foreach (var prop in p.GetType().GetProperties())
            {
                var x = Convert.ChangeType(prop.GetValue(p, null), prop.PropertyType);
                if (x.IsGenericList())
                {
                    SelectCommand.Parameters.AddNewParameter("ParamTable" + i++, list: x as IEnumerable);
                }
                else
                {
                    SelectCommand.Parameters.AddNewParameter("ParamTable" + i++, dt: x);
                }
            }
            SqlDataAdapter SelectAdapter = new SqlDataAdapter();
            SelectAdapter.SelectCommand = SelectCommand;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            SelectAdapter.Fill(SelectTable);
            connection.Close();
            return ToList<ResultClass>(SelectTable);
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static List<ResultClass> ExecuteQuery<ResultClass>(object p, SqlConnection connection, [CallerMemberName] string MethodName = "")
        where ResultClass : new()
        {
            return PExecuteQuery<ResultClass>(p, connection, MethodName);
        }


        #endregion

        #region Execute Non Query

        [MethodImpl(MethodImplOptions.NoInlining)]
        private static void PExecuteNonQuery(object p, SqlConnection connection, string MethodName)
        {
            
            string StoredProcedure = MethodName;
            SqlCommand cmdInsert = new SqlCommand(StoredProcedure, connection);
            cmdInsert.CommandTimeout = 300;
            cmdInsert.CommandType = CommandType.StoredProcedure;
            int i = 1;
            foreach (var prop in p.GetType().GetProperties())
            {
                var x = Convert.ChangeType(prop.GetValue(p, null), prop.PropertyType);
                if (x.IsGenericList())
                {
                    cmdInsert.Parameters.AddNewParameter("ParamTable" + i++, list: x as IEnumerable);
                }
                else
                {
                    cmdInsert.Parameters.AddNewParameter("ParamTable" + i++, dt: x);
                }
            }
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            cmdInsert.ExecuteNonQuery();
            connection.Close();
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static void ExecuteNonQuery(object p, SqlConnection connection, [CallerMemberName] string MethodName = "")
        {
            PExecuteNonQuery(p, connection, MethodName);
        }

        #endregion

        #region Conversion
        //DataTable convertion Overloads
        //single object conversion into datatable
        public static DataTable ToTable<T>(T Sample)
        {
            DataTable DT_Object = new DataTable();

            var properties = Sample.GetType().GetTvpProperties();
            object[] values = new object[properties.Count()];
            int index = 0;
            foreach (var p in properties)
            {
                DT_Object.Columns.Add(p.Name, p.PropertyType);
                values[index] = p.GetValue(Sample, null);
                index++;
            }
            DT_Object.Rows.Add(values);

            return DT_Object;
        }


        //list of object conversion into database user type rows
        public static DataTable ToTable(IEnumerable Sample)
        {
            DataTable DT_Object = new DataTable();
            var first = true;
            foreach (var item in Sample)
            {
                var properties = item.GetType().GetTvpProperties();
                object[] values = new object[properties.Count()];
                int index = 0;

                foreach (var p in properties)
                {
                    if (first)
                    {

                        DT_Object.Columns.Add(p.Name, p.PropertyType);
                    }
                    values[index] = p.GetValue(item, null);
                    index++;
                }
                DT_Object.Rows.Add(values);
                first = false;
            }


            return DT_Object;
        }

        //convert datarows into list of object
        private static List<T> ToList<T>(DataTable datatable)
            where T : new()
        {
            var properties = typeof(T).GetProperties();
            List<T> ReturnList = new List<T>();
            for (int i = 0; i < datatable.Rows.Count; i++)
            {
                T Sample = new T();
                for (int j = 0; j < datatable.Columns.Count; j++)
                {
                    var prop = properties.FirstOrDefault(p => p.Name.ToLower().Equals(datatable.Columns[j].ColumnName.ToLower()));
                    if (prop != null && datatable.Rows[i][j].GetType().UnderlyingSystemType.Name != "DBNull")
                    {
                        prop.SetValue(Sample, datatable.Rows[i][j]);
                    }
                }
                ReturnList.Add(Sample);
            }
            return ReturnList;
        }

        #endregion

        #region Reporting

        private static DataTable PExecuteforReport(object p, SqlConnection connection, string SPName)
        {

            
            string StoredProcedure = SPName;
            SqlCommand SelectCommand = new SqlCommand(StoredProcedure, connection);
            SelectCommand.CommandTimeout = 300;
            SelectCommand.CommandType = CommandType.StoredProcedure;
            int i = 1;
            if (p != null)
            {
                foreach (var prop in p.GetType().GetProperties())
                {
                    var x = Convert.ChangeType(prop.GetValue(p, null), prop.PropertyType);
                    if (x.IsGenericList())
                    {
                        SelectCommand.Parameters.AddNewParameter("ParamTable" + i++, list: x as IEnumerable);
                    }
                    else
                    {
                        SelectCommand.Parameters.AddNewParameter("ParamTable" + i++, dt: x);
                    }
                }
            }
            DataTable SelectTable = new DataTable();
            SqlDataAdapter SelectAdapter = new SqlDataAdapter();
            SelectAdapter.SelectCommand = SelectCommand;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            SelectAdapter.Fill(SelectTable);
            connection.Close();
            return SelectTable;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static DataTable ExecuteforReport(object p, SqlConnection connection, string SPName)
        {
            return PExecuteforReport(p, connection, SPName);
        }

        #endregion

        [MethodImpl(MethodImplOptions.NoInlining)]
        private static string GetMethodNameAtStackPos(int i = 2)
        {
            StackTrace st = new StackTrace();
            StackFrame sf = st.GetFrame(i);
            return sf.GetMethod().Name;
        }
    }
}
