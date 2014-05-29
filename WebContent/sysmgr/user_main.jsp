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
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/demo.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/icon.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.validatebox.js"></script>

<script type="text/javascript">



$(function(){
	$('#users').datagrid({
		title:'�û��б�',
		iconCls:'icon-save',
		width:'85%',
		height:'500',
		resizable:true,
		nowrap: true,
		autoRowHeight: false,
		checkOnSelect:true,
		selectOnCheck:true,
		striped: true,
		collapsible:true,
		url:'<%=base%>sys/UserAction!getAllUserJsonModle.action',
		sortName: 'code',
		sortOrder: 'desc',
		remoteSort: false,	
	//	idField:'userId',
		loadMsg:'���ݼ�����...',
		frozenColumns:[[
            {field:'ck',checkbox:true},
           //{title:'Code',field:'code',width:80,sortable:true} 
		]],
		columns:[
		
		[
			{field:'userId',title:'�û�����',width:120},
			{field:'userName',title:'�û�����',width:220,rowspan:2,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
			{field:'contactTel',title:'��ϵ�绰',width:150,rowspan:2},
			{field:'email',title:'�����ʼ�',width:150,rowspan:2},
			{field:'agent.agentName',title:'����������',width:150,rowspan:2,formatter:function(v,r,i){
				try{
					return formatColumn('agent.agentName',v,r,i);
				}catch(e){return "";}
				
			}},
			{field:'createDate',title:'����ʱ��',width:150,rowspan:2},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'����û�',
			iconCls:'icon-add',
			handler:showAddUserDialog
		},{
			id:'btnedit',
			text:'�޸�',
			iconCls:'icon-edit',
			handler:showModifyUserDialog//function(){
			//	$('#btnsave').linkbutton('enable');
			//	alert('cut')
			//}
		},{
			id:'btndelete',
			text:'ɾ��',
			iconCls:'icon-remove',
			handler:deleteUser
		}]
	});
	var p = $('#users').datagrid('getPager');
	$(p).pagination({
		pageSize:10,
		pageList:[5,10,15,20],
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

//��ʾ��ӿ�
function showAddUserDialog(){
	$("#contentTable").css("margin-left","auto");
	$("#contentTable").css("margin-right","auto");
	$("#contentTable").css("margin-top","20px");
	$("#dlg").dialog({
	    title: '����û�',  
		width: 600,  
		height: 400,  
		closed: false,  
		cache: false,  
		modal: true
	})
}

//��ʾ�޸Ŀ�
function showModifyUserDialog(){
	var datas = $("#users").datagrid("getSelections");
	if(datas.length != 1){
		alert("��ѡ��һ������");
		return;
	}

//	return;
	$("#mcontentTable").css("margin-left","auto");
	$("#mcontentTable").css("margin-right","auto");
	$("#mcontentTable").css("margin-top","20px");
	$("#mdlg").dialog({
	    title: '�޸��û�',  
		width: 600,  
		height: 400,  
		closed: false,  
		cache: false,  
		modal: true
	})
	//Ϊ���ֵ
	var table = $("#mcontentTable");
	table.find("#userId").val("123");
	for(var key in datas[0]){
		table.find("#"+key).val(datas[0][key]);
	}
	table.find("#agentName").val(datas[0]['agent']['agentName']);
	table.find("#belongAgentId").val(datas[0]['agent']['agentId']);
}

//����û�
function  addUser(){
	var table = $("#contentTable");
//	var validResult = $("#contentTable").find("#userId").validatebox("isValid");
	
	$.each(table.find("input").not(":hidden"), function(index, item) {
		//	alert(index);
			var v = item;
			var result = $(item).validatebox("isValid");
			if(result == false){
				alert("in return false");
				return false;
			}
		});

	alert("��֤���");//return;
	var data = new Object();
	data['user.userId'] = $("#userId").val();
//	return;
	data['user.userName'] = $("#userName").val();
	data['user.email'] = $("#email").val();
	data['user.password'] = $("#password").val();
	data['user.contactTel'] = $("#contactTel").val();
	data['user.belongAgentId'] = $("#belongAgentId").val();
	$.ajax({
		type:'POST',
		async:false,
		url:'../sys/UserAction!addUser.action',
		data:data,
		success:function(datas){
			alert("�����ɹ�");
			$("#dlg").dialog({
				closed: true,  
			})
			//���¼���datagrid
			$('#users').datagrid('reload');  
			table.find("input").each(function(){
				$(this).val('');
			})
		}
	})
}

function modifyUser(){
	var table = $("#mcontentTable");
	var con = true;
	$.each(table.find("input").not(":hidden"), function(index, item) {
		var v = item;
		var result = $(item).validatebox("isValid");
		if(result == false){
			//alert("in return false");
			con = false;
			}
		});
	if(!con){
		return;
	}
	alert("��֤���");
	var user = new Object();
	var table = $("#mcontentTable");
	user['user.userId'] = table.find("#userId").val();
	user['user.userName'] = table.find("#userName").val();
	user['user.contactTel'] = table.find("#contactTel").val();
	user['user.email'] = table.find("#email").val();
	user['user.belongAgentId'] = table.find("#belongAgentId").val();
	
	$.ajax({
		type:'POST',
		data:user,
		url:'<%=base%>sys/UserAction!modifyUser.action',
		success:function(data){
			alert("�����ɹ�!");
			$("#mdlg").dialog({
				closed: true,  
			})
			table.find("#userId").val('');
			table.find("#userName").val('');
			table.find("#contactTel").val('');
			table.find("#email").val('');
			table.find("#belongAgentId").val('');
			$('#users').datagrid('reload');  
			table.find("input").each(function(){
				$(this).val('');
			})
		}
	})
}

//ɾ���û�������ɾ�����
function deleteUser(){
	var datas = $("#users").datagrid("getSelections");
	var str = "";
	for(var v=0;v<datas.length;v++){
		if(typeof(datas[v].userId) =="undefined"){
			datas[v].userId = "";
		}
		
		str += 'users.userId='+datas[v].userId+'&';
	}
	str = str.substr(0,str.length-1);

	$.ajax({
		type:'POST',
		url:'<%=base%>sys/UserAction!deleteMultipleUser.action',
		data:str,
		success:function(datas){
			alert("ɾ���ɹ�!");
			$('#users').datagrid('reload');  
		}
	})
}


function popAgent(windowName){
	window.open ('agentTree.jsp',windowName,'height=500,width=600,top=100,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 
}
	
function addAgentCallback(treeNode){
	//alert("in chooseAgentCallback");
//	alert(JSON.stringify(treeNode));
	var dlg = $("#dlg");
	dlg.find("#belongAgentId").val(treeNode['agent_id']);	
	dlg.find("#agentName").val(treeNode['name']);
}
	
function modifyAgentCallback(treeNode){
	var mdlg = $("#mdlg");
	mdlg.find("#belongAgentId").val(treeNode['agent_id']);	
	mdlg.find("#agentName").val(treeNode['name']);
}

//Ϊ�ؼ����validate
function addValidateMessage(){
	var table = $("#contentTable");
	table.find("#userId").validatebox({
		required:true,
		validType:"length[3,10]",
		invalidMessage:"you are wrong"
	})
}
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
				<!-- ��datagrid -->
	<table id="users" style="width:800px" height="900px"></table>
	
	<!-- ��ӶԻ��� -->
	<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-buttons">
	<div style="margin:10px 0;"></div> 
		<div style="width:400px;padding:10px">
		<table id="contentTable">
			<tr><td>�û�����:</td><td><input  type="text" id="userId"
			 class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'" missingMessage="������3-10�ַ�" invalidMessage="������3-10�ַ�"/></td></tr>
			<tr><td>�ǳ�:</td><td><input type="text" class="easyui-validatebox" data-options="required:true" id="userName" missingMessage="�����Ϊ�գ�"></td></tr>
		<tr><td>����:</td><td><input type="password" class="easyui-validatebox" data-options="required:true,validType:'length[6,10]'" missingMessage="������6-10�ַ�" invalidMessage="������6-10�ַ�"   id="password"></td></tr>
			<tr><td>��ϵ�绰:</td><td><input type="text" id="contactTel" class="easyui-validatebox" data-options="required:true" missingMessage="�����Ϊ�գ�"></td></tr>
			<tr><td>�����ʼ�:</td><td><input type="text" id="email" class="easyui-validatebox" data-options="required:true,validType:'email'" missingMessage="�����Ϊ�գ�" invalidMessage="������Ϸ����ʼ���ַ��"></td></tr>
			<tr><td>����������:</td><td><input type="text" class="easyui-validatebox"  data-options="required:true" readonly="readonly" missingMessage="��ѡ�������" id="agentName" ondblclick="popAgent('add')"/>
										<input type="hidden" id="belongAgentId"></td></tr>
		</table>
		</div>
	</div>
	
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="addUser()">����</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">ȡ��</a>  
    </div>  
    
    
    	<!-- �޸ĶԻ��� -->
	<div id="mdlg" class="easyui-dialog" closed="true" buttons="#mdlg-buttons">
		<table id="mcontentTable">
			<tr><td>�û�����:</td><td><input type="text" id="userId"  class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'" missingMessage="������3-10�ַ�" invalidMessage="������3-10�ַ�" disabled="disabled"></td></tr>
			<tr><td>�ǳ�:</td><td><input type="text" class="easyui-validatebox" data-options="required:true" id="userName" missingMessage="�����Ϊ�գ�" id="userName"></td></tr>
			<tr><td>��ϵ�绰:</td><td><input type="text" class="easyui-validatebox" data-options="required:true" missingMessage="�����Ϊ�գ�" id="contactTel"></td></tr>
			<tr><td>�����ʼ�:</td><td><input type="text" class="easyui-validatebox" data-options="required:true,validType:'email'" missingMessage="�����Ϊ�գ�" invalidMessage="������Ϸ����ʼ���ַ��" id="email"></td></tr>
			<tr><td>����������:</td><td><input type="text" class="easyui-validatebox"  data-options="required:true" readonly="readonly" missingMessage="��ѡ�������" ondblclick="popAgent('modify')" id="agentName"/>
			<input type="hidden" id="belongAgentId"/></td></tr>
		</table>
	</div>
	 <div id="mdlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modifyUser()">����</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#mdlg').dialog('close')">ȡ��</a>  
    </div>
    
    <div id="agents">
    	<div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="chooseAgent()">ѡ��</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#agents').dialog('close')">ȡ��</a>  
    </div>  
    </div>
    
</body>
</html>
