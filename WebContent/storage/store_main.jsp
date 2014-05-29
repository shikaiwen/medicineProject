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
		title:'药品信息',
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
            {field:'ck',checkbox:true},
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
			},
			},
			{field:'approvalNumber',title:'批准文号',width:120,rowspan:2,height:30},
			{field:'manufacturer',title:'生产企业',width:220,rowspan:2,height:30},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'添加库存',
			iconCls:'icon-add',
			handler:addToStorage
			
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


//添加到库存
function addToStorage(){

	var datas = $("#medicines").datagrid("getSelections");
	if(datas.length!=1){
		alert("请选择要入库的药品！");return;
	} 
	var data= datas[0];
	var mainTable = $("#mainTable");
//	var header = mainTable.find("#headerInfo");
	var header = $("#templateHeader").clone();
	//将主tr的名称改为mainTr
	header.attr("name","header");
	header.find("#medicineNo").html(data['medicineNo']);
	header.find("#medicineName").html(data['medicineName']);
	header.appendTo(mainTable);
	
	
//	tr.attr("name",header.attr("id"));
	//将每个td的id变为药品的编号

	$("#addDlg").dialog({
	    title: '添加库存',  
		width: 1000,  
		height: 370,  
		closed: false,  
		draggable:true,
		resizable:true,
		cache: false,  
		modal: true
	})
}

//添加订单明细
function addDetail(obj){
	var header = $(obj).parent().parent();
	var medicineNo = header.find("td").eq(1).find("span").html();
	var tr = $("#templateTr").clone();
	tr.find("td").each(function(){
		$(this).attr("name",medicineNo);
	})
	tr.appendTo($("#mainTable"));
}


//保存该单据
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
			alert("操作成功");
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
							<b>库存管理&gt;&gt;药品入库</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
				
	<div id="docketInfo"><br>
		<table align="center">
			<tr>
			<td>入库单编号:</td><td><input type="text" name="storeId" id="storeId" disabled="disabled"/></td>
			<td>制单人:</td><td><input type="text" name="docketNo"  value="${sessionScope.USER.userName}" disabled="disabled"/></td>
			</tr>
		</table>
		<br>
	</div>
	<table id="medicines"  toolbar="#conditions" style="width:500px;height:450px">
	</table>
	
	
	<div id="tb" style="padding:5px;height:auto">
		<div>
		<!-- 
			生产日期从: <input class="easyui-datebox" style="width:100px">
			到: <input class="easyui-datebox" style="width:100px">
		 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 药品编号:<input type="text" name="medicine.medicineName" id="medicineNo" size="12">
		 	药品名称:<input type="text" name="medicine.medicineName" id="medicineName" size="12">
		 	药品通用名称:<input type="text" name="medicine.normalName" id="normalName" size="12">
			药品功能类别: 
			<select name="functionType" id="functionType"></select>
			药品管理类型:
			<select name="manageType" id="manageType"></select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="toQuery()">查询</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="resetCondition()">重置</a>
			<br><br>
		</div>
	</div>
	
	<!-- 对话框 -->
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
				<td>药品编号:</td><td><span id="medicineNo"></span></td>
				<td>药品名称:</td><td ><span id="medicineName"></span></td>
				<td colspan="2"><input type="button" id="addDetail" onclick="addDetail(this)" value="添加明细"/></td>
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
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveStoreDocket()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#addDlg').dialog('close')">取消</a>  
    </div>  
    
    
    <script type="text/javascript">
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


    //根据条件查询
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
</body>
</html>
