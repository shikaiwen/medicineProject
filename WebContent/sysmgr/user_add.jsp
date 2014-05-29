<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
//out.write(basePath);
%>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		$("#btnAdd").click(function(){
			
			/*
			jQuery.dialog({
				width:100,
				height:100,
				content:'添加完成',
				lock:true
			});
			*/
		//	return;
			var result = validateForm();
			if(!result){
				return false;
			}
			
		//	var toSubmitArray = ["userId","userName","password","contactTel","email"];
			
		//	$("input[type='text']").attr("id").each(function(){
		//	})
			//$.ajax()
			var data = new Object();
		})
		
		
		$("#btnBack").click(function(){
			var toSubmitArray = ["userId","userName","password","contactTel","email"];
			var submitJson = {};
			
			for(var v=0;v<toSubmitArray.length;v++){
				$(submitJson).attr(toSubmitArray[v],'');
			}
			

			$("input[type='text']").each(function(){
				var id = $(this).attr("id");
				if(isExist(id,toSubmitArray)){
					submitJson[id] = $("#"+id).val();
				}
			})

		})
	})
	
	
	function isExist(id,toSubmitArray){
			for(var v=0;v<toSubmitArray.length;v++){
				if(id==toSubmitArray[v]){
					return true;
				}
			}
			return false;
	}
	
	function validateForm(){
		//var userName = $("#userName").val();
		//if($.trim(userName)==''||$.trim(userName).length<3){
			
		//}
	}
</script>
</head>
	<body class="body1">
		<form name="userForm" target="_self" id="userForm">
			<div align="center">
				<table width="95%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>&nbsp;
							
						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="25">
					<tr>
						<td width="522" class="p1" height="25" nowrap>
							<img src="<%=base%>images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>系统管理&gt;&gt;用户维护&gt;&gt;添加</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>用户代码:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="userId" type="text" class="text1" id="userId"
								size="10" maxlength="10">
						</td>
						<td>
							<span id="userIdSpan"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>用户名称:&nbsp;
							</div>
						</td>
						<td>
							<input name="userName" type="text" class="text1" id="userName"
								size="20" maxlength="20">
						</td>
						<td>
							<span id="userNameSpan"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>密码:&nbsp;
							</div>
						</td>
						<td>
							<label>
								<input name="password" type="password" class="text1"
									id="password" size="20" maxlength="20">
							</label>
						</td>
							<td>
							<span id="passwordSpan"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								联系电话:&nbsp;
							</div>
						</td>
						<td>
							<input name="contactTel" type="text" class="text1"
								id="contactTel" size="20" maxlength="20">
						</td>
							<td>
							<span id="contactTelSpan"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								email:&nbsp;
							</div>
						</td>
						<td>
							<input name="email" type="text" class="text1" id="email"
								size="20" maxlength="20">
						</td>
						<td>
							<span id="emailSpan"></span>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="添加" >
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" />
				</div>
			</div>
		</form>
	</body>
</html>