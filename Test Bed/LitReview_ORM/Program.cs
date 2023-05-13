using System;
using System.Collections.Generic;
using System.Reflection;
using System.Data;
using System.IO;
using LitReview_ORM.Models;

namespace LitReview_ORM
{
    class Program
    {

       

        static void Main(string[] args)
        {
           

            int[] RowCount = new int[] { 10, 50, 100, 250, 500, 1000, 2500, 5000 };
            DataTable DtInsertOne = new DataTable();
            CreateColumns(DtInsertOne);

            DataTable DtInsertBatch = new DataTable();
            CreateColumns(DtInsertBatch);

            DataTable DtUpdateOne = new DataTable();
            CreateColumns(DtUpdateOne);

            DataTable DtUpdateBatch = new DataTable();
            CreateColumns(DtUpdateBatch);

            DataTable DtDeleteOne = new DataTable();
            CreateColumns(DtDeleteOne);

            DataTable DtDeleteBatch = new DataTable();
            CreateColumns(DtDeleteBatch);

            DataTable DTSelect = new DataTable();
            CreateColumns(DTSelect);

            //SELECT
            


            TestModel_ADO tado = new TestModel_ADO();
            TestModel_Dapper tdap = new TestModel_Dapper();
            TestModel_ZTVPF tztvp = new TestModel_ZTVPF();
            Entity ent = new Entity();          


            
            // Insert ONE
            for (int i = 0; i < RowCount.Length; i++)
            {
                DataRow dr = DtInsertOne.NewRow();
                dr["No. of Rows"] = RowCount[i];
                dr["ADO. NET"] = tado.ADO_Insert(FillList<TestModel_ADO>("ADO_Insert_One", RowCount[i]));
                dr["Dapper"] = tdap.Dapper_Insert(FillList<TestModel_Dapper>("Dapper_Insert_One", RowCount[i]));
                dr["EF Core"] = ent.EFC_InsertOne(FillList<Entity>("EFC_Insert_One", RowCount[i]));
                dr["ZTVPF"] = tztvp.ZTVP_Insert(FillList<TestModel_ZTVPF>("ZTVPF_Insert_One", RowCount[i]));
                DtInsertOne.Rows.Add(dr);
            }

            Console.WriteLine("Insert ONe Done");

            // Insert Batch
            for (int i = 0; i < RowCount.Length; i++)
            {
                DataRow dr = DtInsertBatch.NewRow();
                dr["No. of Rows"] = RowCount[i];
                dr["ADO. NET"] = tado.ADO_InsertBatch(FillList<TestModel_ADO>("ADO_Insert_Batch", RowCount[i]));
                dr["Dapper"] = tdap.Dapper_InsertBatch(FillList<TestModel_Dapper>("Dapper_Insert_Batch", RowCount[i]));
                dr["EF Core"] =ent.EFC_BulkInsert(FillList<Entity>("ENC_Insert_Batch", RowCount[i]));
                dr["ZTVPF"] = tztvp.ZTVP_InsertBatch(FillList<TestModel_ZTVPF>("ZTVPF_Insert_Batch", RowCount[i]));
                DtInsertBatch.Rows.Add(dr);
            }

            Console.WriteLine("Insert Batch Done");

            //SELECT
            for (int i = 0; i < RowCount.Length; i++)
            {
                DataRow dr = DTSelect.NewRow();
                dr["No. of Rows"] = RowCount[i];
                dr["ADO. NET"] = tado.ADO_Select(RowCount[i]);
                dr["Dapper"] = tdap.Dapper_Select(RowCount[i]);
                dr["EF Core"] = ent.EFC_Select(RowCount[i]);
                dr["ZTVPF"] = tztvp.ZTVP_Select(RowCount[i]);
                DTSelect.Rows.Add(dr);
            }

            Console.WriteLine("SELECT Done");

            //Update One
            for (int i = 0; i < RowCount.Length; i++)
            {
                DataRow dr = DtUpdateOne.NewRow();
                dr["No. of Rows"] = RowCount[i];
                dr["ADO. NET"] = tado.ADO_Update(FillList<TestModel_ADO>("ADO_Insert_One", RowCount[i]));
                dr["Dapper"] = tdap.Dapper_UpdateOne(FillList<TestModel_Dapper>("Dapper_Insert_One", RowCount[i]));
                dr["EF Core"] = ent.EFC_Update(FillList<Entity>("EFC_Insert_One", RowCount[i]));
                dr["ZTVPF"] = tztvp.ZTVP_Update(FillList<TestModel_ZTVPF>("ZTVPF_Insert_One", RowCount[i]));
                DtUpdateOne.Rows.Add(dr);
            }


            Console.WriteLine("UPDATE ONe Done");
            // Update Batch

            for (int i = 0; i < RowCount.Length; i++)
            {
                DataRow dr = DtUpdateBatch.NewRow();
                dr["No. of Rows"] = RowCount[i];
                dr["ADO. NET"] = tado.ADO_UpdateBatch(FillList<TestModel_ADO>("ADO_Insert_Batch", RowCount[i]));
                dr["Dapper"] = tdap.Dapper_UpdateBatch(FillList<TestModel_Dapper>("Dapper_Insert_Batch", RowCount[i]));
                dr["EF Core"] = ent.EFC_UpdateBatch(FillList<Entity>("ENC_Insert_Batch", RowCount[i]));
                dr["ZTVPF"] = tztvp.ZTVP_UpdateBatch(FillList<TestModel_ZTVPF>("ZTVPF_Insert_Batch", RowCount[i]));
                DtUpdateBatch.Rows.Add(dr);
            }


            Console.WriteLine("UPdate Batch Done");
            //Delete One
            for (int i = 0; i < RowCount.Length; i++)
            {
                DataRow dr = DtDeleteOne.NewRow();
                dr["No. of Rows"] = RowCount[i];
                dr["ADO. NET"] = tado.ADO_Delete(FillList<TestModel_ADO>("ADO_Insert_One", RowCount[i]));                
                dr["Dapper"] = tdap.Dapper_DeleteOne(FillList<TestModel_Dapper>("Dapper_Insert_One", RowCount[i]));                
                dr["EF Core"] = ent.EFC_DeleteBatch(FillList<Entity>("EFC_Insert_One", RowCount[i]));                
                dr["ZTVPF"] = tztvp.ZTVP_Delete(FillList<TestModel_ZTVPF>("ZTVPF_Insert_One", RowCount[i]));
                DtDeleteOne.Rows.Add(dr);
            }

            Console.WriteLine("Delete ONe Done");
            //Delete Batch
            for (int i = 0; i < RowCount.Length; i++)
            {
                DataRow dr = DtDeleteBatch.NewRow();
                dr["No. of Rows"] = RowCount[i];
                dr["ADO. NET"] = tado.ADO_DeleteBatch(FillList<TestModel_ADO>("ADO_Insert_Batch", RowCount[i]));
                dr["Dapper"] = tdap.Dapper_DeleteBatch(FillList<TestModel_Dapper>("Dapper_Insert_Batch", RowCount[i]));                
                dr["EF Core"] = ent.EFC_DeleteBatch(FillList<Entity>("ENC_Insert_Batch", RowCount[i]));
                dr["ZTVPF"] = tztvp.ZTVP_DeleteBatch(FillList<TestModel_ZTVPF>("ZTVPF_Insert_Batch", RowCount[i]));
                DtDeleteBatch.Rows.Add(dr);
            }

            Console.WriteLine("Delete Batch Done");

            DtInsertOne.ToCSV("1Insert_One.csv");
            DtInsertBatch.ToCSV("1Insert_Batch.csv");
            DTSelect.ToCSV("3Select.csv");
            DtUpdateOne.ToCSV("4Update_One.csv");
            DtUpdateBatch.ToCSV("5Update_Batch.csv");
            DtDeleteOne.ToCSV("6Delete_One.csv");
            DtDeleteBatch.ToCSV("7Delete_Batch.csv");
            Console.WriteLine("Task COmpleted... THANX :)");

            //string ADOone =  tado.ADO_Insert(FillList<TestModel_ADO>("InsertOne",10));
            //string DAPone = tdap.Dapper_Insert(FillList<TestModel_Dapper>("Dapper_insert_One", 10));
            //string ZTVPone = tztvp.ZTVP_Insert(FillList<TestModel_ZTVPF>("ZTVPF_insert_One", 10));


            //string tsbatch10 = tado.ADO_InsertBatch(FillList<TestModel_ADO>("InsertBatch", 10));
            //string tsone10 = tdap.Dapper_InsertBatch(FillList<TestModel_Dapper>("Dapper_Nnsert_Batch", 10));
            //string tsone10 = tztvp.ZTVP_InsertBatch(FillList<TestModel_ZTVPF>("ZTVPF_Insert_Batch", 10));

            //string tsuppone10 = tado.ADO_Update(FillList<TestModel_ADO>("UpdateOne", 10));
            //string tsone10 = tdap.Dapper_UpdateOne(FillList<TestModel_Dapper>("Dapper_Update_One", 10));
            //string tsone10 = tztvp.ZTVP_Update(FillList<TestModel_ZTVPF>("ZTVPF_Update_One", 10));

            //string tsupbatch10 = tado.ADO_UpdateBatch(FillList<TestModel_ADO>("UpdateBatch", 10));
            //string tsone10 = tdap.Dapper_UpdateBatch(FillList<TestModel_Dapper>("Dapper_Update_Batch", 10));
            //string tsone10 = tztvp.ZTVP_Insert(FillList<TestModel_ZTVPF>("ZTVPF_Update_Batch", 10));

            //string tsDelteone10 = tado.ADO_Delete(FillList<TestModel_ADO>("Delete", 10));
            //string tsone10 = tdap.Dapper_DeleteOne(FillList<TestModel_Dapper>("Dapper_Delete_One", 10));
            // string tsone10 = tztvp.ZTVP_Delete(FillList<TestModel_ZTVPF>("ZTVPF_Delete_One", 10));


            //string tsDeltebatch10 = tado.ADO_Delete(FillList<TestModel_ADO>("DeleteBatch", 10));
            //string tsone10 = tdap.Dapper_DeleteBatch(FillList<TestModel_Dapper>("Dapper_Delete_Batch", 10));
            //string tsone10 = tztvp.ZTVP_DeleteBatch(FillList<TestModel_ZTVPF>("ZTVPF_Delete_Batch", 10));
        }

        public static void CreateColumns(DataTable dt)
        {
            dt.Columns.Add("No. of Rows");
            dt.Columns.Add("ADO. NET");
            dt.Columns.Add("Dapper");
            dt.Columns.Add("EF Core");
            dt.Columns.Add("ZTVPF");
        }

        public static List<T> FillList<T>(string ForWhat, int Counter)
            where T : new()
        {
            List<T> lst = new List<T>();
            var properties = typeof(T).GetProperties();
            for (int i = 0; i < Counter; i++)
            {
                T sample = new T();
                properties[0].SetValue(sample, (Counter + ForWhat + i).GetHashCode());
                properties[1].SetValue(sample, (Counter + ForWhat + i).ToString());
                lst.Add(sample);
            }
            return lst;
        }


        //public static U BindModel<T, U>(T FromVModel, U ToModel)
        //    where U : new()
        //{
        //    var VMProp = typeof(T).GetProperties();
        //    var MProp = typeof(U).GetProperties();

        //    U Final = new U();

        //    for (int i = 0; i < VMProp.Length; i++)
        //    {
        //        for (int j = 0; j < MProp.Length; j++)
        //        {
        //            if (VMProp[i].Name == MProp[j].Name)
        //            {
        //                var prop = VMProp[i];
        //                var value = FromVModel.GetType().GetProperty(VMProp[i].Name).GetValue(FromVModel, null);
        //               //MProp.SetValue(FromVModel.GetType().GetProperty(VMProp[i].Name).GetValue(FromVModel, null),0);                        
        //                MProp[j].SetValue(Final, Convert.ChangeType(value,MProp[j].PropertyType), null);
        //            }
        //        }
        //    }
        //    return Final;
        //}



    }

    public static class Converter
    {
        public static void ToCSV(this DataTable dtDataTable, string strFilePath)
        {
            StreamWriter sw = new StreamWriter(strFilePath, false);
            //headers  
            for (int i = 0; i < dtDataTable.Columns.Count; i++)
            {
                sw.Write(dtDataTable.Columns[i]);
                if (i < dtDataTable.Columns.Count - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);
            foreach (DataRow dr in dtDataTable.Rows)
            {
                for (int i = 0; i < dtDataTable.Columns.Count; i++)
                {
                    if (!Convert.IsDBNull(dr[i]))
                    {
                        string value = dr[i].ToString();
                        if (value.Contains(','))
                        {
                            value = String.Format("\"{0}\"", value);
                            sw.Write(value);
                        }
                        else
                        {
                            sw.Write(dr[i].ToString());
                        }
                    }
                    if (i < dtDataTable.Columns.Count - 1)
                    {
                        sw.Write(",");
                    }
                }
                sw.Write(sw.NewLine);
            }
            sw.Close();
        }
    }
    



    public class Test
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ShortName { get; set; }
        public string Type { get; set; }

        public int TenantId { get; set; }
        public string AppId { get; set; }
        public int CreatedBy { get; set; }
        public int ModifiedBy { get; set; }
        public string  ReturnMessage { get; set; }

        public void SAVE()
        {
            Console.Write("Saving..........");
        }

        public Test GetOne()
        {
            return new Test() { Id = 1, Name = "Hello", ShortName = "Hell", Type = "Serious" };
        }

        public List<Test> GetAll()
        {
            List<Test> nt = new List<Test>();
            for (int i = 0; i < 10; i++)
            {
                nt.Add(new Test() { Id = i, Name = "Hello" + i, ShortName = "Hell" + i, Type = "Serious" + i });
            }
            return nt;
        }

    }

    class Test1
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ShortName { get; set; }
        public string Type { get; set; }
    }





}
