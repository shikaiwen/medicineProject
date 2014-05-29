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
			title:'������ϸ',
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
			loadMsg:'���ݼ�����...',
//			onClickCell:function(index,field,value){
//				$(this).datagrid('beginEdit', index);
//				},
			frozenColumns:[[
	            {field:'ck',checkbox:true},
			]],
			columns:[
			[
				{field:'medicineNo',title:'ҩƷ���',width:120,height:30},
				{field:'medicineName',title:'ҩƷ����',width:150,rowspan:1,height:30,sortable:true},
				{field:'normalName',title:'ͨ������',width:150,height:30,rowspan:2},
				{field:'price',title:'�۸�',width:150,height:30,rowspan:1},
				{field:"quantity",title:'����',width:150,height:30,rowspan:1,editor:{type:'numberbox'}},
/* 				{field:'action',title:'����',width:120,align:'center',rowspan:2,
					formatter:function(value,row,index){
						if (row.editing){
							var s = '<a href="#" onclick="saverow(this)">����</a> ';
							var c = '<a href="#" onclick="cancelrow(this)">ȡ��</a>';
							return s+c;
						} else {
							var e = '<a href="#" onclick="editrow(this)">����</a> ';
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
				//�����ܼ�
				computePrice();
			},
			onCancelEdit:function(index,row){
				row.editing = false;
				updateActions(index);
			},
			rownumbers:true,
			toolbar:[{
				id:'btnadd',
				text:'���ҩƷ',
				iconCls:'icon-add',
				handler:openMedicineWindow
				
			},{
				id:'btnedit',
				text:'��ѯ����',
				iconCls:'icon-edit',
				handler:function(){
				//	alert(JSON.stringify(dd.datagrid("getRows")));
				}//function(){
				//	$('#btnsave').linkbutton('enable');
				//	alert('cut')
				//}
			},{
				id:'btnremove',
				text:'���ҩƷ��ϸ',
				iconCls:'icon-add',
				handler:addDetail
			},{
				id:'btnremove',
				text:'ɾ��',
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
		$.messager.confirm('����','ȷ��Ҫɾ����?',function(r){
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
	
	//��ҩƷѡ�񴰿�
	function openMedicineWindow(){
		window.open ('<%=base%>basedata/medicine_info.jsp','newwindow','height=500,width=1300,top=100,left=100,toolbar=no,menubar=no,titlebar=no,scrollbars=no, resizable=no,location=no, status=no'); 
	}
	

	
	//�鿴�����Ƿ��ڱ����
	function isNowColumn(col){
		var array = ["medicineNo","medicineName","normalName","price","quantity"];
		for(var v=0;v<array.length;v++){
			if(array[v]==col){
				return true;
			}
		}
	}
	
	
	//��Ӷ���״̬
	$.ajax({//getDictOptionByTypeWithNoHeader
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=L',
		success:function(datas){
			$("#flowCardState").html(datas);
		//	$("#orderState").val('241');
		}
	})
	
	//����۸�
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
	
	//���ҩƷ������
	function addDetail(){
		var data = dd.datagrid("getSelected");
		//alert(JSON.stringify(data))
		
		if(!data) {
			alert("��ѡ������");return;
		}
		$("#detailDlg").dialog({
		    title: '��ӿ��',  
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

	//�����
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
	
//��ʼ����ϸ���
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
	//�ҵ����һ��td�ĸ���
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

//��������
function updateQuantity(){
	var data = dd.datagrid("getRows");
	//��ȡ���е�medicineNo
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
			alert("�����ɹ�");
			$("#flowCardState").val('253');
		}
	})
}

//��鶩�����Ƿ����
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
							<b>���򵥹���&gt;&gt;<span id="operate_module">�������</span></b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
	<div style="margin-right:auto;margin-left:auto;width:900px">
		<table id="contentTable" style="width:800px">
			<tr>
				<td>���򵥺�:</td><td><input type="text" name="flowCardId" id="flowCardId" onblur="checkValid()"></td>
				<td>�Ƶ���:</td><td><input type="text" name="flowCard.agent.agentName" id="creatorName" value="${sessionScope.USER.userName}" disabled="disabled">
									<input type="hidden" name="flowCard.agent.agentId" id="creatorId" value="${sessionScope.USER.userId}"/>
				<td>����״̬:</td><td><select disabled="disabled" name="flowCard.flowCardState" id="flowCardState"></select></td>
				</td>
			</tr>
			<tr>
				<td>������:</td><td><input type="text" name="flowCard.agent.agentName" id="agentName" disabled="disabled" >
							<input type="hidden" name="flowCard.agent.agentId" id="agentId" value=""/>
				</td>
				<td>�����̵�ַ:</td><td><input type="text" name="address" disabled="disabled" id="address"></td>
				<td>�ܽ��(Ԫ):</td><td><input type="text" name="flowCard.totalMoney" disabled="disabled" id="totalMoney"></td>
			</tr>
		</table>
		
		<div id="oper_button" style="float:right;">  
        <span id="saveSpan"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveFlowCard()">����</a>&nbsp;&nbsp;&nbsp;</span>
        <span id="submitSpan" style="display:none"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitOrder()">�ύ</a></span>
    </div> 
	</div>
</div><br><br><br>

	<!-- �Ի��� -->
	<div id="detailDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#dlg-buttons">
	<div id="mainContent">
		
	</div>
		<table id="blankTable" name="detailTable" class="table2" style="display:none">
			<tr id="header">
				<td>ҩƷ���:</td><td><span id="medicineNo"></span></td>
				<td>ҩƷ����:</td><td><span id="medicineName"></span></td>
				<td colspan="2">
				<input type="button" id="addDetail" onclick="addTd(this)" value="�����ϸ"/>
				<input type="button" id="addDetail" onclick="deleteTd(this)" value="ɾ����ϸ"/>
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
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="updateQuantity()">����</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#detailDlg').dialog('close')">ȡ��</a>  
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