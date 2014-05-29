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
<title>药品管理</title>
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/icon.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/tinymce/tinymce.min.js"></script>
<script type="text/javascript">

var dd ;
$(function(){
	dd = $('#medicines').datagrid({
		title:'药品列表',
		view:detailview,
		detailFormatter:function(index,row){
		//	alert("adf");
				//alert(row['functionType']['dictName']);
			return '<div id="ddv-' + index+ '" style="padding:5px 0"></div>';
		},
		onExpandRow:function(index,row){
			var rowData =  $('#medicines').datagrid('getSelected',index);
			$('#ddv-'+index).panel({
				border:false,
				cache:false,
				href:'test.jsp',
				onLoad:function(){
				var div = $("#ddv-"+index);
				//为空间赋值
				div.find("#ingredientsSpan").html(row['ingredients']);
				div.find("#productLabelSpan").html(row['productLabel']);
				div.find("#usageDosageSpan").html(row['usageDosage']);
				div.find("#unitSpan").html(row['unit']['dictName']);
				div.find("#specificationSpan").html(row['specification']);
				div.find("#ingredientsSpan").html(row['ingredients']);
				div.find("#useSpecialPriceSpan").html(row['useSpecialPrice']['dictName']);
				div.find("#manageTypeSpan").html(row['manageType']['dictName']);
				div.find("#descriptionsSpan").html(row['descriptions']);
				
				var v = div.find("#medicinePic").attr("src");
				v = v + row['img'];
			//	alert("img:"+row['img']);
				div.find("#medicinePic").attr("src",v);
				$('#medicines').datagrid('fixDetailRowHeight',index);
				}
			});
			$('#medicines').datagrid('fixDetailRowHeight',index);
		},
		iconCls:'icon-save',
		pageSize:10,
		resizable:true,
		width:'85%',
		height:'500',
		singleSelect:false,
		selectOnCheck:true,
		resizable:true,
		nowrap: true,
		autoRowHeight: false,
		striped: true,
		collapsible:true,
		url:'<%=base%>basedata/MedicineAction!getResultByPage.action',
		sortName: 'code',
		sortOrder: 'desc',
		remoteSort: false,
		idField:'medicineNo',
		loadMsg:'数据加载中...',
		frozenColumns:[[
            {field:'ck',checkbox:true}
           //{title:'Code',field:'code',width:80,sortable:true} 
		]],
		columns:[
		[
			{field:'medicineNo',title:'药品编号',width:120,height:30},
			{field:'medicineName',title:'药品名称',width:150,rowspan:2,height:30,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
			{field:'normalName',title:'通用名称',width:150,height:30,rowspan:2},
			{field:'price',title:'价格',width:220,height:30,rowspan:2},
			{field:"functionType.dictName",title:'功能类型',width:220,height:30,rowspan:2,formatter:function(v,r,i){
				return formatColumn('functionType.dictName',v,r,i);//alert("param3"+param3+"param1 is :"+param1+"  param2 is "+JSON.stringify(param2));
			}
			},
			{field:'approvalNumber',title:'批准文号',width:120,rowspan:2,height:30},
			{field:'manufacturer',title:'生产企业',width:220,rowspan:2,height:30},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'添加',
			iconCls:'icon-add',
			handler:showAddMedicineDialog
			
		},{
			id:'btnedit',
			text:'修改',
			iconCls:'icon-edit',
			handler:showModifyMedicineDialog//function(){
			//	$('#btnsave').linkbutton('enable');
			//	alert('cut')
			//}
		},{
			id:'btnremove',
			text:'删除',
			iconCls:'icon-remove',
			handler:deleteMedicine		
		}]
	});
	
	var p = $('#medicines').datagrid('getPager');
	$(p).pagination({
		pageSize:10,
		pageList:[5,10,22,20],
		beforePageText:'第',
		afterPageText:'页     共{pages}页',
		displayMsg:'当前显示 {from} - {to} 条记录',
		onBeforeRefresh:function(){
			alert('before refresh');
		}
	});
	
});


//处理嵌套对象
function formatColumn(colName, value, row, index) {
	    return eval("row."+colName);
}


function test(){
	window.open ('medicine_add_dialog.jsp','newwindow','height=300,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 
}


//显示添加
function showAddMedicineDialog(){

	$("#addMedicineTable").css("margin-left","auto");
	$("#addMedicineTable").css("margin-right","auto");
	$("#addMedicineTable").css("margin-top","20px");
	$("#addDlg").dialog({
	    title: '添加药品',  
		width: 1100,  
		height: 400,  
		closed: false,  
		draggable:true,
		resizable:true,
		cache: false,  
		modal: true
	})

	
}




//添加药品
function addMedicine(){
	var data = new Object();
	var table = $("#addMedicineTable");
	data['medicine.medicineNo'] = table.find("#medicineNo").val();
	data['medicine.normalName'] = table.find("#normalName").val();
	data['medicine.medicineName'] = table.find("#medicineName").val();
	data['medicine.approvalNumber'] = table.find("#approvalNumber").val();
	data['medicine.specification'] = table.find("#specification").val();
	data['medicine.productLabel'] = table.find("#productLabel").val();
	data['medicine.unit.dictId'] = table.find("#unit").val();
	data['medicine.usageDosage'] = table.find("#usageDosage").val();
	data['medicine.ingredients'] = table.find("#ingredients").val();
	data['medicine.functionType.dictId'] = table.find("#functionType").val();
	data['medicine.manageType.dictId'] = table.find("#manageType").val();
	data['medicine.useSpecialPrice.dictId'] = table.find("#useSpecialPrice").val();
	data['medicine.price'] = table.find("#price").val();
	data['medicine.manufacturer'] = table.find("#manufacturer").val();
	var src = $("#addImg").attr("src");
	var imgName = src.substr(src.lastIndexOf("/")+1);
	data['medicine.img'] = imgName;
	data['medicine.descriptions'] = tinymce.editors[0].getContent();
	$.ajax({
		type:'POST',
		url:'<%=base%>basedata/MedicineAction!addMedicine.action',
		data:data,
		success:function(datas){
			alert('操作成功');	
			alert(datas);
			var obj = $.parseJSON(datas);
			table.find("#medicineNo").val(obj['medicineNo']);
		}
	})
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
	height: 440,  
	closed: false,  
	cache: false,  
//	href: 'add.html',  
	modal: true
})
}

//添加条件
$(function(){
	$(".datagrid-toolbar").append($("#tb"));
})

//添加药品功能分类
$(function(){
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=G',
		success:function(datas){
		//	alert(datas);
			$("#functionType").html(datas);
			$("#addMedicineTable #functionType").html(datas);
			$("#modifyMedicineTable #functionType").html(datas);
		}
	});
	//添加管理分类
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=D',
		success:function(datas){
			$("#manageType").html(datas);
			$("#addMedicineTable #manageType").html(datas);
			$("#modifyMedicineTable #manageType").html(datas);
		}
	})
	
	//添加计量单位
		$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=I',
		success:function(datas){
		//	$("#manageType").html(datas);
			$("#addMedicineTable #unit").html(datas);
			$("#modifyMedicineTable #unit").html(datas);
		}
	})
})



//是否字典
$(function(){
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=F',
		success:function(datas){
			$("#useSpecialPrice").html(datas);
			$("#modifyMedicineTable #useSpecialPrice").html(datas);
		}
	})
	
})


//编辑器 
$(function(){
	 tinymce.init({selector:'textarea',language:'zh_CN'});
	 $("#hidden_frame").hide();
})


//显示修改框
function showModifyMedicineDialog(){
	var div = $("#modifyDlg");
	div.find("#hidden_frame").hide();
	var datas = $("#medicines").datagrid("getSelections");
	if(datas.length != 1){
		alert("请选择一条数据");
		return;
	}

	$("#modifyMedicineTable").css("margin-left","auto");
	$("#modifyMedicineTable").css("margin-right","auto");
	$("#modifyMedicineTable").css("margin-top","20px");
	$("#modifyDlg").dialog({
	    title: '修改药品',  
		width: 1100,  
		height: 400,  
		closed: false,  
		draggable:true,
		resizable:true,
		cache: false,  
		modal: true
	})
	//为表格赋值
	var table = $("#modifyMedicineTable");
//	table.find("#userId").val("123");
	for(var key in datas[0]){
		table.find("#"+key).val(datas[0][key]);
	}
	//为字典赋值
	table.find("#functionType").val(datas[0]['functionType']['dictId']);
	table.find("#manageType").val(datas[0]['manageType']['dictId']);
	table.find("#unit").val(datas[0]['unit']['dictId']);
	table.find("#useSpecialPrice").val(datas[0]['useSpecialPrice']['dictId']);
	//table.find("#descriptions2").html(datas[0]['descriptions']);
	if(!datas[0]['descriptions']){
		tinymce.editors[1].setContent('');
	}else{
		tinymce.editors[1].setContent(datas[0]['descriptions']);
	}
	
	
	//处理图片
	var src = $("#mImg").attr("src");
	src = src.substr(0,src.lastIndexOf("/")+1);
	var img = datas[0]['img'];
	$("#mImg").attr("src",src+img);
	if(datas[0]['img']=='no-images.jpg'){
		$("#hiddenModifyUpload").show();$("#hidden_frame2").hide();//显示上传按钮
		//$("#deleteImgSpan").hide();	//隐藏删除图片
		var div = $("#modifyDlg").find("#deleteImgSpan").hide();
	}
}

//修改药品
function modifyMedicine(){
	var data = new Object();
	var table = $("#modifyMedicineTable");
	data['medicine.medicineNo'] = table.find("#medicineNo").val();
	data['medicine.normalName'] = table.find("#normalName").val();
	data['medicine.medicineName'] = table.find("#medicineName").val();
	data['medicine.approvalNumber'] = table.find("#approvalNumber").val();
	data['medicine.specification'] = table.find("#specification").val();
	data['medicine.productLabel'] = table.find("#productLabel").val();
	data['medicine.unit.dictId'] = table.find("#unit").val();
	data['medicine.usageDosage'] = table.find("#usageDosage").val();
	data['medicine.ingredients'] = table.find("#ingredients").val();
	data['medicine.functionType.dictId'] = table.find("#functionType").val();
	data['medicine.manageType.dictId'] = table.find("#manageType").val();
	data['medicine.useSpecialPrice.dictId'] = table.find("#useSpecialPrice").val();
	data['medicine.price'] = table.find("#price").val();
	data['medicine.manufacturer'] = table.find("#manufacturer").val();
	var src = $("#mImg").attr("src");
	var imgName = src.substr(src.lastIndexOf("/")+1);
	data['medicine.img'] = imgName;
	data['medicine.descriptions'] = tinymce.editors[1].getContent();
	$.ajax({
		type:'POST',
		url:'<%=base%>basedata/MedicineAction!modifyMedicine.action',
		data:data,
		success:function(datas){
			alert('操作成功');	
			alert(datas);
			var obj = $.parseJSON(datas);
			table.find("#medicineNo").val(obj['medicineNo']);
		}
	})
}

//删除图片
function deletePic(){
	$.messager.defaults={ok:'确定',cancel:'取消'};
	$.messager.confirm('确认框','确定要删除吗?',function(result){ 
		if(result){
			var data = new Object();
			var medicineNo = $("#modifyMedicineTable").find("#medicineNo").val();
			data['medicine.medicineNo'] = medicineNo;
			var src = $("#mImg").attr("src");
			data['medicine.img'] = src.substr(src.lastIndexOf("/")+1);
			$.ajax({
				type:'POST',
				url:'<%=base%>basedata/MedicineAction!deletePic.action',
				data:data,
				success:function(datas){
					//处理图片
					var src = $("#mImg").attr("src");
					src = src.substr(0,src.lastIndexOf("/")+1);
					var img = 'no-images.jpg';
					$("#mImg").attr("src",src+img);
					//隐藏
					$("#deleteImgSpan").hide();
					$("#hiddenModifyUpload").show();//显示上传按钮
				}
			})
		}
	});
}

//修改时上传文件
function toSubmit(){
	
}

//删除药品
function deleteMedicine(){
	
	var datas = $("#medicines").datagrid("getSelections");
	var str = "";
	for(var v=0;v<datas.length;v++){
		str += 'medicineList.medicineNo='+datas[v].medicineNo+'&';
	}
	str = str.substr(0,str.length-1);
	alert(str);
	$.ajax({
		type:'POST',
		url:'<%=base%>basedata/MedicineAction!deleteMedicine.action',
		data:str,
		success:function(datas){
			alert("删除成功!");
			str = ""; //这里如果不重置，多次删除会叠加，具体原因带研究
			$('#medicines').datagrid('reload');  
		}
	})
}

//根据条件查询
function toQuery(){

//	var url = dd.datagrid("options").url;
//	url += "?medicine.medicineNo="+123;
	
	var toolBar = $("#tb");
	var data = new Object();
	data['medicine.medicineNo'] = toolBar.find("#medicineNo").val();
	data['medicine.medicineName'] = toolBar.find("#medicineName").val();
	data['medicine.normalName'] = toolBar.find("#normalName").val();
	data['medicine.functionType.dictId'] = toolBar.find("#functionType").val();
	data['medicine.manageType.dictId'] = toolBar.find("#manageType").val();
	
	dd.datagrid("options").queryParams = data;
//	dd.datagrid("options").url = url;
	dd.datagrid('reload'); 
}

//重置条件
function resetCondition(){
	alert("reset conditions");
	alert(JSON.stringify(dd.datagrid("options").queryParams));
	dd.datagrid("options").queryParams = {};
	alert(JSON.stringify(dd.datagrid("options").queryParams));
	var toolBar = $("#tb");
	toolBar.find("#medicineNo").val('');
	toolBar.find("#medicineName").val('');
	toolBar.find("#normalName").val('');
	toolBar.find("#functionType").val('0');
	toolBar.find("#manageType").val('0');
}
</script>
</head>
<body class="body1">

				
	<table id="medicines"   style="width:500px;height:450px">
	</table>
	
	<!-- toolbar -->
	<div id="tb" style="padding:5px;height:auto">
		<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 药品编号:<input type="text" name="medicine.medicineName" id="medicineNo" size="9">
		 	药品名称:<input type="text" name="medicine.medicineName" id="medicineName" size="9">
			药品功能类别: 
			<select name="functionType" id="functionType" ></select>
			药品管理类型:
			<select name="manageType" id="manageType"></select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="toQuery()">查询</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="resetCondition()">重置</a>
			<br><br>
		</div>
	</div>
	
	<!-- 对话框 -->
	<div id="addDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#dlg-buttons">
		<table id="addMedicineTable">
			<tr><td>药品编号:</td><td><input type="text" size="22" name="medicineNo" id="medicineNo" disabled="disabled"/></td>
				<td>药品名称:</td><td><input type="text" size="22" name="medicineName" id="medicineName" class="easyui-validatebox" data-options="required:true" missingMessage="药品名称不能为空" /></td>
			</tr>
			<tr>
				<td>通用名称:</td><td><input type="text" size="22" name="normalName" class="easyui-validatebox" data-options="required:true" missingMessage="通用名称不能为空" id="normalName"/></td>
				<td>批准文号:</td><td><input type="text" size="22" name="approvalNumber" class="easyui-validatebox" data-options="required:true" missingMessage="批准文号不能为空" id="approvalNumber"/></td>
			</tr>
			<tr>
				<td>产品标签:</td><td><input type="text" size="22" name="productLabel" class="easyui-validatebox" data-options="required:true" missingMessage="产品标签不能为空" id="productLabel"/></td>
				<td>规格:</td><td><input type="text" size="22" name="specification" class="easyui-validatebox" data-options="required:true" missingMessage="规格不能为空" id="specification"/></td>
			</tr>
			<tr>
				<td>用法与用量:</td><td><input type="text" size="22"  name="usageDosage" id="usageDosage"/></td>
				<td>成分:</td><td><input type="text" size="22" name="ingredients" id="ingredients"/></td>
			</tr>
			<tr>
				<td>功能分类:</td><td><select name="functionType" id="functionType"></select></td>
				<td>管理分类:</td><td><select name="manageType" id="manageType"></select></td>
			</tr>
			<tr>
				<td>是否使用固定价格:</td><td><select name="useSpecialPrice" id="useSpecialPrice"></select></td>
				<td>计量单位:</td><td><select name="unit" id="unit"></select></td>
			</tr>
			<tr>
			<td>价格:</td><td><input type="text" size="22" name="price" class="easyui-validatebox" data-options="required:true" missingMessage="价格为必填" id="price"/></td>
			<td>生产企业:</td><td><input type="text" size="22" class="easyui-validatebox" data-options="required:true" missingMessage="生产企业不能为空" name="manufacturer" id="manufacturer"/></td>
			</tr>
			<tr><td>图片:
			</td>
			<td>
			<div style="display:none" id="addShowImgDiv"><img id="addImg" src="<%=base%>uploadFiles/" style="width:120px;height:100px;"/>
			<span id="deleteImgSpan"><input type="button" value="删除图片" onclick="deleteInAddPic()"/></span>
			</div>
			<div id="addImgForm">
				<form action="<%=base%>basedata/MedicineAction!uploadImg.action" target="hidden_frame" encType="multipart/form-data" method="post">
					<input type="file" name="imgFile" id="aImgFile">
					<input type="submit" value="上传文件">
					<iframe id="hidden_frame"  name="hidden_frame"></iframe>
				</form>
			</div>
			</td></tr>
		</table>
		<div>
			描述:<textarea name="descriptions" id="descriptions"></textarea>
		</div>
	</div>
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="addMedicine()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#addDlg').dialog('close')">取消</a>  
    </div>  
    
    
    <!-- 修改对话框 -->
    	<!-- 对话框 -->
	<div id="modifyDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#mdlg-buttons">
		<table id="modifyMedicineTable">
			<tr><td>药品编号:</td><td><input type="text" size="22" name="medicineNo" id="medicineNo" disabled="disabled"/></td>
				<td>药品名称:</td><td><input type="text" size="22" name="medicineName" id="medicineName" class="easyui-validatebox" data-options="required:true" missingMessage="药品名称不能为空" /></td>
			</tr>
			<tr>
				<td>通用名称:</td><td><input type="text" size="22" name="normalName" class="easyui-validatebox" data-options="required:true" missingMessage="通用名称不能为空" id="normalName"/></td>
				<td>批准文号:</td><td><input type="text" size="22" name="approvalNumber" class="easyui-validatebox" data-options="required:true" missingMessage="批准文号不能为空" id="approvalNumber"/></td>
			</tr>
			<tr>
				<td>产品标签:</td><td><input type="text" size="22" name="productLabel" class="easyui-validatebox" data-options="required:true" missingMessage="产品标签不能为空" id="productLabel"/></td>
				<td>规格:</td><td><input type="text" size="22" name="specification" class="easyui-validatebox" data-options="required:true" missingMessage="规格不能为空" id="specification"/></td>
			</tr>
			<tr>
				<td>用法与用量:</td><td><input type="text" size="22" name="usageDosage" id="usageDosage"/></td>
				<td>成分:</td><td><input type="text" size="22" name="ingredients" id="ingredients"/></td>
			</tr>
			<tr>
				<td>功能分类:</td><td><select name="functionType" id="functionType"></select></td>
				<td>管理分类:</td><td><select name="manageType" id="manageType"></select></td>
			</tr>
			<tr>
				<td>是否使用固定价格:</td><td><select name="useSpecialPrice" id="useSpecialPrice"></select></td>
				<td>计量单位:</td><td><select name="unit" id="unit"></select></td>
			</tr>
			<tr>
			<td>价格:</td><td><input type="text" size="22" name="price" id="price"/></td>
			<td>制造商:</td><td><input type="text" size="22" name="manufacturer" id="manufacturer"/></td>
			</tr>
			<tr><td>图片:</td>
			<td>
			<div id="imgSpanDiv">
			<img id="mImg" src="<%=base%>uploadFiles/" style="width:120px;height:100px;"/>
			<span id="deleteImgSpan"><input type="button" value="删除图片" onclick="deleteInModifyPic()"/></span>
			</div>
			<div id="hiddenModifyUpload" style="display:none">
				<form id="modifyFileForm" action="<%=base%>basedata/MedicineAction!modifyUploadImg.action" target="hidden_frame2" encType="multipart/form-data" method="post">
					<input type="file" name="imgFile">
					<input type="submit"  value="上传文件">
					<iframe id="hidden_frame2"  name="hidden_frame2"></iframe>
				</form>
			</div>
			</td>
			</tr>
		</table>
		<div>
			描述:<textarea name="descriptions2" id="descriptions2"></textarea>
		</div>
	</div>
	 <div id="mdlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modifyMedicine()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#modifyDlg').dialog('close')">取消</a>  
    </div>  
</body>
<script>
//添加时上传完毕
function addUploadOver(imgName){
	alert(imgName);
	alert("add upload over");
	var src = $("#addImg").attr("src");
	src = src.substr(0,src.lastIndexOf("/")+1);
	$("#addImg").attr("src",src+imgName);
	$("#addImgForm").hide();
	$("#addShowImgDiv").show();
	
}

//添加时删除不满意的图片
function deleteInAddPic(){
	var src = $("#addImg").attr("src");
	var imgName = src.substr(src.lastIndexOf("/")+1);
	$.ajax({
		type:'POST',
		data:{'medicine.img':imgName},
		url:'<%=base%>basedata/MedicineAction!deleteInAddPic.action',
		success:function(datas){
			$("#addImgForm").show();
			$("#addShowImgDiv").hide();
			$("#aImgFile").val('');
		}
	})
}

//修改完上传图片
function modifyUploadOver(imgName){
	alert("in modifyUploadOver");
	alert(imgName);
	var src = $("#mImg").attr("src");
	src = src.substr(0,src.lastIndexOf("/")+1);
	$("#mImg").attr("src",src+imgName);
	var mdiv = $("#modifyDlg");
	mdiv.find("#deleteImgSpan").show();
	mdiv.find("#hiddenModifyUpload").hide();
}

//修改时删除文件
function deleteInModifyPic(){
	var src = $("#mImg").attr("src");
	var imgName = src.substr(src.lastIndexOf("/")+1);
	var mdiv = $("#modifyDlg");
	var medicineNo = mdiv.find("#medicineNo").val();
	$.ajax({
		type:'POST',
		data:{'medicine.img':imgName,'medicine.medicineNo':medicineNo},
		url:'<%=base%>basedata/MedicineAction!deleteInModifyPic.action',
		success:function(datas){
			alert("delete success");
			
			mdiv.find("#hiddenModifyUpload").show();
			mdiv.find("#deleteImgSpan").hide();//将删除按钮隐藏
			mdiv.find("#hidden_frame2").hide();//隐藏表单
			$("#mImgFile").val('');
			//将图片设置为无图片
			var src = $("#mImg").attr("src");
			src = src.substr(0,src.lastIndexOf("/")+1);
			$("#mImg").attr("src",src+'no-images.jpg');
		}
	})
}

</script>
</html>
