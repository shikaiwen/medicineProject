<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
<style type="text/css">
</style>
</head>
<body>
	<div class="content" style="border:1px solid white;height:130px">
	
	<div id="left" style="border:1px solid white;height:150px;width:105px;float:left;">
	<img alt="图片" src="<%=base%>uploadFiles/" id="medicinePic" style="width:100px;height:120px">
	</div>
	
	<div id="right" style="border:1px solid white;height:150px;width:1000px;float:left">
		<table style="float:left;padding:3px;border:1px solid white;" height="130px" width="500px">
			<tr>
				<td>产品标签:</td><td><span id="productLabelSpan"></span></td>
				<td>用法与用量:</td><td><span id="usageDosageSpan"></span></td>
			</tr>
			<tr>
				<td>单位:</td><td><span id="unitSpan"></span></td>
				<td>规格:</td><td><span id="specificationSpan"></span></td>
			</tr>
			<tr>
				<td>成分</td><td><span id="ingredientsSpan"></span></td>
				<td>使用固定价格:</td><td><span id="useSpecialPriceSpan"></span></td>
			</tr>
			<tr>
			<td>管理类型:</td><td><span id="manageTypeSpan"></span></td><td></td>
			<td></td>
			</tr>
		</table>
		<div id="" style="float:left">
		描述:<span id="descriptionsSpan"></span>
		</div>
	</div>
	
	</div>	
</body>
</html>