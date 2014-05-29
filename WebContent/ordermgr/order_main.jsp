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
<title>��������</title>

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/layout.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>

<script type="text/javascript">

var dd ;
$(function(){
	dd = $('#orders').datagrid({
		title:'�����б�',
		view:detailview,
		detailFormatter:function(index,row){
		//	alert("adf");
				//alert(row['functionType']['dictName']);
			return '<div id="ddv-' + index+ '" style="padding:5px 0"></div>';
		},
		onExpandRow:function(index,row){
			$('#ddv-'+index).panel({
				border:false,
				cache:false,
				href:'<%=base%>order/OrderAction!getDetailedOrder.action?order.orderId='+row.orderId,
				onLoad:function(){
				var div = $("#ddv-"+index);
				$('#orders').datagrid('fixDetailRowHeight',index);
				}
			});
			$('#orders').datagrid('fixDetailRowHeight',index);
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
		url:'<%=base%>order/OrderAction!getResultByPage.action',
	//	sortName: 'code',
	//	sortOrder: 'desc',
		remoteSort: false,
		idField:'orderId',
		loadMsg:'���ݼ�����...',
		frozenColumns:[[
            {field:'ck',checkbox:true},
		]],
		columns:[
		[
			{field:'orderId',title:'�������',width:120,height:30},
			{field:'creator.userName',title:'�Ƶ���',width:150,rowspan:2,height:30,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				},formatter:function(v,r,i){
					return formatColumn('creator.userName',v,r,i);
				}
			},
			{field:'totalMoney',title:'�ܽ��',width:150,height:30,rowspan:2},
			{field:'orderState',title:'����״̬',width:220,height:30,rowspan:2,formatter:function(v,r,i){
				return formatColumn('orderState.dictName',v,r,i);
			}},
			{field:"orderDate",title:'��������',width:220,height:30,rowspan:2},
			
			{field:'agent.agentName',title:'������',width:120,rowspan:2,height:30,formatter:function(v,r,i){
				return formatColumn('agent.agentName',v,r,i);
			}},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnedit',
			text:'�޸�',
			iconCls:'icon-edit',
			handler:function(){
				var win = window.parent.document.documentElement;
				var datas = dd.datagrid("getSelections");
				if(datas.length !=1){
					alert("��ѡ��һ������");return;
				}
				if(datas[0]['orderState']['dictId']!='241'){
					alert("��״̬�²����޸�!");return;
				}
				
				var str = "&prepare=Y&order.orderId="+datas[0]['orderId'];
			//	console.log($(win).find());
				var url="<%=base%>order/OrderAction!modifyOrder.action?"+str;
				window.parent.addTab('�޸Ķ���',url);
				//alert($(win).find("head").html());
				//alert(win);
				//$("win").find("#testt").html();
			}
		},{
			id:'btnremove',
			text:'����',
			iconCls:'icon-remove',
			handler:exportOrder	
		},{
			id:'btnremove',
			text:'�鿴�������',
			iconCls:'icon-remove',
			handler:function (){
				var win = window.parent.document.documentElement;
				var datas = dd.datagrid("getSelections");
				var str = "&flowCard.flowCardId="+datas[0]['orderId'];
				var url="<%=base%>flowCard/FlowCardAction!showSendInfo.action?"+str;
				window.parent.addTab('�������',url);
			}	
		},{
			id:'btnremove',
			text:'ɾ��',
			iconCls:'icon-remove',
			handler:deleteOrder		
		}]
	});
	
	var p = $('#orders').datagrid('getPager');
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

//����
function exportOrder(){
	var rows = dd.datagrid("getSelections");
	var queryStr = "";
	for(var v=0;v<rows.length;v++){
	//	alert(JSON.stringify(rows[v]));
		queryStr += "orderList["+v+"].orderId="+rows[v]['orderId']+"&";
		queryStr += "agentIdArray["+v+"]="+rows[v]['agent']['agentId']+"&";
	}
	queryStr = queryStr.substr(0,queryStr.length-1);
	var action =  '<%=base%>order/OrderAction!exportOrder.action';
	var src = action +"?"+ queryStr;
	$("#downloadIframe").attr("src",src);
	

}
//����Ƕ�׶���
function formatColumn(colName, value, row, index) {
	    return eval("row."+colName);
}


function test(){
	window.open ('medicine_add_dialog.jsp','newwindow','height=300,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 
}






function save(){
	
//	alert(JSON.stringify($.messager));
	$.messager['defaults']['ok']='ȷ��';
	$.messager.alert("��ʾ��Ϣ","����ɹ�",'info');
}


//ɾ������
function deleteOrder(){
	var rows = dd.datagrid("getSelections");
	if(rows.length ==0) {
		alert("��ѡ��Ҫɾ���ļ�¼");return;
	}
	var queryStr = ""; 
	for(var v=0;v<rows.length;v++){
		queryStr += "orderList.orderId="+rows[v]['orderId']+"&";
	//	var index = dd.datagrid("getRowIndex",rows[v]);
	//	dd.datagrid("deleteRow",index);
	}
	queryStr = queryStr.substr(0,queryStr.length-1);
	
	$.ajax({
		type:'POST',
		url:'<%=base%>order/OrderAction!deleteOrder.action',
		data:queryStr,
		success:function(datas){
		//	alert(datas);
		toQuery();
		alert("ɾ���ɹ�");
		}
	})
}

//�������
$(function(){
	$(".datagrid-toolbar").append($("#tb"));
})

//��ӱȽ������
$(function(){
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=K',
		success:function(datas){
			//alert(datas);
			$("#operator").html(datas);
		}
	});
	
	//��Ӷ���״̬
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=J',
		success:function(datas){
			//alert(datas);
			$("#orderState").html(datas);
		}
	});
})




//����������ѯ
function toQuery(){

	var toolBar = $("#tb");
	var data = new Object();
	data['order.orderId'] = toolBar.find("#orderId").val();
	data['order.creator.userName'] = toolBar.find("#creatorName").val();
	data['order.totalMoney'] = toolBar.find("#totalMoney").val();
	data['order.orderState.dictId'] = toolBar.find("#orderState").val();
	data['operator'] = toolBar.find("#operator").val();
	data['orderDateFrom'] = toolBar.find("#orderDateFrom").datebox("getValue");
	data['orderDateTo'] = toolBar.find("#orderDateTo").datebox("getValue");
	
	dd.datagrid("options").queryParams = data;
//	dd.datagrid("options").url = url;
	dd.datagrid('reload'); 
}

//��������
function resetCondition(){
//	alert("reset conditions");
//	alert(JSON.stringify(dd.datagrid("options").queryParams));
	dd.datagrid("options").queryParams = {};
//	alert(JSON.stringify(dd.datagrid("options").queryParams));
	var toolBar = $("#tb");
	toolBar.find("#orderId").val('');
	toolBar.find("#creatorName").val('');
	toolBar.find("#orderDateFrom").val('');
	toolBar.find("#orderDateTo").val('');
	toolBar.find("#operator").val('0');
}

function showSendInfo(){
	
}
</script>
</head>
<body class="body1">
			<div align="center">
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
							<b>��������&gt;&gt;������ѯ</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
				
	<table id="orders"  toolbar="#conditions" style="width:500px;height:450px">
	</table>
	
	<!-- toolbar -->
	<div id="tb" style="padding:5px;height:auto">
		<div>
		<!-- 
			�������ڴ�: <input class="easyui-datebox" style="width:100px">
			��: <input class="easyui-datebox" style="width:100px">
		 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 �������:<input type="text" name="orderId" id="orderId" size="12"/>
		 	�Ƶ���:<input type="text" name="creatorName" id="creatorName" size="12"/>
			�۸�:<select name="operator" id="operator"></select>&nbsp;&nbsp;<input type="text" id="totalMoney" size="12"/>
			����״̬:<select id="orderState"></select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="toQuery()">��ѯ</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="resetCondition()">����</a><br><br>&nbsp;&nbsp;&nbsp;
			
			�������ڴ�:<input class="easyui-datebox" id="orderDateFrom" style="width:105px"/>
			&nbsp;&nbsp;&nbsp;��:&nbsp;&nbsp;<input class="easyui-datebox" id="orderDateTo" style="width:105px"/>

			<br><br>
		</div>
	</div>
    <iframe id="downloadIframe" style="display:none">
    </iframe>
</body>
<script>

</script>
</html>
