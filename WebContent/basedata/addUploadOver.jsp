<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<%@taglib uri="/struts-tags"  prefix="s"%>
<%@ page language="java"   import="com.drp.domain.Medicine"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<script type="text/javascript">
	
	window.onload = function (){
		window.parent.addUploadOver('<s:property value="medicine.img"/>');
	}

	</script>
	
</head>
<body>

	
</body>
</html>