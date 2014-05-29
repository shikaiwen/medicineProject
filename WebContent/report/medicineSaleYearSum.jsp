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
<title>药品销售年度统计情况</title>

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">

<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/tinymce/tinymce.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/FusionCharts/FusionCharts.js"></script>
<script type="text/javascript">


//格式化日期
function myformatter(date){
    var y = date.getFullYear();  
    var m = date.getMonth()+1;  
 //   var d = date.getDate();  
    return y;//+'-'+(d<10?('0'+d):d); 
}

function getChart(){
	var sumYear = $("#sumYear").datebox("getValue");
	$.ajax({
		type:'POST',
		data:{"sumYear":sumYear},
		url:'<%=base%>report/reportAction!generateReport.action',
		success:function(datas){
			//alert(datas);
			var src = $("#pathSpan").html();
			src = src + datas;
			$("#reportWindowFrame").attr("src",src);
			$("#reportWindowFrame").show();
		}
	})
}
function deleteChart(){
	$("#chartContainer").children().remove();
}

$(function(){
	$("#reportWindowFrame").hide();
})


</script>
</head>
<body class="body1">
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="22" nowrap>&nbsp;
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="<%=base%>/images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>报表管理&gt;&gt;药品销售情况查询</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
		
		<div style="text-align:left;">
			统计年份: <input class="easyui-datebox" id="sumYear" data-options="formatter:myformatter" style="width:100px">
		</div>
<input type="button" onclick="getChart()" value="查看">
<span id="pathSpan" style="display:none"><%=base%></span>
<iframe id="reportWindowFrame" src="<%=base%>" width="100%" scrolling="no" height="500px" frameborder="0"></iframe>
</body>
</html>
