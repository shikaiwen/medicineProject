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
<title>药品销售情况</title>

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">

<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/tinymce/tinymce.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/FusionCharts/FusionCharts.js"></script>
<script type="text/javascript">

var currentClick ;
function appendRow(datas){
//	alert(JSON.stringify(datas));
	$(currentClick).parent().parent().find("td").eq(0).find("input").val(datas[0]['medicineNo']);
	$(currentClick).parent().parent().find("td").eq(1).html(datas[0]['medicineName']);
	$(currentClick).parent().parent().find("td").eq(2).html(datas[0]['normalName']);
}

//打开药品选择窗口
function openMedicineWindow(obj){
	currentClick = obj;
	window.open ('<%=base%>basedata/medicine_info.jsp','newwindow','height=500,width=1300,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 
}

function addRow(){
	var table = $("#header");
	var tr = table.find("#templateTr").clone();
	tr.show();
	tr.appendTo(table);
}
function deleteRow(){
	var table = $("#header");
	table.find("tr:last").remove();
}

//格式化日期
function myformatter(date){
    var y = date.getFullYear();  
    var m = date.getMonth()+1;  
 //   var d = date.getDate();  
    return y+'-'+(m<10?('0'+m):m);//+'-'+(d<10?('0'+d):d); 
}

function getChart(){
	
	var startDate = $("#startDate").datebox("getValue");
	var endDate =  $("#endDate").datebox("getValue");
	
	var queryStr = "";
	queryStr += "startDate="+startDate +"&";
	queryStr += "endDate="+endDate + "&";
	
	var array = new Array();
	$("#header").find("tr:gt(1)").each(function(){
		array.push($(this).find("td").eq(0).find("input").val());
	})
	//alert(JSON.stringify(array))
	for(var v=0;v<array.length;v++){
		queryStr +="medicineNoArray["+v+"]="+array[v]+"&";
	}
	queryStr = queryStr.substr(0,queryStr.length-1);
//	alert(queryStr);
	
	$.ajax({
		url:'<%=base%>report/reportAction!queryMedicineSaleInfo.action',
		data:queryStr,
		success:function(datas){
			//alert(datas);
		      var myChart = new FusionCharts( "<%=base%>jsfiles/FusionCharts/MSColumn3D.swf", 
		    		     "myChartId", "400", "300", "0" );
		    		  //    myChart.setXMLUrl("Data.xml");
		    		myChart.setXMLData(datas);
		    		myChart.render("chartContainer");
		}
	})
}
function deleteChart(){
	//$("#chartContainer").html();
	$("#chartContainer").children().remove();
}


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
		<div id="mainDiv" class="mainDiv">
		
		<div style="text-align:left;">
			统计日期从: <input class="easyui-datebox" id="startDate" data-options="formatter:myformatter" style="width:100px">
			到: <input class="easyui-datebox" id="endDate" data-options="formatter:myformatter" style="width:100px">
			&nbsp;&nbsp;<input type="button" onclick="getChart()" value="查看图表">
		</div>
		<table id="header" class="header">
			<tr>
				<td>药品编号</td>
				<td>药品名称</td>
				<td>通用名称</td>
				<td><input type="button" value="添加一行" onclick="addRow()"/>
					<input type="button" value="删除一行" onclick="deleteRow()"/>
				</td>
			</tr>
			<tr style="display:none" id="templateTr">
				<td><input type="text" ondblclick="openMedicineWindow(this)" readonly="readonly"></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td><input type="text" ondblclick="openMedicineWindow(this)" readonly="readonly"></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<!-- 图表 -->
		<div id="chartContainer" style="float:left;width:800px;height:500px;"> </div>
		
		</div>
	<style>
		.mainDiv{
		width:1000px;
		height:700px;margin-left:auto;
		margin-top:20px;
	/*	background-color:pink;*/
		margin-right:auto;
		text-align:center;
		}
		
		.header{
	/*	border:1px solid black;*/
		width:500px;
		align:center;
		}
	</style>

</body>
</html>
