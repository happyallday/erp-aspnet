﻿<%@ WebHandler Language="C#" Class="CustReceivables" %>

using System;
using System.Web;
using System.Collections;
using System.Data;
using System.Linq;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Web.Script.Serialization;
using System.IO;
using XBase.Common;
using XBase.Business.Office.SellManager;
using XBase.Model.Office.SellManager;
using System.Web.SessionState;

public class CustReceivables : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.RequestType == "POST")
        {
            int User = ((UserInfoUtil)SessionUtil.Session["UserInfo"]).EmployeeID;
            string CompanyCD = ((UserInfoUtil)SessionUtil.Session["UserInfo"]).CompanyCD;
            //设置行为参数
            string orderString = (context.Request.Form["orderBy"]);//排序
            string order = "asc";//排序：升序
            string orderBy = (!string.IsNullOrEmpty(orderString)) ? orderString.Substring(0, orderString.Length - 2) : "TotalPrice";//要排序的字段，如果为空，默认为"ID"
            if (orderString.EndsWith("_d"))
            {
                order = "desc";//排序：降序
            }
            int pageCount = int.Parse(context.Request.Form["pageCount"].ToString());//每页显示记录数
            int pageIndex = int.Parse(context.Request.Form["pageIndex"].ToString());//当前页
            int skipRecord = (pageIndex - 1) * pageCount;//跳过记录数
            string CustNo = context.Request.Form["CustNo"].ToString();
            string CustName = context.Request.Form["CustName"].ToString();
            string BeginDate = context.Request.Form["BeginDate"].ToString();
            string EndDate = context.Request.Form["EndDate"].ToString();
            string myOrderby = orderBy+" "+order;
            int TotalCount=0;
            DataTable dt = new DataTable();
            string SelectColumn = context.Request.Form["SelectColumn"].ToString();
            if (SelectColumn == "1")
            {
                dt = SellProductReportBus.GetReceivables(CustNo, CustName, BeginDate, EndDate, pageIndex, pageCount, myOrderby, ref TotalCount);
            }
            if (SelectColumn == "2")
            {
                dt = SellProductReportBus.GetReceivablesAll(CustNo, CustName, BeginDate, EndDate, pageIndex, pageCount, myOrderby, ref TotalCount);
            }

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("{");
            sb.Append("totalCount:");
            sb.Append(TotalCount.ToString());
            sb.Append(",data:");
            if (dt.Rows.Count == 0)
                sb.Append("[{\"ID\":\"\"}]");
            else
                sb.Append(JsonClass.DataTable2Json(dt));
        
            sb.Append("}");
            context.Response.ContentType = "text/plain";
            context.Response.Write(sb.ToString());
            context.Response.End();
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


    
}