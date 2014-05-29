<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<%@ taglib uri="/struts-tags"  prefix="s"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>Internet Dreams</title>
<link rel="stylesheet" href="<%=base%>cssfiles/screen.css" type="text/css" media="screen" title="default" />
<!--  jquery core -->
<script src="<%=base%>jsfiles/jquery-1.8.0.min.js" type="text/javascript"></script>

<!-- Custom jquery scripts -->
<script src="<%=base%>jsfiles/custom_jquery.js" type="text/javascript"></script>

<!-- MUST BE THE LAST SCRIPT IN <HEAD></HEAD></HEAD> png fix -->
<script src="jsfiles/jquery.pngFix.pack.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
$(document).pngFix( );
});

function toSubmit(){
	var form = document.getElementById("myform");
	if($("#userId").val()==''||$("#password").val()==''){
		alert("请输入完成信息");return;
	}
	form.submit();
	
}
	
</script>
</head>
<body id="login-bg"> 
 
<!-- Start: login-holder -->
<div id="login-holder">

	<!-- start logo -->
	<div id="logo-login">
		<a href="index.html"><img src="<%=base%>images/logo.png" width="260" height="60" alt="" /></a>
	</div>
	<!-- end logo -->
	
	<div class="clear"></div>
	
	<!--  start loginbox ................................................................................. -->
	<div id="loginbox">
	
	<!--  start login-inner -->
	<div id="login-inner">
	<form id="myform" action="<%=base%>sys/login.action" method="post">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th>用户名:</th>
			<td><input type="text" name="user.userId"  id="userId" class="login-inp" /></td>
		</tr>
		<tr>
			<th>密码:</th>
			<td><input type="password" name="user.password" id="password" value=""  onfocus="this.value=''" class="login-inp" /></td>
		</tr>
		<tr>
			<th></th>
		<!--	<td valign="top"><input type="checkbox" class="checkbox-size" id="login-check" /><label for="login-check">Remember me</label></td>-->
		</tr>
		<tr>
			<th></th>
			<td><input type="button" class="submit-login" onclick="toSubmit()"/><br><span><font color="red" size="5"><s:actionerror/></font></span></td>
	</form>	
		</tr>
		</table>
	</div>
 	<!--  end login-inner -->
	<div class="clear"></div>
	<!--<a href="" class="forgot-pwd">Forgot Password?</a>-->
 </div>
 <!--  end loginbox -->
 
	<!--  start forgotbox ................................................................................... -->
	<div id="forgotbox">
		<div id="forgotbox-text">Please send us your email and we'll reset your password.</div>
		<!--  start forgot-inner -->
		<div id="forgot-inner">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th>Email address:</th>
			<td><input type="text" value=""   class="login-inp" /></td>
		</tr>
		<tr>
			<th> </th>
			<td><input type="button" class="submit-login"  /></td>
		</tr>
		</table>
		</div>
		<!--  end forgot-inner -->
		<div class="clear"></div>
		<a href="" class="back-login">Back to login</a>
	</div>
	<!--  end forgotbox -->

</div>
<!-- End: login-holder --><%System.out.println("成功转向login.jsp"); %>
</body>
</html>