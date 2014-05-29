<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body>
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<link rel="stylesheet" href="<%=base%>cssfiles/drp.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/self_location.css">

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	var dd ;
	$(function(){
		dd = $('#orderDetails').datagrid({
			title:'流向单详细',
			detailFormatter:function(index,row){
			},
			onExpandRow:function(index,row){
			},
			iconCls:'icon-save',
			resizable:true,
			width:'90%',
			height:'500',
			singleSelect:true,
			resizable:true,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			collapsible:true,
		//	url:'%=base%>basedata/MedicineAction!getResultByPage.action',
			sortName: 'code',
			sortOrder: 'desc',
			remoteSort: false,
			loadMsg:'数据加载中...',
//			onClickCell:function(index,field,value){
//				$(this).datagrid('beginEdit', index);
//				},
			frozenColumns:[[
	            {field:'ck',checkbox:true},
			]],
			columns:[
			[
				{field:'medicineNo',title:'药品编号',width:120,height:30},
				{field:'medicineName',title:'药品名称',width:150,rowspan:1,height:30,sortable:true},
				{field:'normalName',title:'通用名称',width:150,height:30,rowspan:2},
				{field:'price',title:'价格',width:150,height:30,rowspan:1},
				{field:"quantity",title:'数量',width:150,height:30,rowspan:1,editor:{type:'numberbox'}},
/* 				{field:'action',title:'操作',width:120,align:'center',rowspan:2,
					formatter:function(value,row,index){
						if (row.editing){
							var s = '<a href="#" onclick="saverow(this)">保存</a> ';
							var c = '<a href="#" onclick="cancelrow(this)">取消</a>';
							return s+c;
						} else {
							var e = '<a href="#" onclick="editrow(this)">更新</a> ';
						//	var d = '<a href="#" onclick="deleterow(this)">Delete</a>';
							var d = '';
							return e+d;
						}
					}
				} */
			]],
			onBeforeEdit:function(index,row){
				row.editing = true;
				updateActions(index);
			},
			onAfterEdit:function(index,row){
				row.editing = false;
				updateActions(index);
				//计算总价
				computePrice();
			},
			onCancelEdit:function(index,row){
				row.editing = false;
				updateActions(index);
			},
			rownumbers:true,
			toolbar:[{
				id:'btnadd',
				text:'添加药品',
				iconCls:'icon-add',
				handler:openMedicineWindow
				
			},{
				id:'btnedit',
				text:'查询数据',
				iconCls:'icon-edit',
				handler:function(){
				//	alert(JSON.stringify(dd.datagrid("getRows")));
				}//function(){
				//	$('#btnsave').linkbutton('enable');
				//	alert('cut')
				//}
			},{
				id:'btnremove',
				text:'添加药品明细',
				iconCls:'icon-add',
				handler:addDetail
			},{
				id:'btnremove',
				text:'删除',
				iconCls:'icon-remove',
				handler:function(){
					var rows = dd.datagrid("getSelections");
					//alert(JSON.stringify(rows))
					for(var v=0;v<rows.length;v++){
						var index = dd.datagrid("getRowIndex",rows[v]);
						dd.datagrid("deleteRow",index);
					}
					
				}	
			}]
		});
	});
	
	function updateActions(index){
		dd.datagrid('updateRow',{
			index: index,
			row:{}
		});
	}
	function getRowIndex(target){
		var tr = $(target).closest('tr.datagrid-row');
	//	alert(tr.attr('datagrid-row-index'));
	//	alert($(tr).html());
	//	alert($(tr).find("td[field='quantity']").find("div").html());
		$(tr).find("td[field='quantity']").find("div").html(100);
	//	alert($(tr).find("td[field='quantity']").find("div").html())
		return parseInt(tr.attr('datagrid-row-index'));
	}
	function editrow(target){
		dd.datagrid('beginEdit', getRowIndex(target));
		var tr = $(target).closest('tr.datagrid-row');
	//	alert(tr.html());
	//	alert(tr.find("td[field='quantity']").html());
		saverow(target);	
	}
	function deleterow(target){
		$.messager.confirm('警告','确定要删除吗?',function(r){
			if (r){
				dd.datagrid('deleteRow', getRowIndex(target));
			}
		});
	}
	function saverow(target){
		dd.datagrid('endEdit', getRowIndex(target));
	}
	function cancelrow(target){
		dd.datagrid('cancelEdit', getRowIndex(target));
	}
	
	//打开药品选择窗口
	function openMedicineWindow(){
		window.open ('<%=base%>basedata/medicine_info.jsp','newwindow','height=500,width=1300,top=100,left=100,toolbar=no,menubar=no,titlebar=no,scrollbars=no, resizable=no,location=no, status=no'); 
	}
	

	
	//查看该列是否在表格中
	function isNowColumn(col){
		var array = ["medicineNo","medicineName","normalName","price","quantity"];
		for(var v=0;v<array.length;v++){
			if(array[v]==col){
				return true;
			}
		}
	}
	
	
	//添加订单状态
	$.ajax({//getDictOptionByTypeWithNoHeader
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=L',
		success:function(datas){
			$("#flowCardState").html(datas);
		//	$("#orderState").val('241');
		}
	})
	
	//计算价格
	function computePrice(){
		var totalPrice = 0;
		var data = dd.datagrid("getRows");
		for(var v=0;v<data.length;v++){
			totalPrice += parseInt(data[v]['quantity'])* parseFloat(data[v]['price']);
		}	
	//	alert(totalPrice);
		$("#totalMoney").val(totalPrice);
	//	alert(JSON.stringify(data))
	}
	
	//添加药品具体编号
	function addDetail(){
		var data = dd.datagrid("getSelected");
		//alert(JSON.stringify(data))
		
		if(!data) {
			alert("请选择数据");return;
		}
		$("#detailDlg").dialog({
		    title: '添加库存',  
			width: 1100,  
			height: 400,  
			closed: false,  
			draggable:true,
			resizable:true,
			cache: false,  
			modal: true
		})
		var medicineNo = data['medicineNo'];
		$("#mainContent").find("table").each(function(){
			//alert($(this).attr("id"));
			if(medicineNo==$(this).attr("id")){
				$(this).show()
			}else{
				$(this).hide();
			}
		})
		//$("table").find("#"+medicineNo).show();
	}

	//添加行
	function appendRow(data){
	//	alert(JSON.stringify(data))
		for(var v=0;v<data.length;v++){
		//	dd.datagrid('insertRow',{index:1,row:data[v]});
			var d = data[v];
			for(var j in d){
				if(!isNowColumn(j)){
					delete d[j];
				}
			}
			d['quantity'] = 0;
			dd.datagrid('insertRow',{index:1,row:data[v]});
		}
		initDetailTable();
	}
	
//初始化明细表格
function initDetailTable(){
	var data = dd.datagrid("getRows");
	var div = $("#mainContent");
	var table;
	var header
	for(var v=0;v<data.length;v++){
		
		table = $("#blankTable").clone();
		table.attr("id",data[v]['medicineNo']);
		header = $(table).find("#header");
		header.find("td").eq(1).html(data[v]['medicineNo']);
		header.find("td").eq(3).html(data[v]['medicineName']);
		var cont = table.find("#cont");
		cont.find("td").attr("name",data[v]['medicineNo']);
		
	//	$(table).show();
		table.appendTo(div);
		
	}
//	alert($("#mainContent").html());
}

function addTd(td){
	var table = $(td).parent().parent().parent();
	var medicineNo = table.find("tr").eq(0).find("td").eq(1).html();
	//alert(medicineNo);
	var trIndex = table.find("tr").length -1 ;
	//找到最后一行td的个数
	var lastRowTdNum = $(table).find("tr").eq(trIndex).find("td").length;
	
	if(lastRowTdNum==6){
		var tr = $("<tr></tr>");//$("#blankTable").find("#cont").clone().find("td").remove();
		var td = $("#blankTable").find("#cont").find("td").eq(0).clone().attr("name",medicineNo);
		td.appendTo(tr);
		tr.appendTo(table);
	}else{
		var lastTr = $(table).find("tr").eq(trIndex);
		var td = $("#blankTable").find("#cont").find("td").eq(0).clone().attr("name",medicineNo);
		td.appendTo(lastTr);
	}
	//alert(lastRowTdNum);
	//$(table).find("tr td[name="++"]")
}
function deleteTd(td){
	var table = $(td).parent().parent().parent();
	var trIndex = table.find("tr").length -1 ;
	if(trIndex == 0) return;
	table.find("tr:last").find("td:last").remove();
	if(table.find("tr:last").find("td").length == 0){
		table.find("tr:last").remove();
	}
}

//更新数量
function updateQuantity(){
	var data = dd.datagrid("getRows");
	//获取所有的medicineNo
	var medicineNoArray = new Array();
	for(var v=0;v<data.length;v++){
		medicineNoArray.push(data[v]['medicineNo']);
	}
	
	
	var result = new Array();
	$("table").each(function(){
	var id = $(this).attr("id");
	//alert(id);
	if(isExist(id,medicineNoArray)){
		var obj = new Object();
	//	alert(id);
		obj['medicineNo'] = id;
		obj['quantity'] = $(this).find("td[name='"+id+"']").length;
		result.push(obj);
	}});
	
	
	var totalMoney = 0;
	for(var v=0;v<data.length;v++){
		var medicineNo = data[v]['medicineNo'];
		//var quantity = 0;
		for(var n=0;n<result.length;n++){
			if(medicineNo == result[n]['medicineNo']){
				data[v]['quantity'] = result[n]['quantity'];
				break;
			}
		}
		totalMoney += parseFloat(data[v]['quantity']) * parseFloat(data[v]['price']);
		var rowIndex = dd.datagrid("getRowIndex",data[v]);
		dd.datagrid("updateRow",{
			index:rowIndex,
			row:{quantity:data[v]['quantity']
			}
		}) 
		}
	$("#totalMoney").val(totalMoney);
	$('#detailDlg').dialog('close');
}
function isExist(id,arr){
	for(var v=0;v<arr.length;v++){
		if(id == arr[v]){
			return true;
		}
	}
}

function saveFlowCard(){
	var data = dd.datagrid("getRows");
	var queryStr = "";
	queryStr += "flowCard.flowCardId="+$("#flowCardId").val()+"&";
	//queryStr += "flowCard.agent.agentName="+$("#agentName").val()+"&";
	queryStr += "flowCard.agent.agentId="+$("#agentId").val()+"&";
	queryStr += "flowCard.creator.userId="+$("#creatorId").val()+"&";
	queryStr += "flowCard.totalMoney="+$("#totalMoney").val()+"&";
	for(var v=0;v<data.length;v++){
		queryStr += "flowCardDetailList["+v+"].medicine.medicineNo="+data[v]['medicineNo']+"&";
		queryStr += "flowCardDetailList["+v+"].quantity="+data[v]['quantity']+"&";
		queryStr += "flowCardDetailList["+v+"].price="+data[v]['price']+"&";
	}
	//queryStr += "flowCard.agent.agentId="+$("#agentId").val();
	queryStr = queryStr.substr(0,queryStr.length-1);
	$.ajax({
		type:'POST',
		data:queryStr,
		url:'<%=base%>flowCard/FlowCardAction!saveFlowCard.action',
		success:function(datas){
			alert("操作成功");
			$("#flowCardState").val('253');
		}
	})
}

//检查订单号是否存在
function checkValid(){
	if($("#flowCardId").val()=='')return;
	
	$.ajax({
		type:'POST',
		data:{"flowCard.flowCardId":$("#flowCardId").val()},
		url:'<%=base%>flowCard/FlowCardAction!checkFlowCardIsValid.action',
		success:function(datas){
			var data = $.parseJSON(datas);
			var resultList = data['resultList'];
			var address = resultList[0]['address'];
			$("#address").val(address);
			var agent = resultList[1]['agent'];
			$("#agentId").val(agent['agentId']);
			$("#agentName").val(agent['agentName']);
		}
	})
}
</script>
<body>
	<div>
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
							<b>流向单管理&gt;&gt;<span id="operate_module">添加流向单</span></b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
	<div style="margin-right:auto;margin-left:auto;width:900px">
		<table id="contentTable" style="width:800px">
			<tr>
				<td>流向单号:</td><td><input type="text" name="flowCardId" id="flowCardId" onblur="checkValid()"></td>
				<td>制单人:</td><td><input type="text" name="flowCard.agent.agentName" id="creatorName" value="${sessionScope.USER.userName}" disabled="disabled">
									<input type="hidden" name="flowCard.agent.agentId" id="creatorId" value="${sessionScope.USER.userId}"/>
				<td>流向单状态:</td><td><select disabled="disabled" name="flowCard.flowCardState" id="flowCardState"></select></td>
				</td>
			</tr>
			<tr>
				<td>分销商:</td><td><input type="text" name="flowCard.agent.agentName" id="agentName" disabled="disabled" >
							<input type="hidden" name="flowCard.agent.agentId" id="agentId" value=""/>
				</td>
				<td>分销商地址:</td><td><input type="text" name="address" disabled="disabled" id="address"></td>
				<td>总金额(元):</td><td><input type="text" name="flowCard.totalMoney" disabled="disabled" id="totalMoney"></td>
			</tr>
		</table>
		
		<div id="oper_button" style="float:right;">  
        <span id="saveSpan"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveFlowCard()">保存</a>&nbsp;&nbsp;&nbsp;</span>
        <span id="submitSpan" style="display:none"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitOrder()">提交</a></span>
    </div> 
	</div>
</div><br><br><br>

	<!-- 对话框 -->
	<div id="detailDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#dlg-buttons">
	<div id="mainContent">
		
	</div>
		<table id="blankTable" name="detailTable" class="table2" style="display:none">
			<tr id="header">
				<td>药品编号:</td><td><span id="medicineNo"></span></td>
				<td>药品名称:</td><td><span id="medicineName"></span></td>
				<td colspan="2">
				<input type="button" id="addDetail" onclick="addTd(this)" value="添加明细"/>
				<input type="button" id="addDetail" onclick="deleteTd(this)" value="删除明细"/>
				</td>
			</tr>
			<tr id="cont">
				<td><span name="">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>
				<td><span name="detailNo">0x222222222</span></td>
			</tr>
		</table>
	</div>
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="updateQuantity()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#detailDlg').dialog('close')">取消</a>  
    </div> 

<div id="orderContentDiv" style="margin-left:auto;margin-right:auto;width:900px;">
	<table id="orderDetails"></table>
</div>
</body>
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
		<script>
		</script>
</html>