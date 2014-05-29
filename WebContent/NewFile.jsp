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
<title>用户管理</title>
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/icon.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>

</head>

<body>  
    <h2>Basic ValidateBox</h2>  
    <div class="demo-info">  
        <div class="demo-tip icon-tip"></div>  
        <div>It's easy to add validate logic to a input box.</div>  
    </div>  
    <div style="margin:10px 0;"></div>  
    <div class="easyui-panel" title="Register" style="width:400px;padding:10px">  
        <table>  
            <tr>  
                <td>User Name:</td>  
                <td><input class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'"></td>  
            </tr>  
            <tr>  
                <td>Email:</td>  
                <td><input class="easyui-validatebox" data-options="required:true,validType:'email'"></td>  
            </tr>  
            <tr>  
                <td>Birthday:</td>  
                <td><input class="easyui-datebox"></td>  
            </tr>  
            <tr>  
                <td>URL:</td>  
                <td><input class="easyui-validatebox" data-options="required:true,validType:'url'"></td>  
            </tr>  
            <tr>  
                <td>Phone:</td>  
                <td><input class="easyui-validatebox" data-options="required:true"></td>  
            </tr>  
        </table>  
    </div>  
  
</body>  
</html>  
