﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RectCheckItem.aspx.cs" Inherits="Pages_Office_HumanManager_RectCheckItem" %>
<%@ Register src="../../../UserControl/Message.ascx" tagname="Message" tagprefix="uc1" %>
<%@ Register src="../../../UserControl/CodingRuleControl.ascx" tagname="CodingRule" tagprefix="uc1" %>
<%@ Register src="../../../UserControl/CodeTypeDrpControl.ascx" tagname="CodeType" tagprefix="uc1" %>
<%@ Register src="../../../UserControl/SysParamDrpControl.ascx" tagname="SysParam" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>面试评测模板设置</title>
    <link rel="stylesheet" type="text/css" href="../../../css/default.css" />
    <script src="../../../js/common/check.js" type="text/javascript"></script>
    <script src="../../../js/JQuery/jquery_last.js" type="text/javascript"></script>
    <script src="../../../js/common/Common.js" type="text/javascript"></script>
    <script src="../../../js/office/HumanManager/HRProxy_Edit.js" type="text/javascript"></script>
</head>
<body>
<form id="frmMain" runat="server">
<table width="98%" border="0" cellpadding="0" cellspacing="0" class="maintable" id="mainindex">
    <tr>
        <td valign="top" colspan="2">
            <img src="../../../images/Main/Line.jpg" width="122" height="7" />
        </td>
    </tr>
    <tr>
        <td height="30" align="center" colspan="2" class="Title"><div id="divTitle" runat="server">面试评测模板设置</div></td>
    </tr>
    <tr>
        <td height="40" valign="top" colspan="2">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                <tr>
                    <td height="30" class="tdColInput">
                        <img src="../../../Images/Button/Bottom_btn_save.jpg" runat="server" visible="false" alt="保存" id="btnSave" style="cursor:hand"   onclick="SaveHRProxyInfo();"/>
                        <img src="../../../Images/Button/Main_btn_print.jpg" alt="打印" id="btnPrint" style="cursor:hand"  />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr><td>
<div style="height:500px;overflow-y:scroll;">
<table width="98%" border="0" cellpadding="0" cellspacing="0" id="tblmain">
    <tr>
        <td  colspan="2">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                <tr>
                    <td height="20" bgcolor="#F4F0ED" class="Blue">
                        <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr>
                                <td>企业信息</td>
                                <td align="right">
                                    <div id='divCompanyInfo'>
                                        <img src="../../../images/Main/Close.jpg" style="CURSOR: pointer"  onclick="oprItem('tblCompanyInfo','divCompanyInfo')"/>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table><tr><td colspan="2" height="4"><input type="hidden" id="hidEditFlag" runat="server" /></td></tr></table>
            <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999" id="tblCompanyInfo" style="display:block">
                <tr>
                    <td height="20" align="right" class="tdColTitle" width="10%">企业编号<span class="redbold">*</span></td>
                    <td height="20" class="tdColInput" width="23%">
                        <div id="divCodeRule" runat="server">
                            <uc1:CodingRule ID="codruleProxy" runat="server" />
                        </div>
                        <div id="divProxyCompanyNo" runat="server" class="tdinput"></div>
                    </td>
                    <td height="20" align="right" class="tdColTitle" width="10%">企业名称<span class="redbold">*</span></td>
                    <td height="20" class="tdColInput" width="23%">
                        <asp:TextBox ID="txtProxyCompanyName" runat="server" MaxLength="50" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle" width="10%">企业性质</td>
                    <td height="20" class="tdColInput" width="24%">
                        <asp:TextBox ID="txtNature" runat="server" MaxLength="50" CssClass="tdinput"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td height="20" align="right" class="tdColTitle" >地址<span class="redbold">*</span></td>
                    <td height="20" class="tdColInput">
                        <asp:TextBox ID="txtAddress" runat="server" MaxLength="50" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle">企业法人<span class="redbold">*</span></td>
                    <td height="20" class="tdColInput" >
                        <asp:TextBox ID="txtCorporate" runat="server" MaxLength="25" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle" >合作关系</td>
                    <td height="20" class="tdColInput">
                        <asp:DropDownList ID="ddlCooperation" runat="server">
                            <asp:ListItem Value="1">付费服务</asp:ListItem>
                            <asp:ListItem Value="2">一般服务</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td height="20" align="right" class="tdColTitle" >电话</td>
                    <td height="20" class="tdColInput" >
                        <asp:TextBox ID="txtTel" runat="server" MaxLength="25" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle" >传真</td>
                    <td height="20" class="tdColInput">
                        <asp:TextBox ID="txtFax" runat="server" MaxLength="25" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle">邮箱</td>
                    <td height="20" class="tdColInput" >
                        <asp:TextBox ID="txtMail" runat="server" MaxLength="50" CssClass="tdinput"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td height="20" align="right" class="tdColTitle" >网址</td>
                    <td height="20" class="tdColInput" >
                        <asp:TextBox ID="txtWebsite" runat="server" MaxLength="150" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle" >重要程度</td>
                    <td height="20" class="tdColInput" >
                        <asp:DropDownList ID="ddlImportant" runat="server">
                            <asp:ListItem Value="1">不重要</asp:ListItem>
                            <asp:ListItem Value="2">普通</asp:ListItem>
                            <asp:ListItem Value="3">重要</asp:ListItem>
                            <asp:ListItem Value="4">关键</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td height="20" align="right" class="tdColTitle" >启用状态</td>
                    <td height="20" class="tdColInput">
                        <input type="checkbox" id="chkUsedStatus" value="1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td height="20" align="right" class="tdColTitle">收费标准</td>
                    <td height="20" class="tdColInput" colspan="5">
                        <asp:TextBox ID="txtStandard" runat="server" TextMode="MultiLine" Width="80%" MaxLength="250" CssClass="tdinput"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr><td colspan="2" height="10"></td></tr>  
    <tr>
        <td height="25" valign="top" >
            <span class="Blue">
                <img src="../../../images/Main/Arrow.jpg" width="21" height="18" align="absmiddle" />联系人信息
            </span>
        </td>
        <td align="right" valign="top">
            <div id='divContractInfo'>
                <img src="../../../images/Main/close.jpg" style="CURSOR: pointer"  onclick="oprItem('tblContractInfo','divContractInfo')"/>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <table width="99%" border="0" id="tblContractInfo" style="BEHAVIOR:url(../../../draggrid.htc)"  align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                <tr>
                    <td height="20" align="right" class="tdColTitle" width="10%">姓名<span class="redbold">*</span></td>
                    <td height="20" class="tdColInput" width="23%">
                        <asp:TextBox ID="txtContactName" runat="server" MaxLength="25" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle" width="10%">固定电话</td>
                    <td height="20" class="tdColInput" width="23%">
                        <asp:TextBox ID="txtContactTel" runat="server" MaxLength="25" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle" width="10%">移动电话</td>
                    <td height="20" class="tdColInput" width="24%">
                        <asp:TextBox ID="txtContactMobile" runat="server" MaxLength="25" CssClass="tdinput"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td height="20" align="right" class="tdColTitle">网络通讯</td>
                    <td height="20" class="tdColInput" >
                        <asp:TextBox ID="txtContactWeb" runat="server" MaxLength="50" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle">工号</td>
                    <td height="20" class="tdColInput" >
                        <asp:TextBox ID="txtContactCardNo" runat="server" MaxLength="50" CssClass="tdinput"></asp:TextBox>
                    </td>
                    <td height="20" align="right" class="tdColTitle" >公司职务</td>
                    <td height="20" class="tdColInput">
                        <asp:TextBox ID="txtContactPosition" runat="server" MaxLength="25" CssClass="tdinput"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td height="20" align="right" class="tdColTitle">备注</td>
                    <td height="20" class="tdColInput" colspan="5">
                        <asp:TextBox ID="txtContactRemark" runat="server" MaxLength="100" TextMode="MultiLine" Width="80%" Height="50" CssClass="tdinput"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr><td colspan="2" height="10"></td></tr>  
    <tr>
        <td height="25" valign="top" >
            <span class="Blue">
                <img src="../../../images/Main/Arrow.jpg" width="21" height="18" align="absmiddle" />附加信息
            </span>
        </td>
        <td align="right" valign="top">
            <div id='divAdditionalInfo'>
                <img src="../../../images/Main/close.jpg" style="CURSOR: pointer"  onclick="oprItem('tblAdditionalInfo','divAdditionalInfo')"/>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <table width="99%" border="0" id="tblAdditionalInfo" style="BEHAVIOR:url(../../../draggrid.htc)"  align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                <tr>
                    <td height="20" align="right" class="tdColTitle" width="10%">附加信息</td>
                    <td class="tdColInput">
                        <asp:TextBox ID="txtAdditional" CssClass="tdinput" runat="server" TextMode="MultiLine" Height="50" MaxLength="100" Width="80%"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr> 
</table>
</div>
</td>
</tr>
</table>
<div id="popupContent"></div>
<span id="Forms" class="Spantype"></span>
<uc1:Message ID="msgError" runat="server" />
</form>
</body>
</html>
