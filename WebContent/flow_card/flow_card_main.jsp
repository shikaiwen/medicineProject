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
<title>流向单管理</title>

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
		title:'流向单列表',
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
				$("#datastore").data("row",row);//将行数据缓存起来
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
		loadMsg:'数据加载中...',
		frozenColumns:[[
            {field:'ck',checkbox:true},
		]],
		columns:[
		[
			{field:'flowCardId',title:'流向单编号',width:120,height:30},
			{field:'creator.userName',title:'制单人',width:150,rowspan:2,height:30,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				},formatter:function(v,r,i){
					return formatColumn('creator.userName',v,r,i);
				}
			},
			{field:'totalMoney',title:'总金额',width:150,height:30,rowspan:2},
			{field:'flowCardState',title:'流向单状态',width:220,height:30,rowspan:2,formatter:function(v,r,i){
				return formatColumn('flowCardState.dictName',v,r,i);
			}},
			{field:"createDate",title:'制单日期',width:220,height:30,rowspan:2},
			{field:'agent.agentName',title:'分销商',width:120,rowspan:2,height:30,formatter:function(v,r,i){
				var v = 0;
				return formatColumn('agent.agentName',v,r,i);
			}},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'添加',
			iconCls:'icon-add',
			//handler:showAddMedicineDialog
			
		},{
			id:'btnedit',
			text:'修改',
			iconCls:'icon-edit',		
		},{
			id:'btnremove',
			text:'删除',
			iconCls:'icon-remove',
		//	handler:deleteOrder		
		}]
	});
	
	var p = $('#flowCards').datagrid('getPager');
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
	window.open ('medicine_add_dialog.jsp','newwindow','height=300,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, titlebar=no,resizable=no,location=no, status=no'); 
}






function save(){
	
//	alert(JSON.stringify($.messager));
	$.messager['defaults']['ok']='确定';
	$.messager.alert("提示信息","保存成功",'info');
}



//添加条件
$(function(){
	$(".datagrid-toolbar").append($("#tb"));
})


$(function(){

	
	//添加订单状态
	$.ajax({
		url:'<%=base%>datadict/DictAction!getDictOptionByType.action?dict.category=L',
		success:function(datas){
			
			$("#flowCardState").html(datas);
		}
	});
})




//根据条件查询
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

//重置条件
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
							<b>流向单管理&gt;&gt;流向单查询</b>
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
			 流向单编号:<input type="text" name="flowCardId" id="flowCardId" size="12"/>
		 	制单人:<input type="text" name="creatorName" id="creatorName" size="12"/>
			流向单状态:<select id="flowCardState"></select>
			&nbsp;&nbsp;&nbsp;
			
			流向单日期从:<input class="easyui-datebox" id="flowCardDateFrom" style="width:105px"/>
			&nbsp;&nbsp;&nbsp;到:&nbsp;&nbsp;<input class="easyui-datebox" id="flowCardDateTo" style="width:105px"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="toQuery()">查询</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="resetCondition()">重置</a>
			<br><br>
		</div>
	</div>
    <iframe id="downloadIframe" style="display:none">
    </iframe>
    	<div id="showDetailDlg" class="easyui-dialog" style="margin-right:auto;margin-left:auto;width:300px" closed="true" buttons="#showDetailDlg-buttons">
		<table id="detailTable" class="table2">
			<tr><td>药品编号:</td><td></td>
				<td>药品名称:</td><td></td>
			</tr>
		</table>
	</div>
	 <div id="showDetailDlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modifyMedicine()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#modifyDlg').dialog('close')">取消</a>  
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
