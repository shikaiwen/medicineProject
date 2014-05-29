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
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/lhgdialog.min.js"></script>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>修改密码</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script type="text/javascript">
	
		$(function(){
			$('#infoSpan').hide();
		})
		
	function checkPassword(){
		var password = $("#oldPassword").val();
		var data = new Object();
		data['user.password'] = password;
		$.ajax({
			type:'POST',
			data:data,
			url:'<%=base%>sys/UserAction!checkIsExist.action',
			success:function(datas){
				if("no"==datas){
					$('#infoSpan').show();
				}
			}
		})
	}
		
	function modifyPasword() {
		if($("#infoSpan").is(":visible")){
			alert("原密码输入不对");
			return;
		}
		var newPassword = $("#newPassword").val();
		var affirmNewPassowrd = $("#affirmNewPassowrd").val();
		alert("new:"+newPassword+" aff:"+affirmNewPassowrd);
		if(affirmNewPassowrd != newPassword){
			alert("两次输入密码不一致");return;
		}
		var data = new Object();
		data['user.password'] = $("#newPassword").val();
		$.ajax({
			type:'POST',
			url:'<%=base%>sys/UserAction!modifyPassword.action',
			data:data,
			success:function(datas){
				alert("操作成功");
			}
		})
	}

</script>
	</head>

	<body class="body1">
		<form name="userForm">
			<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					height="51">
					<tr>
						<td class="p1" height="16" nowrap>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="p1" height="35" nowrap>
							&nbsp&nbsp
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							<b><strong>系统管理&gt;&gt;</strong>修改密码</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<table width="50%" height="91" border="0" cellpadding="0"
					cellspacing="0">
					<tr>
						<td height="30">
							<div align="right">
								<font color="#FF0000">*</font>原密码:
							</div>
						</td>
						<td>
							<input name="oldPassword" type="password" class="text1" onfocus="$('#infoSpan').hide()" onblur="checkPassword()" 
								 id="oldPassword" size="25">
								<span id="infoSpan"><font color="red">*密码不正确</font></span>
						</td>
					</tr>
					<tr>
						<td height="27">
							<div align="right">
								<font color="#FF0000">*</font>新密码:
							</div>
						</td>
						<td>
							<input name="newPassword" type="password" class="text1"
								id="newPassword" size="25">
						</td>
					</tr>
					<tr>
						<td height="34">
							<div align="right">
								<font color="#FF0000">*</font>确认密码:
							</div>
						</td>
						<td>
							<input name="affirmNewPassowrd" type="password" class="text1"
								id="affirmNewPassowrd" size="25">
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				<p>
					<input name="btnModify" class="button1" type="button"
						id="btnModify" value="修改" onClick="modifyPasword()">
					&nbsp; &nbsp;&nbsp;
				</p>
			</div>
		</form>
	</body>
</html>
