<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="GBK"%>
    <%@ page  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
//out.write(basePath);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ҩƷ����</title>

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">

<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/tinymce/tinymce.min.js"></script>
<script type="text/javascript">


function test(){
	window.open ('http://www.baidu.com','newwindow','height=300,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 
}


function addUser(){
	
show();
}

function save(){
	
//	alert(JSON.stringify($.messager));
	$.messager['defaults']['ok']='ȷ��';
	$.messager.alert("��ʾ��Ϣ","����ɹ�",'info');
}


function show (){
	$("#dlg").dialog({
    title: 'My Dialog',  
	width: 900,  
	height: 450,  
	closed: false,  
	cache: false,  
//	href: 'add.html',  
	modal: true
})
}


//���ҩƷ����
$(function(){
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=C',
		success:function(datas){
			$("#category").html(datas);
		}
	})
})

$(function(){
	 tinymce.init({selector:'textarea',language:'zh_CN'});
})
</script>
</head>
<body class="body1">
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>&nbsp;
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="<%=base%>/images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>�������ݹ���&gt;&gt;ҩƷ���</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				</div>
				

	<table id="medicines" style="width:800px" height="900px" toolbar="#conditions"></table>
	

	<!-- �Ի��� -->
	<div id="dlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#dlg-buttons">
		<table id="addMedicineTable">
			<tr><td>ҩƷ���:</td><td><input type="text" size="15" name="medicine_id" id="medicine_id" disabled="disabled"/></td>
				<td>ҩƷ����:</td><td><input type="text" size="15" name="medicine_name" id="medicine_name"/></td>
			</tr>
			<tr>
				<td>��׼�ĺ�:</td><td><input type="text" size="15" name="approvalNumber" id="approvalNumber"/></td>
				<td>���:</td><td><input type="text" size="15" name="specification" id="specification"/></td>
			</tr>
			<tr>
				<td>��Ʒ��ǩ:</td><td><input type="text" size="15" name="unit" id="unit"/></td>
				<td>������λ:</td><td><input type="text" size="15" name="unit" id="unit"/></td>
				</tr>
			<tr>
				<td>�÷�������:</td><td><input type="text" size="15" name="usageDosage" id="usageDosage"/></td>
				<td>�ɷ�:</td><td><input type="text" size="15" name="ingredient" id="ingredient"/></td>
			</tr>
			<tr>
				<td>���ܷ���:</td><td><input type="text" size="15" name="functionType" id="functionType"/></td>
				<td>�������:</td><td><input type="text" size="15" name="manageType" id="manageType"/></td>
			</tr>
			<tr>
				<td>�Ƿ�ʹ������۸�:</td><td><select name=""></select></td>
				<td>�۸�:</td><td><input type="text" size="15" name="price" id="price"/></td>
			</tr>
			<tr><td>������:</td><td><input type="text" size="15" name="manufacturer" id="manufacturer"/></td></tr>
			<tr><td>ͼƬ:</td><td><input type="file" size="15" name="img" id="img"/></td></tr>
			
		</table>
		<div>
			����:<textarea></textarea>
		</div>
	</div>
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">����</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">ȡ��</a>  
    </div>  
</body>
</html>
