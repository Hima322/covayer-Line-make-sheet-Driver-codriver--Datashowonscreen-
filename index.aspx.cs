using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace WebApplication2
{
    public partial class index : System.Web.UI.Page
    {
        //this variable will store all valrient according model
        public List<MODEL> ModelList = new List<MODEL>();
        public List<MODEL_DEATILS> VariantList = new List<MODEL_DEATILS>();

        public string SelectedModel = "";
        public static string CurrentError = "";

        protected void Page_Load(object sender, EventArgs e)
        { 
            GET_MODEL();
            if (Request.Params.Get("model") == null && ModelList.Count != 0)
            {
                SelectedModel = ModelList[0].ModelName;
            }
            if (SelectedModel != "")
            {
                GET_VARIANT(SelectedModel);
            }
        }

        private void GET_VARIANT(string model)
        {
            try
            {
                TMdbEntities mdbEntities = new TMdbEntities();
                var models = mdbEntities.MODEL_DEATILS.Where(i => i.Model == model).ToList();
                VariantList.AddRange(models);
            }
            catch (Exception ex)
            {
                CurrentError = ex.Message;
            }
        }

        private void GET_MODEL()
        {
            try
            {
                TMdbEntities mdbEntities = new TMdbEntities();
                var models = mdbEntities.MODELs.ToList();
                ModelList.AddRange(models);
                SelectedModel = Request.Params.Get("model");
            }
            catch (Exception ex)
            {
                CurrentError = ex.Message;
            }
        }

        [WebMethod]
        public static bool ADD_MODEL(string model, string customer,string partnumber)
        {
            try
            {
                using (TMdbEntities mdbEntities = new TMdbEntities())
                {
                    MODEL md = new MODEL
                    {
                        ModelName = model,
                        PartNumber = partnumber,
                        CustomerName = customer
                    };
                    mdbEntities.MODELs.Add(md);
                    mdbEntities.SaveChanges();
                    return true;
                }
            } catch (Exception ex)
            {
                CurrentError = ex.Message;
                return false;
            }               
        }

        [WebMethod]
        public static bool HandleDelete(int id)
        {
            try
            {
                using (TMdbEntities mdbEntities = new TMdbEntities())
                {
                    var res = mdbEntities.MODEL_DEATILS.Where(i => i.ID == id).FirstOrDefault();
                    if (res != null)
                    {
                        mdbEntities.MODEL_DEATILS.Remove(res);
                        mdbEntities.SaveChanges();
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
            return false;
        }
    }
}