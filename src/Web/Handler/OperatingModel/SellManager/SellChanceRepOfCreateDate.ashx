﻿<%@ WebHandler Language="C#" Class="SellChanceRepOfCreateDate" %>

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

public class SellChanceRepOfCreateDate : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        GetLsit(context);
    }


    /// <summary>
    /// 获取数据列表
    /// </summary>
    private void GetLsit(HttpContext context)
    {
        //设置行为参数
        string orderString = (context.Request.Form["orderby"].ToString());//排序
        string order = "asc";//排序：升序
        string orderBy = (!string.IsNullOrEmpty(orderString)) ? orderString.Substring(0, orderString.Length - 2) : "IntendDate";//要排序的字段，如果为空，默认为"ID"
        if (orderString.EndsWith("_d"))
        {
            order = "desc";//排序：降序
        }
        int pageCount = int.Parse(context.Request.Form["pageCount"].ToString());//每页显示记录数
        int pageIndex = int.Parse(context.Request.Form["pageIndex"].ToString());//当前页

        int totalCount = 0;
        string ord = orderBy + " " + order;

        DataTable dt = new DataTable();

        string strCreateDate = context.Request.Params["CreateDate"].ToString().Trim();
        string strCreateDate1 = context.Request.Params["CreateDate1"].ToString().Trim();


        DateTime CreateDate = Convert.ToDateTime(strCreateDate);
        DateTime CreateDate1 = Convert.ToDateTime(strCreateDate1);

        dt = SellChanceBus.GetChanceOfCreateDate(CreateDate, CreateDate1, pageIndex, pageCount, ord, ref totalCount);
        
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("{");
        sb.Append("totalCount:");
        sb.Append(totalCount.ToString());
        sb.Append(",data:");
        if (dt.Rows.Count == 0)
            sb.Append("[{\"IntendDate\":\"\"}]");
        else
            sb.Append(JsonClass.DataTable2Json(dt));
        sb.Append("}");

        context.Response.ContentType = "text/plain";
        context.Response.Write(sb.ToString());
        context.Response.End();
    }

   
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}