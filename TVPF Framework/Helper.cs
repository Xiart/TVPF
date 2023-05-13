using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;

namespace DatabaseTVP_Core
{
    public static class Helper
    {
        public static bool IsGenericList(this object o)
        {
            bool isGenericList = false;

            var oType = o.GetType();

            if (oType.IsGenericType && (oType.GetGenericTypeDefinition() == typeof(List<>)))
                isGenericList = true;

            return isGenericList;
        }
        public static SqlDbType GetSqlDBType<T>(this T obj)
        {
            if (obj.GetType().IsSimpleType())
            {
                if (obj.GetType() == typeof(string))
                {
                    return new SqlParameter("z", (obj as string)).SqlDbType;
                }
                return new SqlParameter("z", obj).SqlDbType;
            }
            else
            {
                return SqlDbType.Structured;
            }
        }
        public static bool IsSimpleType(this Type type)
        {
            return
               type == typeof(string) ||
                type.IsValueType ||
                type.IsPrimitive ||
                new Type[] {
                typeof(String),
                typeof(Decimal),
                typeof(DateTime),
                typeof(DateTimeOffset),
                typeof(TimeSpan),
                typeof(Guid)
            }.Contains(type) ||
                Convert.GetTypeCode(type) != TypeCode.Object;
        }

        public static void AddNewParameter<T>(this SqlParameterCollection Params, string Parametername, T dt)
        {
            if (dt.GetType().IsSimpleType())
            {
                if (dt.GetType() == typeof(string))
                {
                    var p = Params.AddWithValue(Parametername, (dt as string));
                    p.SqlDbType = dt.GetSqlDBType();
                }
                else
                {
                    var p = Params.AddWithValue(Parametername, dt);
                    p.SqlDbType = dt.GetSqlDBType();
                }
            }
            else
            {
                var data = DataBase.ToTable(dt);
                if (data.Rows.Count > 0)
                {
                    var p = Params.AddWithValue(Parametername, data);
                    p.SqlDbType = dt.GetSqlDBType();
                }
            }
        }
        public static void AddNewParameter(this SqlParameterCollection Params, string Parametername, IEnumerable list)
        {
            var data = DataBase.ToTable(list);
            if (data.Rows.Count > 0)
            {
                var p = Params.AddWithValue(Parametername, data);
                p.SqlDbType = list.GetSqlDBType();
            }
        }
        public static IEnumerable<PropertyInfo> GetTvpProperties(this Type type)
        {
            return type.GetProperties().Where(
                      prop => Attribute.IsDefined(prop, typeof(TVPAttribute)));
        }
    }
}
