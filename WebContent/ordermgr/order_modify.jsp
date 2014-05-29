<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
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
			title:'订单详细',
			detailFormatter:function(index,row){
			},
			onExpandRow:function(index,row){
			},
			iconCls:'icon-save',
			resizable:true,
			width:'90%',
			height:'500',
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
				{field:'action',title:'操作',width:120,align:'center',rowspan:2,
					formatter:function(value,row,index){
						if (row.editing){
							var s = '<a href="#" onclick="saverow(this)">保存</a> ';
							var c = '<a href="#" onclick="cancelrow(this)">取消</a>';
							return s+c;
						} else {
							var e = '<a href="#" onclick="editrow(this)">编辑</a> ';
						//	var d = '<a href="#" onclick="deleterow(this)">Delete</a>';
							var d = '';
							return e+d;
						}
					}
				}
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
				text:'添加',
				iconCls:'icon-add',
				handler:openMedicineWindow
				
			},{
				id:'btnremove',
				text:'删除',
				iconCls:'icon-remove',
				handler:function(){
					var rows = dd.datagrid("getSelections");
				//	alert(JSON.stringify(rows))
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
		return parseInt(tr.attr('datagrid-row-index'));
	}
	function editrow(target){
		dd.datagrid('beginEdit', getRowIndex(target));
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
	
	
	//加载订单信息
$(function(){
	var orderId = '<s:property value="order.orderId"></s:property>';
	//alert(orderId)
	$.ajax({
		type:"POST",
		url:'<%=base%>order/OrderAction!getModifyData.action',
		data:{"order.orderId":orderId,"prepare":"getData"},
		success:function(datas){
			var data = $.parseJSON(datas);
			var data = $.parseJSON(data);
			$("#orderId").val(data['orderId']);
			$("#orderState").val(data['orderState']['dictId']);
			$("#totalMoney").val(data['totalMoney']);
			var s = 0;
			
			var medicineArray = new Array();
			for(var v=0;v<data['orderDetail'].length;v++){
				medicineArray.push(data['orderDetail'][v]);
			}
			
			for(var v=0;v<medicineArray.length;v++){
				//添加数量和明细
				medicineArray[v]['medicine']['quantity'] = medicineArray[v]['quantity'];
				medicineArray[v]['medicine']['detailId']= medicineArray[v]['detailId'];  
				 
				dd.datagrid('insertRow',{index:1,row:medicineArray[v]['medicine']});
			}
		//	dd.datagrid('insertRow',{index:1,row:data[v]});
		//	alert(datas);
		}
	})
	})
	
	//打开药品选择窗口
	function openMedicineWindow(){
		window.open ('<%=base%>basedata/medicine_info.jsp','newwindow','height=500,width=1300,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 
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
			d['quantity'] = 10;
			dd.datagrid('insertRow',{index:1,row:data[v]});
		}
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
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=J',
		success:function(datas){
			$("#orderState").html(datas);
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
	
	//保存订单
	function saveOrder(){
		var data = dd.datagrid("getRows");
		//order.orderDetail.orderId=num
		var queryStr = "";
		queryStr += "order.creator.userId="+$("#userId").val()+"&";
		queryStr += "order.creator.userName="+$("#userName").val()+"&";
		queryStr += "order.totalMoney="+$("#totalMoney").val()+"&";
/* 		for(var v=0;v<data.length;v++){
			queryStr += "order.orderDetail.medicineNo=" + data[v]['medicineNo']+"&";
			queryStr += "order.orderDetail.quantity=" + data[v]['quantity']+"&";
		} */
		for(var v=0;v<data.length;v++){
			queryStr += "detailList["+v+"].medicine.medicineNo="+data[v]['medicineNo']+"&";
			queryStr += "detailList["+v+"].quantity="+data[v]['quantity']+"&";
			queryStr += "detailList["+v+"].price="+data[v]['price']+"&"
		}
		
		queryStr = queryStr.substr(0,queryStr.length-1);
		
		$.ajax({
			type:'POST',
			url:'<%=base%>order/OrderAction!addOrder.action',
			data:queryStr,
			success:function(datas){
				var data = $.parseJSON(datas);
				$("#orderState").val(data['resultMap']['orderState']);
				$("#orderId").val(data['resultMap']['orderId']);
				$("#saveSpan").hide();
				$("#submitSpan").show();
				alert("操作成功");
			}
		})
	}
	
//提交订单
function submitOrder(){
	var orderId = $("#orderId").val();
	var data = new Object();
	data['order.orderId'] = orderId;
	//alert(JSON.stringify(data))
	$.ajax({
		type:'POST',
		url:'<%=base%>order/OrderAction!submitOrder.action',
		data:data,
		success:function(datas){
			$("#orderState").val('242');
			alert("操作成功");
		}
	})
}

//导入内容
function importOrder(){
	$("#xlsFile").bind("change",upload);
	var fileName = $("#xlsFile").click();
	//alert($("#xlsFile").val());
	
}

function upload(){
	alert("in change,:"+$("#xlsFile").val());
	var form = $("#modifyFileForm");
	form.submit();
	$("#xlsFile").unbind("change");
}

//反序列化数据,从excel导入数据时使用
function deserializeData(json){
	var data = new Array();
	for(var v=0;v<json.length;v++){
		var arr = json[v];
		if(!data[v]){
			data[v] = {};
		}
		data[v]['medicineNo'] = arr['medicine']['medicineNo'];
		data[v]['medicineName'] = arr['medicine']['medicineName'];
		data[v]['normalName'] = arr['medicine']['normalName'];
		data[v]['price'] = arr['medicine']['price'];
		
		data[v]['quantity'] = arr['quantity'];
		
	}
	var totalMoney = 0;
	for(var v=0;v<data.length;v++){
		totalMoney += parseFloat(data[v]['price'])*parseFloat(data[v]['quantity']);
		dd.datagrid('insertRow',{index:1,row:data[v]});
	}
	$("#totalMoney").val(totalMoney);
}

//修改订单
function modify(){
		var data = dd.datagrid("getRows");
		//order.orderDetail.orderId=num
		var queryStr = "";
		queryStr += "order.orderId="+$("#orderId").val()+"&";
	//	queryStr += "order.creator.userName="+$("#userName").val()+"&";
		queryStr += "order.totalMoney="+$("#totalMoney").val()+"&";
		for(var v=0;v<data.length;v++){
			queryStr += "detailList["+v+"].medicine.medicineNo="+data[v]['medicineNo']+"&";
			queryStr += "detailList["+v+"].quantity="+data[v]['quantity']+"&";
			queryStr += "detailList["+v+"].detailId="+data[v]['detailId']+"&";
			queryStr += "detailList["+v+"].price="+data[v]['price']+"&"
		}
		
		$.ajax({
			type:'POST',
			data:queryStr,
			url:'<%=base%>order/OrderAction!realModify.action',
			success:function(datas){
				alert("操作成功");
				$("#saveSpan").hide();
				$("#submitSpan").show();
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
							<b>订单管理&gt;&gt;<span id="operate_module">修改订单</span></b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
	<div style="margin-right:auto;margin-left:auto;width:700px">
		<table id="contentTable" style="width:600px">
			<tr>
				<td>订单编号:</td><td><input type="text" name="order" id="orderId" disabled="disabled"></td>
				<td>制单人:</td><td><input type="text" name="order.userName" id="userName" value="${sessionScope.USER.userName}" disabled="disabled">
									<input type="hidden" name="order.userId" id="userId" value="${sessionScope.USER.userId}"/>
				</td>
			</tr>
			<tr>
				<td>订单状态:</td><td><select disabled="disabled" name="order.orderState" id="orderState"></select></td>
				<td>总金额(元):</td><td><input type="text" name="order.totalMoney" disabled="disabled" id="totalMoney"></td>
			</tr>
		</table>
		
		<div id="oper_button" style="float:right;">  
        <span id="saveSpan"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modify()">保存</a>&nbsp;&nbsp;&nbsp;</span>
        <span id="submitSpan" style="display:none"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitOrder()">提交</a></span>
    </div> 
	</div>
</div><br><br><br>
<div id="orderContentDiv" style="margin-left:auto;margin-right:auto;width:900px;">
	<table id="orderDetails"></table>
</div>
</body>
</html>