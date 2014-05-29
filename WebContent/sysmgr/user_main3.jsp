<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
//out.write(basePath);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>用户管理</title>
<link rel="stylesheet" href="<%=basePath%>cssfiles/drp.css">

<link rel="stylesheet" type="text/css" href="<%=basePath%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>cssfiles/easyui.css">
<script type="text/javascript" src="<%=basePath%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>jsfiles/lhgdialog.min.js"></script>
<script type="text/javascript">
 jQuery.dialog(
{
	width:300,
	height:200,
	lock:true
	}		 
 )
</script>
<body>

</body>
</html>
