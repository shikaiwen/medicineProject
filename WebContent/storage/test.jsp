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
	<img alt="ͼƬ" src="<%=base%>uploadFiles/" id="medicinePic" style="width:100px;height:120px">
	</div>
	
	<div id="right" style="border:1px solid white;height:150px;width:1000px;float:left">
		<table style="float:left;padding:3px;border:1px solid white;" height="130px" width="500px">
			<tr>
				<td>��Ʒ��ǩ:</td><td><span id="productLabelSpan"></span></td>
				<td>�÷�������:</td><td><span id="usageDosageSpan"></span></td>
			</tr>
			<tr>
				<td>��λ:</td><td><span id="unitSpan"></span></td>
				<td>���:</td><td><span id="specificationSpan"></span></td>
			</tr>
			<tr>
				<td>�ɷ�</td><td><span id="ingredientsSpan"></span></td>
				<td>ʹ�ù̶��۸�:</td><td><span id="useSpecialPriceSpan"></span></td>
			</tr>
			<tr>
			<td>��������:</td><td><span id="manageTypeSpan"></span></td><td></td>
			<td></td>
			</tr>
		</table>
		<div id="" style="float:left">
		����:<span id="descriptionsSpan"></span>
		</div>
	</div>
	
	</div>	
</body>
</html>