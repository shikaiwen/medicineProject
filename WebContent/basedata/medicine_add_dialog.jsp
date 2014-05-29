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
<title>药品管理</title>

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
	$.messager['defaults']['ok']='确定';
	$.messager.alert("提示信息","保存成功",'info');
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


//添加药品分类
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
							<b>基础数据管理&gt;&gt;药品添加</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				</div>
				

	<table id="medicines" style="width:800px" height="900px" toolbar="#conditions"></table>
	

	<!-- 对话框 -->
	<div id="dlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#dlg-buttons">
		<table id="addMedicineTable">
			<tr><td>药品编号:</td><td><input type="text" size="15" name="medicine_id" id="medicine_id" disabled="disabled"/></td>
				<td>药品名称:</td><td><input type="text" size="15" name="medicine_name" id="medicine_name"/></td>
			</tr>
			<tr>
				<td>批准文号:</td><td><input type="text" size="15" name="approvalNumber" id="approvalNumber"/></td>
				<td>规格:</td><td><input type="text" size="15" name="specification" id="specification"/></td>
			</tr>
			<tr>
				<td>产品标签:</td><td><input type="text" size="15" name="unit" id="unit"/></td>
				<td>计量单位:</td><td><input type="text" size="15" name="unit" id="unit"/></td>
				</tr>
			<tr>
				<td>用法与用量:</td><td><input type="text" size="15" name="usageDosage" id="usageDosage"/></td>
				<td>成分:</td><td><input type="text" size="15" name="ingredient" id="ingredient"/></td>
			</tr>
			<tr>
				<td>功能分类:</td><td><input type="text" size="15" name="functionType" id="functionType"/></td>
				<td>管理分类:</td><td><input type="text" size="15" name="manageType" id="manageType"/></td>
			</tr>
			<tr>
				<td>是否使用特殊价格:</td><td><select name=""></select></td>
				<td>价格:</td><td><input type="text" size="15" name="price" id="price"/></td>
			</tr>
			<tr><td>制造商:</td><td><input type="text" size="15" name="manufacturer" id="manufacturer"/></td></tr>
			<tr><td>图片:</td><td><input type="file" size="15" name="img" id="img"/></td></tr>
			
		</table>
		<div>
			描述:<textarea></textarea>
		</div>
	</div>
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>  
    </div>  
</body>
</html>
