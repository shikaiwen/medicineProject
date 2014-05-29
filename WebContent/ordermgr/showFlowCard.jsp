<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
//out.write(basePath);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>订单管理</title>

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/layout.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>
<%@ taglib uri="/struts-tags" prefix="s"%>
<script type="text/javascript">
//确认收货
function submit(){
	var flowCardId = $("#flowCardId").val();
	//将订单设为已经完成，流向单设置为已收货
	var data = new Object();
	data['flowCard.flowCardId'] = flowCardId;
	$.ajax({
		type:'POST',
		url:'<%=base%>flowCard/FlowCardAction!changeOrderState.action',
		data:data,
		success:function(datas){
			alert("操作成功");
		}
	})
}
</script>
</head>
<body class="body1">
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="22" nowrap>&nbsp;
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="<%=base%>/images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>订单管理&gt;&gt;发货情况</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
				

		<table width="500px" align="center">
			<tr><td>药品代码</td><td>药品名称</td><td>通用名称</td><td>数量</td></tr>
			<s:iterator value="flowCardDetailList" var="flowCardDetail">
			<tr>
				<td><s:property value="#flowCardDetail.medicine.medicineNo"/></td>
				<td><s:property value="#flowCardDetail.medicine.medicineName"/></td>
				<td><s:property value="#flowCardDetail.medicine.normalName"/></td>
				<td><s:property value="#flowCardDetail.quantity"/></td>
			</tr>
			</s:iterator>
		</table>
		<span id="saveSpan" style="margin-left:800px"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submit()">确认收货</a>&nbsp;&nbsp;&nbsp;</span>
		<input type="hidden" name="flowCardId" id="flowCardId" value="<s:property value='flowCard.flowCardId'/>"/> 
</body>
<script>

</script>
</html>
