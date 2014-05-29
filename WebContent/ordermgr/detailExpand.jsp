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
				<td>��ϸ���:</td>
				<td>ҩƷ���:</td>
				<td>ҩƷ����:</td>
				<td>�۸�:</td>
				<td>����:</td>
				<td>�����(<a href="#" onclick="checkAll(this)">ȫ�����</a>)</td>
			</tr>
			<s:iterator value="detailList" var="detailOrder">
			<tr>
				<td><s:property value="#detailOrder.detailId"/></td>
				<td><s:property value="#detailOrder.medicine.medicineNo"/></td>
				<td><s:property value="#detailOrder.medicine.medicineName"/></td>
				<td><s:property value="#detailOrder.price"/></td>
				<td><s:property value="#detailOrder.quantity"/></td>
				<td><a href='#' onclick="checkStore(this)" name="checkUnit">���&nbsp;</a></td>
			</tr>
			</s:iterator>
			<tr>
		</table>
		<font color="red" id="alert"></font>
<script type="text/javascript">

	function checkAll(obj){
	//	alert("obj");
	//	alert($(obj).parent().parent().parent().find("a[name='checkUnit']").length)
		$(obj).parent().parent().parent().find("a[name='checkUnit']").each(function(){
		//	alert(0);alert($(this).html())
			$(this).trigger("click",function(tt){
				alert("to invoke");	//����û�е��ã�Ӧ���������ǩ�϶�����click���Ͳ������
									//����Ļص���
				//checkStore(tt);
			})
		})
	}

	function checkStore(obj){
		//alert(1);
		var medicineNo = $(obj).parent().parent().find("td").eq(1).html();
		var quantity = $(obj).parent().parent().find("td").eq(4).html();
	//	alert(medicineNo+"   "+quantity);
		var data= new Object();
		data['storeCardDetail.medicine.medicineNo'] = medicineNo;
		data['quantity'] = quantity;
		var v =2;
		$.ajax({
			type:'POST',
			url:'<%=base%>store/StoreAction!checkStoreByMedicineNo.action',
			data:data,
			success:function(datas){
				var d = $.parseJSON(datas);
				var status = d['resultList'][0];//alert(JSON.stringify(status))
				var message = d['resultList'][1]['message'];//alert(JSON.stringify(message))
				if(status['status']=='error'){
					$("#alert").clone().html(message).appendTo($(obj).parent());
				}else{
					$("<span></span>").html(message).appendTo($(obj).parent());
				}
			}
		})
	}
</script>
</body>
</html>