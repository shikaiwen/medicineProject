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
<title></title>

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">

<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/tinymce/tinymce.min.js"></script>
<script type="text/javascript">

var dd ;
$(function(){
	dd = $('#medicines').datagrid({
		title:'ҩƷ��Ϣ',
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
            {field:'ck',checkbox:true},
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
			},
			},
			{field:'approvalNumber',title:'��׼�ĺ�',width:120,rowspan:2,height:30},
			{field:'manufacturer',title:'������ҵ',width:220,rowspan:2,height:30},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'��ӿ��',
			iconCls:'icon-add',
			handler:addToStorage
			
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


//��ӵ����
function addToStorage(){

	var datas = $("#medicines").datagrid("getSelections");
	if(datas.length!=1){
		alert("��ѡ��Ҫ����ҩƷ��");return;
	} 
	var data= datas[0];
	var mainTable = $("#mainTable");
//	var header = mainTable.find("#headerInfo");
	var header = $("#templateHeader").clone();
	//����tr�����Ƹ�ΪmainTr
	header.attr("name","header");
	header.find("#medicineNo").html(data['medicineNo']);
	header.find("#medicineName").html(data['medicineName']);
	header.appendTo(mainTable);
	
	
//	tr.attr("name",header.attr("id"));
	//��ÿ��td��id��ΪҩƷ�ı��

	$("#addDlg").dialog({
	    title: '��ӿ��',  
		width: 1000,  
		height: 370,  
		closed: false,  
		draggable:true,
		resizable:true,
		cache: false,  
		modal: true
	})
}

//��Ӷ�����ϸ
function addDetail(obj){
	var header = $(obj).parent().parent();
	var medicineNo = header.find("td").eq(1).find("span").html();
	var tr = $("#templateTr").clone();
	tr.find("td").each(function(){
		$(this).attr("name",medicineNo);
	})
	tr.appendTo($("#mainTable"));
}


//����õ���
function saveStoreDocket(){
	var mainTable = $("#mainTable");
	
	var medicineNoArray = new Array();
	var medicineDetailQuantityArray = new Array();
	
	mainTable.find("tr[name='header']").each(function(){
		
		var medicineNo = $(this).find("td").eq(1).find("span").html();
		medicineNoArray.push(medicineNo);
		medicineDetailQuantityArray.push(mainTable.find("td[name='"+medicineNo+"']").length);
		
	})
	
	var queryStr = "";
	for(var v=0;v<medicineNoArray.length;v++){
		queryStr += medicineNoArray[v]+"="+medicineDetailQuantityArray[v]+"&";
	}
	queryStr = queryStr.substr(0,queryStr.length-1);
	
	$.ajax({
		type:'POST',
		url:'<%=base%>store/StoreAction!initMedicineDetail.action',
		data:queryStr,
		success:function(datas){
			alert(datas)
			var data = $.parseJSON(datas);
			$("#storeId").val(data['storeId']);
			alert("�����ɹ�");
		}
	})
}
</script>
</head>
<style>
.trbg{
		background-color:#B5E7F4;
	}
</style>
<body class="body1">
			<div align="">
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
							<b>������&gt;&gt;ҩƷ���</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
				
	<div id="docketInfo"><br>
		<table align="center">
			<tr>
			<td>��ⵥ���:</td><td><input type="text" name="storeId" id="storeId" disabled="disabled"/></td>
			<td>�Ƶ���:</td><td><input type="text" name="docketNo"  value="${sessionScope.USER.userName}" disabled="disabled"/></td>
			</tr>
		</table>
		<br>
	</div>
	<table id="medicines"  toolbar="#conditions" style="width:500px;height:450px">
	</table>
	
	
	<div id="tb" style="padding:5px;height:auto">
		<div>
		<!-- 
			�������ڴ�: <input class="easyui-datebox" style="width:100px">
			��: <input class="easyui-datebox" style="width:100px">
		 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 ҩƷ���:<input type="text" name="medicine.medicineName" id="medicineNo" size="12">
		 	ҩƷ����:<input type="text" name="medicine.medicineName" id="medicineName" size="12">
		 	ҩƷͨ������:<input type="text" name="medicine.normalName" id="normalName" size="12">
			ҩƷ�������: 
			<select name="functionType" id="functionType"></select>
			ҩƷ��������:
			<select name="manageType" id="manageType"></select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="toQuery()">��ѯ</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="resetCondition()">����</a>
			<br><br>
		</div>
	</div>
	
	<!-- �Ի��� -->
	<div id="addDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#dlg-buttons">
	<div id="mainContent">
		
		<style>
				.table2{
				width:800px;
				margin-left:auto;
				margin-right:auto;
				margin-top:20px;
				padding:0px;
				border:1px solid black;
				}
				
				.table2 td{
				text-align:center;
				border:1px solid black;
				margin:0px;
				padding:0px;
				cell-spacing:0px;
				}
				.table2 tr{
				border:1px solid black;
				margin:0px;
				padding:0px;
				}
		</style>
		
		
		<table id="mainTable" class="table2">
		</table>
	</div>
	<table id="templateTable" style="display:none">
			<tr id="templateHeader">
				<td>ҩƷ���:</td><td><span id="medicineNo"></span></td>
				<td>ҩƷ����:</td><td ><span id="medicineName"></span></td>
				<td colspan="2"><input type="button" id="addDetail" onclick="addDetail(this)" value="�����ϸ"/></td>
			</tr>
			<tr id="templateTr">
				<td><span name="detailNo">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>`
				<td><span name="detailNo">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>
			</tr>
	</table>
	</div>
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveStoreDocket()">����</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#addDlg').dialog('close')">ȡ��</a>  
    </div>  
    
    
    <script type="text/javascript">
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


    //����������ѯ
    function toQuery(){

//    	var url = dd.datagrid("options").url;
//    	url += "?medicine.medicineNo="+123;
    	
    	var toolBar = $("#tb");
    	var data = new Object();
    	data['medicine.medicineNo'] = toolBar.find("#medicineNo").val();
    	data['medicine.medicineName'] = toolBar.find("#medicineName").val();
    	data['medicine.normalName'] = toolBar.find("#normalName").val();
    	data['medicine.functionType.dictId'] = toolBar.find("#functionType").val();
    	data['medicine.manageType.dictId'] = toolBar.find("#manageType").val();
    	
    	dd.datagrid("options").queryParams = data;
//    	dd.datagrid("options").url = url;
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
</body>
</html>
