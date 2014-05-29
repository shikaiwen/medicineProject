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
<title>ҩƷ����</title>
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
		title:'ҩƷ�б�',
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
				//Ϊ�ռ丳ֵ
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
		loadMsg:'���ݼ�����...',
		frozenColumns:[[
            {field:'ck',checkbox:true}
           //{title:'Code',field:'code',width:80,sortable:true} 
		]],
		columns:[
		[
			{field:'medicineNo',title:'ҩƷ���',width:120,height:30},
			{field:'medicineName',title:'ҩƷ����',width:150,rowspan:2,height:30,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
			{field:'normalName',title:'ͨ������',width:150,height:30,rowspan:2},
			{field:'price',title:'�۸�',width:220,height:30,rowspan:2},
			{field:"functionType.dictName",title:'��������',width:220,height:30,rowspan:2,formatter:function(v,r,i){
				return formatColumn('functionType.dictName',v,r,i);//alert("param3"+param3+"param1 is :"+param1+"  param2 is "+JSON.stringify(param2));
			}
			},
			{field:'approvalNumber',title:'��׼�ĺ�',width:120,rowspan:2,height:30},
			{field:'manufacturer',title:'������ҵ',width:220,rowspan:2,height:30},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'���',
			iconCls:'icon-add',
			handler:showAddMedicineDialog
			
		},{
			id:'btnedit',
			text:'�޸�',
			iconCls:'icon-edit',
			handler:showModifyMedicineDialog//function(){
			//	$('#btnsave').linkbutton('enable');
			//	alert('cut')
			//}
		},{
			id:'btnremove',
			text:'ɾ��',
			iconCls:'icon-remove',
			handler:deleteMedicine		
		}]
	});
	
	var p = $('#medicines').datagrid('getPager');
	$(p).pagination({
		pageSize:10,
		pageList:[5,10,22,20],
		beforePageText:'��',
		afterPageText:'ҳ     ��{pages}ҳ',
		displayMsg:'��ǰ��ʾ {from} - {to} ����¼',
		onBeforeRefresh:function(){
			alert('before refresh');
		}
	});
	
});


//����Ƕ�׶���
function formatColumn(colName, value, row, index) {
	    return eval("row."+colName);
}


function test(){
	window.open ('medicine_add_dialog.jsp','newwindow','height=300,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 
}


//��ʾ���
function showAddMedicineDialog(){

	$("#addMedicineTable").css("margin-left","auto");
	$("#addMedicineTable").css("margin-right","auto");
	$("#addMedicineTable").css("margin-top","20px");
	$("#addDlg").dialog({
	    title: '���ҩƷ',  
		width: 1100,  
		height: 400,  
		closed: false,  
		draggable:true,
		resizable:true,
		cache: false,  
		modal: true
	})

	
}




//���ҩƷ
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
			alert('�����ɹ�');	
			alert(datas);
			var obj = $.parseJSON(datas);
			table.find("#medicineNo").val(obj['medicineNo']);
		}
	})
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
	height: 440,  
	closed: false,  
	cache: false,  
//	href: 'add.html',  
	modal: true
})
}

//�������
$(function(){
	$(".datagrid-toolbar").append($("#tb"));
})

//���ҩƷ���ܷ���
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
	//��ӹ������
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=D',
		success:function(datas){
			$("#manageType").html(datas);
			$("#addMedicineTable #manageType").html(datas);
			$("#modifyMedicineTable #manageType").html(datas);
		}
	})
	
	//��Ӽ�����λ
		$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=I',
		success:function(datas){
		//	$("#manageType").html(datas);
			$("#addMedicineTable #unit").html(datas);
			$("#modifyMedicineTable #unit").html(datas);
		}
	})
})



//�Ƿ��ֵ�
$(function(){
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=F',
		success:function(datas){
			$("#useSpecialPrice").html(datas);
			$("#modifyMedicineTable #useSpecialPrice").html(datas);
		}
	})
	
})


//�༭�� 
$(function(){
	 tinymce.init({selector:'textarea',language:'zh_CN'});
	 $("#hidden_frame").hide();
})


//��ʾ�޸Ŀ�
function showModifyMedicineDialog(){
	var div = $("#modifyDlg");
	div.find("#hidden_frame").hide();
	var datas = $("#medicines").datagrid("getSelections");
	if(datas.length != 1){
		alert("��ѡ��һ������");
		return;
	}

	$("#modifyMedicineTable").css("margin-left","auto");
	$("#modifyMedicineTable").css("margin-right","auto");
	$("#modifyMedicineTable").css("margin-top","20px");
	$("#modifyDlg").dialog({
	    title: '�޸�ҩƷ',  
		width: 1100,  
		height: 400,  
		closed: false,  
		draggable:true,
		resizable:true,
		cache: false,  
		modal: true
	})
	//Ϊ���ֵ
	var table = $("#modifyMedicineTable");
//	table.find("#userId").val("123");
	for(var key in datas[0]){
		table.find("#"+key).val(datas[0][key]);
	}
	//Ϊ�ֵ丳ֵ
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
	
	
	//����ͼƬ
	var src = $("#mImg").attr("src");
	src = src.substr(0,src.lastIndexOf("/")+1);
	var img = datas[0]['img'];
	$("#mImg").attr("src",src+img);
	if(datas[0]['img']=='no-images.jpg'){
		$("#hiddenModifyUpload").show();$("#hidden_frame2").hide();//��ʾ�ϴ���ť
		//$("#deleteImgSpan").hide();	//����ɾ��ͼƬ
		var div = $("#modifyDlg").find("#deleteImgSpan").hide();
	}
}

//�޸�ҩƷ
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
			alert('�����ɹ�');	
			alert(datas);
			var obj = $.parseJSON(datas);
			table.find("#medicineNo").val(obj['medicineNo']);
		}
	})
}

//ɾ��ͼƬ
function deletePic(){
	$.messager.defaults={ok:'ȷ��',cancel:'ȡ��'};
	$.messager.confirm('ȷ�Ͽ�','ȷ��Ҫɾ����?',function(result){ 
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
					//����ͼƬ
					var src = $("#mImg").attr("src");
					src = src.substr(0,src.lastIndexOf("/")+1);
					var img = 'no-images.jpg';
					$("#mImg").attr("src",src+img);
					//����
					$("#deleteImgSpan").hide();
					$("#hiddenModifyUpload").show();//��ʾ�ϴ���ť
				}
			})
		}
	});
}

//�޸�ʱ�ϴ��ļ�
function toSubmit(){
	
}

//ɾ��ҩƷ
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
			alert("ɾ���ɹ�!");
			str = ""; //������������ã����ɾ������ӣ�����ԭ����о�
			$('#medicines').datagrid('reload');  
		}
	})
}

//����������ѯ
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

//��������
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
			 ҩƷ���:<input type="text" name="medicine.medicineName" id="medicineNo" size="9">
		 	ҩƷ����:<input type="text" name="medicine.medicineName" id="medicineName" size="9">
			ҩƷ�������: 
			<select name="functionType" id="functionType" ></select>
			ҩƷ��������:
			<select name="manageType" id="manageType"></select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="toQuery()">��ѯ</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="resetCondition()">����</a>
			<br><br>
		</div>
	</div>
	
	<!-- �Ի��� -->
	<div id="addDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#dlg-buttons">
		<table id="addMedicineTable">
			<tr><td>ҩƷ���:</td><td><input type="text" size="22" name="medicineNo" id="medicineNo" disabled="disabled"/></td>
				<td>ҩƷ����:</td><td><input type="text" size="22" name="medicineName" id="medicineName" class="easyui-validatebox" data-options="required:true" missingMessage="ҩƷ���Ʋ���Ϊ��" /></td>
			</tr>
			<tr>
				<td>ͨ������:</td><td><input type="text" size="22" name="normalName" class="easyui-validatebox" data-options="required:true" missingMessage="ͨ�����Ʋ���Ϊ��" id="normalName"/></td>
				<td>��׼�ĺ�:</td><td><input type="text" size="22" name="approvalNumber" class="easyui-validatebox" data-options="required:true" missingMessage="��׼�ĺŲ���Ϊ��" id="approvalNumber"/></td>
			</tr>
			<tr>
				<td>��Ʒ��ǩ:</td><td><input type="text" size="22" name="productLabel" class="easyui-validatebox" data-options="required:true" missingMessage="��Ʒ��ǩ����Ϊ��" id="productLabel"/></td>
				<td>���:</td><td><input type="text" size="22" name="specification" class="easyui-validatebox" data-options="required:true" missingMessage="�����Ϊ��" id="specification"/></td>
			</tr>
			<tr>
				<td>�÷�������:</td><td><input type="text" size="22"  name="usageDosage" id="usageDosage"/></td>
				<td>�ɷ�:</td><td><input type="text" size="22" name="ingredients" id="ingredients"/></td>
			</tr>
			<tr>
				<td>���ܷ���:</td><td><select name="functionType" id="functionType"></select></td>
				<td>�������:</td><td><select name="manageType" id="manageType"></select></td>
			</tr>
			<tr>
				<td>�Ƿ�ʹ�ù̶��۸�:</td><td><select name="useSpecialPrice" id="useSpecialPrice"></select></td>
				<td>������λ:</td><td><select name="unit" id="unit"></select></td>
			</tr>
			<tr>
			<td>�۸�:</td><td><input type="text" size="22" name="price" class="easyui-validatebox" data-options="required:true" missingMessage="�۸�Ϊ����" id="price"/></td>
			<td>������ҵ:</td><td><input type="text" size="22" class="easyui-validatebox" data-options="required:true" missingMessage="������ҵ����Ϊ��" name="manufacturer" id="manufacturer"/></td>
			</tr>
			<tr><td>ͼƬ:
			</td>
			<td>
			<div style="display:none" id="addShowImgDiv"><img id="addImg" src="<%=base%>uploadFiles/" style="width:120px;height:100px;"/>
			<span id="deleteImgSpan"><input type="button" value="ɾ��ͼƬ" onclick="deleteInAddPic()"/></span>
			</div>
			<div id="addImgForm">
				<form action="<%=base%>basedata/MedicineAction!uploadImg.action" target="hidden_frame" encType="multipart/form-data" method="post">
					<input type="file" name="imgFile" id="aImgFile">
					<input type="submit" value="�ϴ��ļ�">
					<iframe id="hidden_frame"  name="hidden_frame"></iframe>
				</form>
			</div>
			</td></tr>
		</table>
		<div>
			����:<textarea name="descriptions" id="descriptions"></textarea>
		</div>
	</div>
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="addMedicine()">����</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#addDlg').dialog('close')">ȡ��</a>  
    </div>  
    
    
    <!-- �޸ĶԻ��� -->
    	<!-- �Ի��� -->
	<div id="modifyDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#mdlg-buttons">
		<table id="modifyMedicineTable">
			<tr><td>ҩƷ���:</td><td><input type="text" size="22" name="medicineNo" id="medicineNo" disabled="disabled"/></td>
				<td>ҩƷ����:</td><td><input type="text" size="22" name="medicineName" id="medicineName" class="easyui-validatebox" data-options="required:true" missingMessage="ҩƷ���Ʋ���Ϊ��" /></td>
			</tr>
			<tr>
				<td>ͨ������:</td><td><input type="text" size="22" name="normalName" class="easyui-validatebox" data-options="required:true" missingMessage="ͨ�����Ʋ���Ϊ��" id="normalName"/></td>
				<td>��׼�ĺ�:</td><td><input type="text" size="22" name="approvalNumber" class="easyui-validatebox" data-options="required:true" missingMessage="��׼�ĺŲ���Ϊ��" id="approvalNumber"/></td>
			</tr>
			<tr>
				<td>��Ʒ��ǩ:</td><td><input type="text" size="22" name="productLabel" class="easyui-validatebox" data-options="required:true" missingMessage="��Ʒ��ǩ����Ϊ��" id="productLabel"/></td>
				<td>���:</td><td><input type="text" size="22" name="specification" class="easyui-validatebox" data-options="required:true" missingMessage="�����Ϊ��" id="specification"/></td>
			</tr>
			<tr>
				<td>�÷�������:</td><td><input type="text" size="22" name="usageDosage" id="usageDosage"/></td>
				<td>�ɷ�:</td><td><input type="text" size="22" name="ingredients" id="ingredients"/></td>
			</tr>
			<tr>
				<td>���ܷ���:</td><td><select name="functionType" id="functionType"></select></td>
				<td>�������:</td><td><select name="manageType" id="manageType"></select></td>
			</tr>
			<tr>
				<td>�Ƿ�ʹ�ù̶��۸�:</td><td><select name="useSpecialPrice" id="useSpecialPrice"></select></td>
				<td>������λ:</td><td><select name="unit" id="unit"></select></td>
			</tr>
			<tr>
			<td>�۸�:</td><td><input type="text" size="22" name="price" id="price"/></td>
			<td>������:</td><td><input type="text" size="22" name="manufacturer" id="manufacturer"/></td>
			</tr>
			<tr><td>ͼƬ:</td>
			<td>
			<div id="imgSpanDiv">
			<img id="mImg" src="<%=base%>uploadFiles/" style="width:120px;height:100px;"/>
			<span id="deleteImgSpan"><input type="button" value="ɾ��ͼƬ" onclick="deleteInModifyPic()"/></span>
			</div>
			<div id="hiddenModifyUpload" style="display:none">
				<form id="modifyFileForm" action="<%=base%>basedata/MedicineAction!modifyUploadImg.action" target="hidden_frame2" encType="multipart/form-data" method="post">
					<input type="file" name="imgFile">
					<input type="submit"  value="�ϴ��ļ�">
					<iframe id="hidden_frame2"  name="hidden_frame2"></iframe>
				</form>
			</div>
			</td>
			</tr>
		</table>
		<div>
			����:<textarea name="descriptions2" id="descriptions2"></textarea>
		</div>
	</div>
	 <div id="mdlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modifyMedicine()">����</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#modifyDlg').dialog('close')">ȡ��</a>  
    </div>  
</body>
<script>
//���ʱ�ϴ����
function addUploadOver(imgName){
	alert(imgName);
	alert("add upload over");
	var src = $("#addImg").attr("src");
	src = src.substr(0,src.lastIndexOf("/")+1);
	$("#addImg").attr("src",src+imgName);
	$("#addImgForm").hide();
	$("#addShowImgDiv").show();
	
}

//���ʱɾ���������ͼƬ
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

//�޸����ϴ�ͼƬ
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

//�޸�ʱɾ���ļ�
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
			mdiv.find("#deleteImgSpan").hide();//��ɾ����ť����
			mdiv.find("#hidden_frame2").hide();//���ر�
			$("#mImgFile").val('');
			//��ͼƬ����Ϊ��ͼƬ
			var src = $("#mImg").attr("src");
			src = src.substr(0,src.lastIndexOf("/")+1);
			$("#mImg").attr("src",src+'no-images.jpg');
		}
	})
}

</script>
</html>
