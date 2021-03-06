﻿

var pageCount = 10; //每页计数
var totalRecord = 0;
var pagerStyle = "flickr"; //jPagerBar样式
var currentPageIndex = 1;
var orderBy = ""; //排序字段

$(document).ready(function() {
   TurnToPage(1);
});



function TurnToPage(pageIndex) {
     
    currentPageIndex = pageIndex;
    var Action=$("#HAction").val();
    var Status=$("#HStatus").val();
    var Type=$("#HType").val();
    var StartDate=$("#HStartDate").val();
    var EndDate=$("#HEndDate").val();
    var Name=$("#HName").val();
    
    var strUrl ='Status='+Status+'&Type='+Type+'&StartDate='+escape(StartDate)+'&EndDate='+escape(EndDate)+ '&Name='+escape(Name)+ '&pageIndex=' + pageIndex + '&pageSize=' + pageCount + '&orderby=' + escape(orderBy) +'&action='+Action;
        
    if(Action.indexOf("Trend")!=-1)
    {
        strUrl+='&DataType='+$("#HDataType").val()+'&GroupType='+$("#HGroupType").val()+'&DeptOrEmployeeId='+$("#HDeptOrEmployeeId").val();
    } 
    $.ajax({
        type: "POST", //用POST方式传输
        dataType: "json", //数据格式:JSON
        url: '../../../Handler/OperatingModel/SellManager/SellContract.ashx', //目标地址
        cache: false,
        data: strUrl,
        beforeSend: function() { AddPop(); $("#pageDataList1_Pager").hide(); }, //发送数据之前
        success: function(msg) {
            //数据获取完毕，填充页面据显示
            //数据列表
            $("#pageDataList1 tbody").find("tr.newrow").remove();
            $.each(msg.data, function(i, item) {
            if (item.ContractNo != null && item.ContractNo != "") {
                var ContractNo = item.ContractNo;
                var Title = item.Title;
                var OfferNo = item.OfferNo
                if (Title != null) {
                    if (Title.length > 15) {
                        Title = Title.substring(0, 15) + '...';
                    }
                }
                if (OfferNo != null) {
                    if (OfferNo.length > 15) {
                        OfferNo = OfferNo.substring(0, 15) + '...';
                    }
                }
                if (ContractNo != null) {
                    if (ContractNo.length > 15) {
                        ContractNo = ContractNo.substring(0, 15) + '...';
                    }
                }
                $("<tr class='newrow'></tr>").append(
                    "<td height='22' align='center'>" + ContractNo + "</td>" +
                    "<td height='22' align='center'><span title=\"" + item.Title + "\">" + Title + "</a></td>" +
                    "<td height='22' align='center'>" + item.FromTypeText + "</td>" +
                    "<td height='22' align='center'><span title=\"" + item.OfferNo + "\">" + OfferNo + "</td>" +
                    "<td height='22' align='center'>" + item.EmployeeName + "</td>" +
                    "<td height='22' align='center'>" + item.CustName + "</td>" +
                    "<td height='22' align='center'>" + (parseFloat(item.TotalFee)).toFixed($("#hidPoint").val()) + "</td>" +
                    "<td height='22' align='center'>" + item.stateText + "</td>" +
                    "<td height='22' align='center'>" + item.BillStatusText + "</td>" +
                    "<td height='22' align='center'>" + item.FlowInstanceText + "</td>").appendTo($("#pageDataList1 tbody"));
                }
            });
            //页码
            ShowPageBar("pageDataList1_Pager", //[containerId]提供装载页码栏的容器标签的客户端ID
                   "<%= Request.Url.AbsolutePath %>", //[url]
                    {style: pagerStyle, mark: "pageDataList1Mark",
                    totalCount: msg.totalCount, showPageNumber: 3, pageCount: pageCount, currentPageIndex: pageIndex, noRecordTip: "没有符合条件的记录", preWord: "上一页", nextWord: "下一页", First: "首页", End: "末页",
                    onclick: "TurnToPage({pageindex});return false;"}//[attr]
                    );
            totalRecord = msg.totalCount;
            $("#ShowPageCount").val(pageCount);
            ShowTotalPage(msg.totalCount, pageCount, pageIndex, $("#pageSellOffcount"));
            $("#ToPage").val(pageIndex);
        },
        error: function() { popMsgObj.ShowMsg('请求发生错误！'); },
        complete: function() { hidePopup(); $("#pageDataList1_Pager").show(); Ifshow(document.form1.elements["Text2"].value); pageDataList1("pageDataList1", "#E7E7E7", "#FFFFFF", "#cfc", "cfc"); } //接收数据完毕
    });

}




//table行颜色
function pageDataList1(o, a, b, c, d) {
    var t = document.getElementById(o).getElementsByTagName("tr");
    for (var i = 0; i < t.length; i++) {
        t[i].style.backgroundColor = (t[i].sectionRowIndex % 2 == 0) ? a : b;

        t[i].onmouseover = function() {
            if (this.x != "1") this.style.backgroundColor = c;
        }
        t[i].onmouseout = function() {
            if (this.x != "1") this.style.backgroundColor = (this.sectionRowIndex % 2 == 0) ? a : b;
        }
    }
}



function Ifshow(count) {
    if (count == "0") {
        document.getElementById("divpage").style.display = "none";
        document.getElementById("pageSellOffcount").style.display = "none";
    }
    else {
        document.getElementById("divpage").style.display = "block";
        document.getElementById("pageSellOffcount").style.display = "block";
    }
}

//查看明细 /// <reference path="" />
//pageIndex=1&pageCount=10&orderby=&ChanceNo=&Title=&CustID=&Seller=&Phase=

function fnOrderInfo(retval, isRef) {
    window.location.href = '../../../Pages/Office/SellManager/SellContractMod.aspx?id=' + escape(retval) + "&islist=1&ModuleID=2031401&isRef=" + isRef;
}

//改变每页记录数及跳至页数
function ChangePageCountIndex(newPageCount, newPageIndex) {

    var fieldText = "";
    var msgText = "";
    var isFlag = true;
    $("#checkall").removeAttr("checked")
    if (!IsNumber(newPageIndex) || newPageIndex == 0) {
        isFlag = false;
        fieldText = fieldText + "跳转页面|";
        msgText = msgText + "必须为正整数格式|";
    }
    if (!IsNumber(newPageCount) || newPageCount == 0) {
        isFlag = false;
        fieldText = fieldText + "每页显示|";
        msgText = msgText + "必须为正整数格式|";
    }
    if (!isFlag) {
        popMsgObj.Show(fieldText, msgText);
    }
    else {
        if (newPageCount <= 0 || newPageIndex <= 0 || newPageIndex > ((totalRecord - 1) / newPageCount) + 1) {
            showPopup("../../../Images/Pic/Close.gif", "../../../Images/Pic/note.gif", "转到页数超出查询范围！");
            return false;
        }
        else {
            this.pageCount = parseInt(newPageCount);
            TurnToPage(parseInt(newPageIndex));
        }
    }
}
  function OrderBy(orderColum, orderTip) {
 
        var ordering = "d";
        var allOrderTipDOM = $(".orderTip");
        if ($("#" + orderTip).html() == "↑") {
            allOrderTipDOM.empty();
            $("#" + orderTip).html("↓");
        }
        else {
            ordering = "a";
            allOrderTipDOM.empty();
            $("#" + orderTip).html("↑");
        }
        orderBy = orderColum + "_" + ordering;
        TurnToPage(1);
    }
