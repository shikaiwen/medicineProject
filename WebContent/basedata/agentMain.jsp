<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
	<%
	String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
	%>
	<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
</head>

<frameset cols="15%,*">
	<frame src="<%=base%>basedata/agentTree.jsp" name="leftFrame"></frame>
	<frame src="<%=base%>basedata/agentContent.jsp" name="rightFrame"></frame>
</frameset>

<script>

</script>
</html>