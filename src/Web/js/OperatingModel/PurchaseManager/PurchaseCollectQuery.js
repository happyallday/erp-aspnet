﻿/* 分页相关变量定义 */
var pageCount = 10; //每页显示记录数
var totalRecord = 0; //总记录数
var pagerStyle = "flickr"; //jPagerBar样式
var currentPageIndex = 1; //当前页
var orderBy = ""; //排序字段


    $(document).ready(function()
{
    fnGetExtAttr();
});

  function ClearPkroductInfo()
{
document .getElementById ("ProductName").value="";
document .getElementById ("ProductID").value="";
closeProductdiv();
}

//查询条件
function fnGetSearch() {
    var Field = "";
    if(document.getElementById("ProductCount").checked == true)
        Field = "ProductCount";
    else if(document.getElementById("TotalFee").checked == true)
        Field = "TotalFee";
    else if(document.getElementById("TaxPrice").checked == true)
        Field = "TaxPrice";
    else if(document.getElementById("TotalPrice").checked == true)
        Field = "TotalPrice";
    else if(document.getElementById("UnitPrice").checked == true)
        Field = "UnitPrice";
    var strUrl = "";
    var ProviderID = $("#ProviderID").val();
    var ProductID = $("#ProductID").val();      
    var ProviderName = $("#ProviderName").val();
    var StartDate = $.trim($("#txtStartDate").val()); //开始日期
    var EndDate = $.trim($("#txtEndDate").val()); //截止日期

    strUrl = 'ProviderID=' + escape(ProviderID) +'&ProviderName=' + escape(ProviderName)+'&Field=' + escape(Field)+'&ProductID=' + escape(ProductID) + '&StartDate=' + escape(StartDate) + '&EndDate=' + escape(EndDate);
    $("#hiddSearch").val(strUrl);
    return strUrl;
}

/*
* 改页显示
*/
function ChangePageCountIndex(newPageCount, newPageIndex) {
    var fieldText = "";
    var msgText = "";
    var isFlag = true;
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

function Fun_FillParent_Content(id,no,productname,price,unitid,unit,taxrate,taxprice,discount,standard)
{
    $("#ProductID").val(id);
    $("#ProductName").val(productname);
}

function fnSearch()
{
    if (!CheckInput()) {
        return;
    }
    var ProviderNameS = $("#ProviderName").val();
    var ProviderName = ProviderNameS.split(',');
    for(var i=0;i<ProviderName.length;++i)
    {
        $("#thProvider"+i).css("display","inline");
        $("#Provider"+i).html(ProviderName[i]);
    }
    fnGetSearch();
    TurnToPage(currentPageIndex);
    
}

function GetValue()
{
    var ck = document.getElementsByName("CheckboxProdID");
    var ProdID = "";
    var ProdName = "";
    for( var i = 0; i < ck.length; i++ )
    {
        if ( ck[i].checked )
        {
           ProdID += ck[i].value+',';
           ProdName += document.getElementById("ProdNamejjj"+i).innerHTML+",";
        }
    }
    ProdID = ProdID.substring(0,ProdID.length-1);    
    ProdName = ProdName.substring(0,ProdName.length-1);
    $("#ProductName").val(ProdName);
    $("#ProductID").val(ProdID);
    closeProductdiv();
}  




function fnGetValue(item,i,ColName)
{
    
}
/*
* 翻页处理
*/
function TurnToPage(pageIndex) {

    var tds = "";
    
    var ProviderName = document.getElementById("ProviderName").value.split[','];
//    if(ProviderName != "")
//    {
//        var ProviderNames = ProviderName.split(',');
//        
//        for(var i=0;i<ProviderNames.length;++i)
//        {
//            tds +=  "<td height='22' align='center'>" + ProviderNames[i] + "</td>"
//        }
//    }
    //设置当前页
    currentPageIndex = pageIndex;

    var strUrl = "Action=Select&"+$("#hiddSearch").val() + '&pageIndex=' + pageIndex + '&pageCount=' + pageCount + '&orderby=' + escape(orderBy);
    
    $.ajax({
        type: "POST", //用POST方式传输
        url: '../../../Handler/OperatingModel/PurchaseManager/PurchaseCollectQuery.ashx', //目标地址
        dataType: "html", //数据格式:JSON
        cache: false,
        data: strUrl,
        beforeSend: function() {
            AddPop();
        }, //发送数据之前
        success: function(msg) {
            //数据获取完毕，填充页面据显示
            //数据列表
            $("#tblDetailInfo tbody").find("tr.newrow").remove();
            if (msg != null) {
            
                document.getElementById("hhhhh").innerHTML=msg;
                document.getElementById("hhhhh").style.display="block";

//                if (msg.data.length != 0) {
                    $("#btnPrint").css("display", "inline");
//                    
//                    
//                    
//                    
////                    $.each(msg.data, function(i, item) {
//////                    for(var jjj in item)
//////                    {
//////                        alert(jjj)
//////                    }            
////                    $("<tr class='newrow'></tr>").append(
////                         "<td height='22' align='center'>" + item.Product + "</td>"+
////                        "<td height='22' align='center'>" + item.ProviderName[0] + "</td>"+
////                        "<td height='22' align='center'>" + item.华研唱片有限公司 + "</td>"
////                       ).appendTo($("#tblDetailInfo tbody")
////                    );
////                    });
//                }
//                else {
//                    $("#btnPrint").css("display", "none");
//                }
//            }
//            else {
//                $("#btnPrint").css("display", "none");
            }


            //页码
//            ShowPageBar(
//                "divPageClickInfo", //[containerId]提供装载页码栏的容器标签的客户端ID
//                "<%= Request.Url.AbsolutePath %>", //[url]
//                {
//                style: pagerStyle, mark: "DetailListMark",
//                totalCount: $("#totalRecord").val(),
//                showPageNumber: 3,
//                pageCount: pageCount,
//                currentPageIndex: pageIndex,
//                noRecordTip: "没有符合条件的记录",
//                preWord: "上一页",
//                nextWord: "下一页",
//                First: "首页",
//                End: "末页",
//                onclick: "TurnToPage({pageindex});return false;"
//            }
//            );
//            totalRecord = msg.totalCount;
//            $("#txtShowPageCount").val(pageCount);
//            ShowTotalPage(msg.totalCount, pageCount, pageIndex, $("#pagecount"));
//            $("#txtToPage").val(pageIndex);
        },
        error: function() {
            popMsgObj.ShowMsg('请求发生错误！');
        },
        complete: function() {
            hidePopup();
//            $("#divPageClickInfo").show();
//            SetTableRowColor("tblDetailInfo", "#E7E7E7", "#FFFFFF", "#cfc", "cfc");
        }
    });
}

//打印
function fnPrint() {
    
//    if(ordering=="a")
//    {
//        ordering="asc";
//    }
//    else
//    {
//        ordering="desc"
//    }
   
    var strRul = $("#hiddSearch").val();
    window.open("PurchaseCollectQueryPrint.aspx?orderby="+orderBy+"&ordering="+"&" + strRul);
}

/*

*
* 设置数据明细表的行颜色
*/
function SetTableRowColor(elem, colora, colorb, colorc, colord) {
    //获取DIV中 行数据
    var tableTr = document.getElementById(elem).getElementsByTagName("tr");
    for (var i = 0; i < tableTr.length; i++) {
        //设置行颜色
        tableTr[i].style.backgroundColor = (tableTr[i].sectionRowIndex % 2 == 0) ? colora : colorb;
        //设置鼠标落在行上时的颜色
        tableTr[i].onmouseover = function() {
            if (this.x != "1") this.style.backgroundColor = colorc;
        }
        //设置鼠标离开行时的颜色
        tableTr[i].onmouseout = function() {
            if (this.x != "1") this.style.backgroundColor = (this.sectionRowIndex % 2 == 0) ? colora : colorb;
        }
    }
}


/*
* 排序处理
*/
function Order(orderColum, orderTip) {
  
    var ordering = "a";
    //var orderTipDOM = $("#"+orderTip);
    var allOrderTipDOM = $(".orderTip");
   
    if ($("#" + orderTip).html() == "↓") {
        allOrderTipDOM.empty();
        $("#" + orderTip).html("↑");
    }
    else {
        ordering = "d";
        allOrderTipDOM.empty();
        $("#" + orderTip).html("↓");
    }
    orderBy = orderColum + "_" + ordering;
 
    TurnToPage(1);
}




//表单验证
function CheckInput() {
    var fieldText = "";
    var isFlag = true;
    var msgText = "";
    var ProviderID = $("#ProviderID").val();
    if(ProviderID == "")
    {
        isFlag = false;
        fieldText = fieldText + "供应商|";
        msgText = msgText + "请选择供应商|";
    }
    
    var FindDate = $.trim($("#txtStartDate").val()); //发现日期
    var FindDate1 = $.trim($("#txtEndDate").val()); //发现日期
    if(FindDate == "")
    {
        isFlag = false;
        fieldText = fieldText + "起始日期|";
        msgText = msgText + "请选择起始日期|";
    }
    if (FindDate1 == '') {
        isFlag = false;
        fieldText = fieldText + "结束日期|";
        msgText = msgText + "请选择结束日期|";
    }
    if (FindDate != '' && FindDate1 != '') {
        if (CompareDate(FindDate, FindDate1) == 1) {
            isFlag = false;
            fieldText = fieldText + "日期|";
            msgText = msgText + "结束日期不能早于起始日期|";
        }
    }
    if (!isFlag) {
        //注：两个方法显示弹出提示信息层,方法一是对字段用红色处理，方法二是所有的提示信息传入未处理颜色

        //方法一
        popMsgObj.Show(fieldText, msgText);

        //方法二
        //popMsgObj.ShowMsg('所有的错误信息字符串');
    }
    return isFlag;
}