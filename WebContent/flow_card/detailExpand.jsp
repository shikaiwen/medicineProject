<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
<style type="text/css">
</style>
</head>
<body>
	<div id="right" style="border:1px solid white;height:150px;width:1000px;float:left">
		<table style="border:1px solid white;" width="100%">
			<tr>
				<td>��ϸ���</td>
				<td>ҩƷ���</td>
				<td>ҩƷ����</td>
				<td>�۸�</td>
				<td>����</td>
				<td>�鿴��ϸ���</td>
			</tr>
			<s:iterator value="flowCardDetailList" var="flowCardDetail">
			<tr>
				<td><s:property value="#flowCardDetail.flowCardDetailId"/></td>
				<td><s:property value="#flowCardDetail.medicine.medicineNo"/></td>
				<td><s:property value="#flowCardDetail.medicine.medicineName"/></td>
				<td><s:property value="#flowCardDetail.price"/></td>
				<td><s:property value="#flowCardDetail.quantity"/></td>
				<td><a href='#' onclick="queryDetail(this)" name="checkUnit">�鿴��ϸ&nbsp;</a></td>
			</tr>
			</s:iterator>
			<tr>
		</table>
		<span id="datastore"></span>
<script type="text/javascript">
var currentClickLabel;
	function queryDetail(obj){
	currentClickLabel = obj; //���յ����a��ǩ���󸳸�ȫ�ֱ�����������Ҫ�õ�
	var flowCardId= $("#datastore").data("row")['flowCardId'];
	var detailId = $(obj).parent().parent().find("td").eq(0).html();
	
		$.ajax({
			type:'POST',
			data:{'flowCardId':flowCardId,'flowCardDetailId':detailId},
			url:'<%=base%>flowCard/FlowCardAction!getMedicineNoList.action',
			success:function(datas){
		//		alert(datas);
				showTable(datas);
			}
		})
	}

	function showTable(datas){
		//alert($("#showDetailDlg").html())
		$("#showDetailDlg").dialog({
	    title: 'ҩƷ����',  
		width: 850,  
		height: 350,  
		closed: false,  
		draggable:true,
		resizable:true,
		cache: false,  
		modal: true
	})
		$("#showDetailDlg").show();
		var table = $("#detailTable");
		table.find("tr:gt(0)").remove();
		
		var medicine_no = $(currentClickLabel).parent().parent().find("td").eq(1).html();
		var medicine_name = $(currentClickLabel).parent().parent().find("td").eq(2).html();
		table.find("tr").eq(0).find("td").eq(1).html(medicine_no);//����ͷ��ҩƷ�������
		table.find("tr").eq(0).find("td").eq(3).html(medicine_name);
		var array = datas.split(",");
		
		for(var v=0;v<array.length;v++){
			if(v%4==0){
				var tr = $("<tr></tr>");
				tr.appendTo(table);
			}
			$("<td></td>").html(array[v]).appendTo(tr);
		}
		$("#showDetailDlg").show();
	}
</script>
</div>
</body>
</html>