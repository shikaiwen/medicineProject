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
<title>�û�����</title>
<link rel="stylesheet" href="<%=base%>cssfiles/drp.css">

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>

<script type="text/javascript" src="<%=base%>jsfiles/datagrid-detailview.js"></script>
<script type="text/javascript">

var dd ;


$(function(){
	dd = $('#users').datagrid({
		title:'�û��б�',
		view:detailview,
		detailFormatter:function(index,row){
			//alert("in formatter index="+index+"row="+row);
			return '<div id="ddv-' + index + '" style="padding:5px 0"></div>';
		},
		onExpandRow:function(index,row){
			$('#ddv-'+index).panel({
				border:false,
				cache:false,
				href:'test.html',
				onLoad:function(){
				//	alert("load over");
					$('#users').datagrid('fixDetailRowHeight',index);
				}
			});
			//$('#users').datagrid('fixDetailRowHeight',index);
		},
		iconCls:'icon-save',
		pageSize:20,
		width:'100%',
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
		idField:'code',
		loadMsg:'���ݼ�����...',
		onLoadSuccess:appendSearchConditions,
		frozenColumns:[[
            {field:'ck',checkbox:true},
           //{title:'Code',field:'code',width:80,sortable:true} 
		]],
		columns:[
		
		[/*
			{field:'userId',title:'�û�����',width:120,height:30},
			{field:'userName',title:'�û�����',width:220,rowspan:2,height:30,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
			{field:'password',title:'����',width:150,height:30,rowspan:2},
			{field:'email',title:'�����ʼ�',width:150,rowspan:2,height:30},
			{field:'createDate',title:'����ʱ��',width:150,rowspan:2,height:30}*/
			{field:'medicineNo',title:'ҩƷ���',width:120,height:30},
			{field:'medicineName',title:'ҩƷ����',width:150,rowspan:2,height:30,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
			{field:'normalName',title:'ͨ������',width:150,height:30,rowspan:2},
			{field:'price',title:'�۸�',width:220,height:30,rowspan:2},
			{field:'functionType',title:'��������',width:220,height:30,rowspan:2},
			{field:'approvalNumber',title:'��׼�ĺ�',width:120,rowspan:2,height:30},
			{field:'manufacturer',title:'������ҵ',width:220,rowspan:2,height:30}
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'����û�',
			iconCls:'icon-add',
			handler:addUser
			
		},{
			id:'btnedit',
			text:'�޸�',
			iconCls:'icon-edit',
			handler:modifyUser//function(){
			//	$('#btnsave').linkbutton('enable');
			//	alert('cut')
			//}
		}]
	});
	
	var p = $('#users').datagrid('getPager');
	$(p).pagination({
		pageSize:15,
		pageList:[5,10,15,20],
		beforePageText:'��',
		afterPageText:'ҳ     ��{pages}ҳ',
		displayMsg:'��ǰ��ʾ {from} - {to} ����¼',
		onBeforeRefresh:function(){
			alert('before refresh');
		}
	});
});


function modifyUser(){
//	var v = $("#users").datagrid();
var rows = dd.datagrid("getChecked");
var rows2 = dd.datagrid("getSelections");
var n;
}

function addUser(){
	
show();
	//var v = $("#users").datagrid("getChecked");
	/*
	jQuery.dialog({
		title:'����û�',
		width:800,
		height:500,
		content:'url:sysmgr/user_add.jsp',
		lock:true,
		drag:true
	});
	*/
}

function saveUser(){
	alert("in saveUser");
}


function show (){
	$("#dlg").dialog({
    title: 'My Dialog',  
	width: 400,  
	height: 200,  
	closed: false,  
	cache: false,  
//	href: 'add.html',  
	modal: true
})
}

function appendSearchConditions(){
	
}
//�������
$(function(){
	$(".datagrid-toolbar").append($("#tb"));
})
</script>
</head>
<body class="body1">
			<div align="center">
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
							<b>ϵͳ����&gt;&gt;�û�ά��</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				</div>
				

	<table id="users" style="width:800px" height="900px" toolbar="#conditions">
	</table>
	
	<!-- toolbar -->
	<div id="tb" style="padding:5px;height:auto">
		<div>
			Date From: <input class="easyui-datebox" style="width:80px">

			To: <input class="easyui-datebox" style="width:80px">
			Language: 
			<input class="easyui-combobox" style="width:100px"
					url="data/combobox_data.json"
					valueField="id" textField="text"><br>
					�û���:<input type="text" name="userName" id="userName" size="7"/>
					�û�����:<input type="text" id="userId" size="7"/>
			<a href="javascript:void(0)" onclick="toQuery()" class="easyui-linkbutton" iconCls="icon-search" >Search</a>
		</div>
	</div>
	
	<!-- �Ի��� -->
	<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-buttons">
		The dialog content.
	</div>
	 <div id="dlg-buttons">  
	 
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">save</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">cancel</a>  
    </div>  
</body>
<input type="button" onclick="checkDatagridProperty()" value="Clicke me "/>
<script type="text/javascript">
function checkDatagridProperty(){
	var a = $("#users").datagrid("options");
	alert(a.url);
}

function toQuery(){
	var url = $("#users").datagrid("options").url;
	url += "?userName="+$("#userName").val();
	url += "&userId="+$("#userId").val();
	$("#users").datagrid("options").url = url;
//	alert($("#users").datagrid("options").url)
	$("#users").datagrid("reload");
}
</script>
</html>
