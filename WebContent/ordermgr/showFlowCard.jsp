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
<title>��������</title>

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/layout.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>
<%@ taglib uri="/struts-tags" prefix="s"%>
<script type="text/javascript">
//ȷ���ջ�
function submit(){
	var flowCardId = $("#flowCardId").val();
	//��������Ϊ�Ѿ���ɣ���������Ϊ���ջ�
	var data = new Object();
	data['flowCard.flowCardId'] = flowCardId;
	$.ajax({
		type:'POST',
		url:'<%=base%>flowCard/FlowCardAction!changeOrderState.action',
		data:data,
		success:function(datas){
			alert("�����ɹ�");
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
							<b>��������&gt;&gt;�������</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
				

		<table width="500px" align="center">
			<tr><td>ҩƷ����</td><td>ҩƷ����</td><td>ͨ������</td><td>����</td></tr>
			<s:iterator value="flowCardDetailList" var="flowCardDetail">
			<tr>
				<td><s:property value="#flowCardDetail.medicine.medicineNo"/></td>
				<td><s:property value="#flowCardDetail.medicine.medicineName"/></td>
				<td><s:property value="#flowCardDetail.medicine.normalName"/></td>
				<td><s:property value="#flowCardDetail.quantity"/></td>
			</tr>
			</s:iterator>
		</table>
		<span id="saveSpan" style="margin-left:800px"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submit()">ȷ���ջ�</a>&nbsp;&nbsp;&nbsp;</span>
		<input type="hidden" name="flowCardId" id="flowCardId" value="<s:property value='flowCard.flowCardId'/>"/> 
</body>
<script>

</script>
</html>
