<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>���򵥹���</title>

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
	dd = $('#flowCards').datagrid({
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
				href:'<%=base%>flowCard/FlowCardAction!getDetailedFlowCard.action?flowCard.flowCardId='+row.flowCardId,
				onLoad:function(){
				var div = $("#ddv-"+index);
				$("#datastore").data("row",row);//�������ݻ�������
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
		url:'<%=base%>flowCard/FlowCardAction!getResultByPage.action',
	//	sortName: 'code',
	//	sortOrder: 'desc',
		remoteSort: false,
		idField:'flowCardId',
		loadMsg:'���ݼ�����...',
		frozenColumns:[[
            {field:'ck',checkbox:true},
		]],
		columns:[
		[
			{field:'flowCardId',title:'���򵥱��',width:120,height:30},
			{field:'creator.userName',title:'�Ƶ���',width:150,rowspan:2,height:30,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				},formatter:function(v,r,i){
					return formatColumn('creator.userName',v,r,i);
				}
			},
			{field:'totalMoney',title:'�ܽ��',width:150,height:30,rowspan:2},
			{field:'flowCardState',title:'����״̬',width:220,height:30,rowspan:2,formatter:function(v,r,i){
				return formatColumn('flowCardState.dictName',v,r,i);
			}},
			{field:"createDate",title:'�Ƶ�����',width:220,height:30,rowspan:2},
			{field:'agent.agentName',title:'������',width:120,rowspan:2,height:30,formatter:function(v,r,i){
				var v = 0;
				return formatColumn('agent.agentName',v,r,i);
			}},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'���',
			iconCls:'icon-add',
			//handler:showAddMedicineDialog
			
		},{
			id:'btnedit',
			text:'�޸�',
			iconCls:'icon-edit',		
		},{
			id:'btnremove',
			text:'ɾ��',
			iconCls:'icon-remove',
		//	handler:deleteOrder		
		}]
	});
	
	var p = $('#flowCards').datagrid('getPager');
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
	window.open ('medicine_add_dialog.jsp','newwindow','height=300,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, titlebar=no,resizable=no,location=no, status=no'); 
}






function save(){
	
//	alert(JSON.stringify($.messager));
	$.messager['defaults']['ok']='ȷ��';
	$.messager.alert("��ʾ��Ϣ","����ɹ�",'info');
}



//�������
$(function(){
	$(".datagrid-toolbar").append($("#tb"));
})


$(function(){

	
	//��Ӷ���״̬
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=L',
		success:function(datas){
			
			$("#flowCardState").html(datas);
		}
	});
})




//����������ѯ
function toQuery(){
	var toolBar = $("#tb");
	var data = new Object();
	data['flowCardId'] = toolBar.find("#flowCardId").val();
	data['creatorName'] = toolBar.find("#creatorName").val();
	data['flowCardState'] = toolBar.find("#flowCardState").val();
	data['flowCardDateFrom'] = toolBar.find("#flowCardDateFrom").datebox("getValue");
	data['flowCardDateTo'] = toolBar.find("#flowCardDateTo").datebox("getValue");
	
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
							<b>���򵥹���&gt;&gt;���򵥲�ѯ</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
			</div>
				
	<table id="flowCards"  toolbar="#conditions" style="width:500px;height:450px">
	</table>
	
	<!-- toolbar -->
	<div id="tb" style="padding:5px;height:auto">
		<div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 ���򵥱��:<input type="text" name="flowCardId" id="flowCardId" size="12"/>
		 	�Ƶ���:<input type="text" name="creatorName" id="creatorName" size="12"/>
			����״̬:<select id="flowCardState"></select>
			&nbsp;&nbsp;&nbsp;
			
			�������ڴ�:<input class="easyui-datebox" id="flowCardDateFrom" style="width:105px"/>
			&nbsp;&nbsp;&nbsp;��:&nbsp;&nbsp;<input class="easyui-datebox" id="flowCardDateTo" style="width:105px"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="toQuery()">��ѯ</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="resetCondition()">����</a>
			<br><br>
		</div>
	</div>
    <iframe id="downloadIframe" style="display:none">
    </iframe>
    	<div id="showDetailDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#showDetailDlg-buttons">
		<table id="detailTable" class="table2">
			<tr><td>ҩƷ���:</td><td></td>
				<td>ҩƷ����:</td><td></td>
			</tr>
		</table>
	</div>
	 <div id="showDetailDlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modifyMedicine()">����</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#modifyDlg').dialog('close')">ȡ��</a>  
    </div>  
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
</body>
<script>

</script>
</html>
