<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<script type="text/javascript">
	window.onload = function (){
		window.parent.modifyUploadOver('<s:property value="medicine.img"/>');
	}

	</script>
</head>
<body>

	
</body>
</html>