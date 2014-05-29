<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
out.write(basePath);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="<%=basePath%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>jsfiles/lhgdialog.min.js"></script>
<script type="text/javascript">

	$(function(){

		$("#button1").click(function(){
			jQuery.dialog({
				title:'i am title',
				content:'url:http:www.baidu.com',
				lock:true,
				drag:false
			});
		});
	})
</script>
<input type="button" id="button1" value="click me"/>


</body>
</html>