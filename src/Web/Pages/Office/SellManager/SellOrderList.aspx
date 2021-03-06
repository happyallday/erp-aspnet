<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SellOrderList.aspx.cs" Inherits="Pages_Office_SellManager_SellOrderList" %>

<%@ Register Src="../../../UserControl/Message.ascx" TagName="Message" TagPrefix="uc1" %>
<%@ Register Src="../../../UserControl/sellModuleSelectCustUC.ascx" TagName="sellModuleSelectCustUC"
    TagPrefix="uc2" %>
<%@ Register Src="../../../UserControl/SelectSellContractUC.ascx" TagName="SelectSellContractUC"
    TagPrefix="uc3" %>
<%@ Register Src="../../../UserControl/SelectSellOfferUC.ascx" TagName="SelectSellOfferUC"
    TagPrefix="uc4" %>
<%@ Register src="../../../UserControl/SelectSellChance.ascx" tagname="SelectSellChance" tagprefix="uc5" %>
<%@ Register src="../../../UserControl/GetBillExAttrControl.ascx" tagname="GetBillExAttrControl" tagprefix="uc6" %>
<%@ Register Src="../../../UserControl/Common/ProjectSelectControl.ascx" TagName="ProjectSelectControl" TagPrefix="uc15" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../../../css/default.css" />
    <link href="../../../css/pagecss.css" type="text/css" rel="Stylesheet" />

    <script src="../../../js/JQuery/jquery_last.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript" src="../../../js/common/PageBar-1.1.1.js"></script>

    <script src="../../../js/JQuery/formValidator.js" type="text/javascript"></script>

    <script src="../../../js/JQuery/formValidatorRegex.js" type="text/javascript"></script>

    <script src="../../../js/Calendar/WdatePicker.js" type="text/javascript"></script>

    <script src="../../../js/common/UserOrDeptSelect.js" type="text/javascript"></script>

    <script src="../../../js/common/check.js" type="text/javascript"></script>

    <script src="../../../js/common/page.js" type="text/javascript"></script>

    <script src="../../../js/common/Common.js" type="text/javascript"></script>

    <script src="../../../js/office/SellManager/SellOrderList.js" type="text/javascript"></script>

    <title>销售订单列表</title>
    <style type="text/css">
        .style1
        {
            width: 76px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <uc15:ProjectSelectControl ID="ProjectSelectControl1" runat="server" /><!--所属项目-->
    <a name="pageDataList1Mark"></a><span id="Forms" class="Spantype" name="Forms"></span>
    <input id="Seller" type="hidden" />
    <uc2:sellModuleSelectCustUC ID="sellModuleSelectCustUC1" runat="server" />
    <uc3:SelectSellContractUC ID="SelectSellContractUC1" runat="server" />
    <uc4:SelectSellOfferUC ID="SelectSellOfferUC1" runat="server" />
    <input type="hidden" id="hiddUrl" value="" />
    <input type="hidden" id="hiddExpOrder" runat="server" />
    <input type="hidden" id="hiddExpTotal" runat="server" />
    <uc5:SelectSellChance ID="SelectSellChance1" runat="server" />
    <script type="text/javascript">
        var precisionLength=<%=SelPoint %>;//小数精度
    </script>
    <table width="95%" height="57" border="0" cellpadding="0" cellspacing="0" class="checktable"
        id="mainindex">
        <tr>
            <td valign="top">
                <img src="../../../images/Main/Line.jpg" width="122" height="7" />
            </td>
            <td rowspan="2" align="right" valign="top">
                <div id='searchClick'>
                    <img src="../../../images/Main/Close.jpg" style="cursor: pointer" onclick="oprItem('searchtable_sellorser','searchClick')" /></div>
                &nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td valign="top" class="Blue">
                <img src="../../../images/Main/Arrow.jpg" width="21" height="18" align="absmiddle" />检索条件
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table width="99%" border="0" align="center" cellpadding="0" id="searchtable_sellorser" cellspacing="0"
                    bgcolor="#CCCCCC">
                    <tr>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC"
                                class="table">
                                <tr class="table-item">
                                    <td width="10%" height="20" bgcolor="#E7E7E7" align="right">
                                        订单编号
                                    </td>
                                    <td width="20%" bgcolor="#FFFFFF">
                                        <input type="text" class="tdinput" specialworkcheck="订单编号" style="width: 90%" id="orderNo" />
                                        <input type="hidden" id="hiddExpOrderNo" runat="server" />
                                    </td>
                                    <td width="10%" bgcolor="#E7E7E7" align="right">
                                        订单主题
                                    </td>
                                    <td width="20%" bgcolor="#FFFFFF">
                                        <input style="width: 90%" specialworkcheck="订单主题" id="Title" type="text" class="tdinput"
                                            size="15" />
                                        <input type="hidden" id="hiddExpTitle" runat="server" />
                                    </td>
                                    <td width="10%" bgcolor="#E7E7E7" align="right">
                                        源单类型
                                    </td>
                                    <td width="30%" bgcolor="#FFFFFF">
                                        <select name="FromType"  style="width: 120px;margin-top:2px;margin-left:2px;" id="FromType">
                                            <option value="" selected="selected">--请选择--</option>
                                            <option value="0">无来源</option>
                                            <option value="3">销售机会</option>
                                            <option value="1">销售报价单</option>
                                            <option value="2">销售合同</option>
                                        </select>
                                        <input type="hidden" id="hiddExpFromType" runat="server" />
                                    </td>
                                </tr>
                                <tr class="table-item">
                                    <td height="20" bgcolor="#E7E7E7" align="right">
                                        源单编号
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <input name="FromBillID" id="FromBillID" onclick="fnSelectOfferInfo()" class="tdinput"
                                            type="text" readonly="readonly" style="width: 90%" />
                                        <input type="hidden" id="hiddExpFromBillID" runat="server" />
                                    </td>
                                    <td bgcolor="#E7E7E7" align="right">
                                        总金额
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <input id="TotalPrice" onchange="Number_round(this,2)" class="tdinput" maxlength="100"
                                                        style="width: 60px;" type="text" />
                                                    <input type="hidden" id="hiddExpTotalPrice" runat="server" />
                                                </td>
                                                <td>
                                                    至
                                                </td>
                                                <td>
                                                    <input id="TotalPrice1" onchange="Number_round(this,2)" class="tdinput" maxlength="100"
                                                        style="width: 60px;" type="text" />
                                                    <input type="hidden" id="hiddExpTotalPrice1" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td bgcolor="#E7E7E7" align="right">
                                        业务员
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <input id="UserSeller" class="tdinput" onclick="fnSelectSeller()" readonly="readonly"
                                            style="width: 90%" type="text" />
                                        <input type="hidden" id="hiddExpSeller" runat="server" />
                                    </td>
                                </tr>
                                <tr class="table-item">
                                    <td height="20" bgcolor="#E7E7E7" align="right">
                                        客户
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <input name="CustID" id="CustID" class="tdinput" type="text" readonly="readonly"
                                            style="width: 90%" onclick="fnSelectCustInfo()" />
                                        <input type="hidden" id="hiddExpCustID" runat="server" />
                                    </td>
                                    <td bgcolor="#E7E7E7" align="right">
                                        是否已建单
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <select  style="width: 120px;margin-top:2px;margin-left:2px;" id="isOpenbill">
                                            <option value="" selected="selected">--请选择--</option>
                                            <option value="1">是</option>
                                            <option value="0">否</option>
                                        </select>
                                        <input type="hidden" id="hiddExpIsOpenbill" runat="server" />
                                    </td>
                                    <td bgcolor="#E7E7E7" align="right">
                                        发货情况
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <select  style="width: 120px;margin-top:2px;margin-left:2px;" id="SendPro">
                                            <option value="" selected="selected">--请选择--</option>
                                            <option value="已发货">已发货</option>
                                            <option value="部分发货">部分发货</option>
                                            <option value="未发货">未发货</option>
                                        </select>
                                        <input type="hidden" id="hiddExpSendPro" runat="server" />
                                    </td>
                                </tr>
                                <tr class="table-item">
                                    <td height="20" bgcolor="#E7E7E7" align="right">
                                        审批状态
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <select name="FlowStatus" style="width: 120px;margin-top:2px;margin-left:2px;" id="FlowStatus">
                                            <option value="" selected="selected">--请选择--</option>
                                            <option value="0">待提交</option>
                                            <option value="1">待审批</option>
                                            <option value="2">审批中</option>
                                            <option value="3">审批通过</option>
                                            <option value="4">审批不通过</option>
                                            <option value="5">撤销审批</option>
                                        </select>
                                        <input type="hidden" id="hiddExpFlowStatus" runat="server" />
                                    </td>
                                    <td bgcolor="#E7E7E7" align="right">
                                        单据状态
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <select name="BillStatus"  style="width: 120px;margin-top:2px;margin-left:2px;" id="BillStatus">
                                            <option value="" selected="selected">--请选择--</option>
                                            <option value="1">制单</option>
                                            <option value="2">执行</option>
                                            <option value="4">手工结单</option>
                                            <option value="5">自动结单</option>
                                        </select>
                                        <input type="hidden" id="hiddExpBillStatus" runat="server" />
                                    </td>
                                    <td align="right" bgcolor="#E6E6E6">
                                        <span id="OtherConditon" style="display:none">其他条件</span>
                                   </td>
                                   <td bgcolor="#FFFFFF">
                                        <uc6:GetBillExAttrControl ID="GetBillExAttrControl1" runat="server" />
                                   </td>
                                </tr>
                                <tr class="table-item">
                                    <td align="right" bgcolor="#E6E6E6">
                                        所属项目
                                    </td>
                                    <td align="left" bgcolor="#FFFFFF">
                                        <input id="ProjectID" class="tdinput" type="text" style="width:60%" readonly="readonly" onclick="ShowProjectInfo('ProjectID','hiddProjectID');"/>
                                        <%--<a href="#" onclick="fnClearProject();">清除选择</a>--%>
                                        <input id="hiddProjectID" type="hidden" runat="server" />
                                    </td>
                                    <td align="right" bgcolor="#E6E6E6">
                                    </td>
                                    <td align="left" bgcolor="#FFFFFF">
                                    </td>
                                    <td align="right" bgcolor="#E6E6E6">
                                    </td>
                                    <td align="left" bgcolor="#FFFFFF">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" align="center" bgcolor="#FFFFFF">
                                        <uc1:Message ID="Message1" runat="server" />
                                        <img runat="server" visible="false" alt="检索" src="../../../images/Button/Bottom_btn_search.jpg"
                                            style='cursor: pointer;' id="btnSearch" onclick='TurnToPage(1)' />&nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="95%" height="57" border="0" cellpadding="0" cellspacing="0" class="maintable"
        id="mainindex">
        <tr>
            <td valign="top">
                <img src="../../../images/Main/Line.jpg" width="122" height="7" />
            </td>
            <td align="center" valign="top">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td height="30" colspan="2" align="center" valign="top" class="Title">
                销售订单列表
            </td>
        </tr>
        <tr>
            <td height="35" colspan="2" valign="top">
                <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                    <tr>
                        <td height="28" bgcolor="#FFFFFF">
                            <img runat="server" visible="false" src="../../../images/Button/Bottom_btn_new.jpg"
                                id="btnNew" alt="新建" style='cursor: pointer;' onclick="fnNew()" />
                            <img runat="server" visible="false" src="../../../images/Button/Main_btn_delete.jpg"
                                alt="删除" onclick="fnDel()" style='cursor: pointer;' id="btnDel" />&nbsp;
                            <asp:ImageButton ID="btnImport" ImageUrl="../../../images/Button/Main_btn_out.jpg"
                                AlternateText="导出Excel" runat="server" OnClick="btnImport_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" id="pageDataListSOL"
                    bgcolor="#999999">
                    <tbody>
                        <tr>
                            <th height="20" align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                选择<input type="checkbox" visible="false" id="checkall" onclick="selectall()" value="checkbox" />
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('OrderNo','oGroup');return false;">
                                    订单编号<span id="oGroup" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('Title','oC1');return false;">
                                    订单主题<span id="oC1" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('CustName','oC2');return false;">
                                    客户<span id="oC2" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('FromTypeText','Span1');return false;">
                                    源单类型<span id="Span1" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('FromBillNo','Span2');return false;">
                                    源单编号<span id="Span2" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('OrderDate','Span3');return false;">
                                    订单日期<span id="Span3" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('RealTotal','Span4');return false;">
                                    折后含税金额<span id="Span4" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF"
                                class="style1">
                                <div class="orderClick" onclick="OrderBy('isOpenbillText','Span5');return false;">
                                    是否已建单<span id="Span5" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('isSendText','oC7');return false;">
                                    发货情况<span id="oC7" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF"
                                class="style1">
                                <div class="orderClick" onclick="OrderBy('YAccounts','oC4');return false;">
                                    回款金额<span id="oC4" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('BillStatusText','oC8');return false;">
                                    单据状态<span id="oC8" class="orderTip"></span></div>
                            </th>
                            <th align="center" background="../../../images/Main/Table_bg.jpg" bgcolor="#FFFFFF">
                                <div class="orderClick" onclick="OrderBy('FlowInstanceText','oC9');return false;">
                                    审批状态<span id="oC9" class="orderTip"></span></div>
                            </th>
                        </tr>
                    </tbody>
                </table>
                <br />
                <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999"
                    class="PageList">
                    <tr>
                        <td height="28" background="../../../images/Main/PageList_bg.jpg">
                            <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="PageList">
                                <tr>
                                    <td height="28" background="../../../images/Main/PageList_bg.jpg" width="40%">
                                        <div id="pageSellOffcount">
                                        </div>
                                    </td>
                                    <td height="28" align="right">
                                        <div id="pageDataList1_Pager" class="jPagerBar">
                                        </div>
                                    </td>
                                    <td height="28" align="right">
                                        <div id="divpage">
                                            &nbsp;<input name="text" type="text" id="Text2" style="display: none" />
                                            <span id="pageDataList1_Total"></span>每页显示
                                            <input name="text" type="text" id="ShowPageCount" maxlength="3" />
                                            条 转到第
                                            <input name="text" type="text" id="ToPage" maxlength="7" />
                                            页
                                            <img src="../../../images/Button/Main_btn_GO.jpg" style='cursor: pointer;' alt="go"
                                                align="absmiddle" onclick="ChangePageCountIndex($('#ShowPageCount').val(),$('#ToPage').val());" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br />
            </td>
        </tr>
    </table>
    
    </form>
</body>
</html>
