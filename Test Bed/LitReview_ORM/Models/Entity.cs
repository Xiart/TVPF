using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace LitReview_ORM.Models
{
    public partial class Entity
    {
        [Key]
        public int Id { get; set; }
        public string Value { get; set; }

        public string EFC_InsertOne(List<Entity> lst)
        {
            DateTime StartDate = DateTime.Now;
            using (var con = new TestingContext())
            {
                foreach (var itm in lst)
                {
                    con.Database.ExecuteSqlCommand($"EFC_InsertOne  {itm.Id},{itm.Value}");
                }
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string EFC_BulkInsert(List<Entity> lst)
        {
            DateTime StartDate = DateTime.Now;
            using(var con = new TestingContext())
            {            
                con.Entity.AddRange(lst);
                con.SaveChanges();
            }          
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string EFC_Select(int count)
        {
            DateTime StartDate = DateTime.Now;
            using (var con = new TestingContext())
            {
                var lst = con.Entity.FromSqlRaw("EFC_Select @p0", count);
            }
                return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string EFC_Update(List<Entity> lst)
        {
            DateTime StartDate = DateTime.Now;
            using (var con = new TestingContext())
            {
                foreach (var itm in lst)
                {
                    int x = con.Database.ExecuteSqlCommand($"EFC_Update { itm.Id},{itm.Value }");
                }
            }
                return (DateTime.Now - StartDate).Milliseconds.ToString();
        }

        public string EFC_UpdateBatch(List<Entity> lst)
        {
            DateTime StartDate = DateTime.Now;
            using (var con = new TestingContext())
            {
                con.Entity.UpdateRange(lst);
                con.SaveChanges();
            }
                return (DateTime.Now - StartDate).Milliseconds.ToString();
        }
        public string EFC_Delete(List<Entity> lst)
        {
            DateTime StartDate = DateTime.Now;
            using (var con = new TestingContext())
            {
                foreach (var itm in lst)
                {
                    int x = con.Database.ExecuteSqlCommand($"EFC_Delete { itm.Id }");
                }
            }
            return (DateTime.Now - StartDate).Milliseconds.ToString();
        }
        public string EFC_DeleteBatch(List<Entity> lst)
        {
            DateTime StartDate = DateTime.Now;
            using (var con = new TestingContext())
            {
                con.Entity.RemoveRange(lst);
                con.SaveChanges();
            }
                return (DateTime.Now - StartDate).Milliseconds.ToString();
        }
    }
}
