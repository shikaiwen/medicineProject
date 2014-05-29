<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<link rel="stylesheet" href="<%=base%>cssfiles/drp.css">

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/self_location.css">

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(function(){
		//获取分销商级别
		$.ajax({
			url:'<%=base%>/datadict/DictAction!getDictHtml.action?dict.category=A',
			success:function(datas){
				$("#agent_level").html(datas);
			}
		})
	})
</script>

<body>
	<div>
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>&nbsp;
							
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="<%=base%>/images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>基础数据管理&gt;&gt;<span id="operate_module">分销商维护</span></b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
	<div style="margin-right:auto;margin-left:auto;width:500px">
		<table id="contentTable">
			<!-- <tr><td>分销商代码:</td><td><input type="text" id="userId"></td></tr> -->
			<tr><td>名称:</td><td><input type="text" id="userName"></td></tr>
			<tr><td>联系电话:</td><td><input type="text" id="contactTel"></td></tr>
			<tr><td>电子邮件:</td><td><input type="text" id="email"></td></tr>
			<tr><td>分销商级别:</td><td><select type="text" id="agent_level"></select></td></tr>
			<tr><td>地址:</td><td>省份<select type="text" id="address.province"></select></td></tr>
		</table>
		
		<div id="oper_button" style="margin-left:20px;margin-top:20px">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="addUser()">保存</a>&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>  
    </div> 
	</div>
 
    
</div>
    
    
</body>
</html>