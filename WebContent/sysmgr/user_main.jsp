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
<title>用户管理</title>
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/demo.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/icon.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.validatebox.js"></script>

<script type="text/javascript">



$(function(){
	$('#users').datagrid({
		title:'用户列表',
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
		loadMsg:'数据加载中...',
		frozenColumns:[[
            {field:'ck',checkbox:true},
           //{title:'Code',field:'code',width:80,sortable:true} 
		]],
		columns:[
		
		[
			{field:'userId',title:'用户代码',width:120},
			{field:'userName',title:'用户名称',width:220,rowspan:2,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
			{field:'contactTel',title:'联系电话',width:150,rowspan:2},
			{field:'email',title:'电子邮件',width:150,rowspan:2},
			{field:'agent.agentName',title:'所属分销商',width:150,rowspan:2,formatter:function(v,r,i){
				try{
					return formatColumn('agent.agentName',v,r,i);
				}catch(e){return "";}
				
			}},
			{field:'createDate',title:'创建时间',width:150,rowspan:2},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'添加用户',
			iconCls:'icon-add',
			handler:showAddUserDialog
		},{
			id:'btnedit',
			text:'修改',
			iconCls:'icon-edit',
			handler:showModifyUserDialog//function(){
			//	$('#btnsave').linkbutton('enable');
			//	alert('cut')
			//}
		},{
			id:'btndelete',
			text:'删除',
			iconCls:'icon-remove',
			handler:deleteUser
		}]
	});
	var p = $('#users').datagrid('getPager');
	$(p).pagination({
		pageSize:10,
		pageList:[5,10,15,20],
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

//显示添加框
function showAddUserDialog(){
	$("#contentTable").css("margin-left","auto");
	$("#contentTable").css("margin-right","auto");
	$("#contentTable").css("margin-top","20px");
	$("#dlg").dialog({
	    title: '添加用户',  
		width: 600,  
		height: 400,  
		closed: false,  
		cache: false,  
		modal: true
	})
}

//显示修改框
function showModifyUserDialog(){
	var datas = $("#users").datagrid("getSelections");
	if(datas.length != 1){
		alert("请选择一条数据");
		return;
	}

//	return;
	$("#mcontentTable").css("margin-left","auto");
	$("#mcontentTable").css("margin-right","auto");
	$("#mcontentTable").css("margin-top","20px");
	$("#mdlg").dialog({
	    title: '修改用户',  
		width: 600,  
		height: 400,  
		closed: false,  
		cache: false,  
		modal: true
	})
	//为表格赋值
	var table = $("#mcontentTable");
	table.find("#userId").val("123");
	for(var key in datas[0]){
		table.find("#"+key).val(datas[0][key]);
	}
	table.find("#agentName").val(datas[0]['agent']['agentName']);
	table.find("#belongAgentId").val(datas[0]['agent']['agentId']);
}

//添加用户
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

	alert("验证完成");//return;
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
			alert("操作成功");
			$("#dlg").dialog({
				closed: true,  
			})
			//重新加载datagrid
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
	alert("验证完成");
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
			alert("操作成功!");
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

//删除用户，可以删除多个
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
			alert("删除成功!");
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

//为控件添加validate
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
							<b>系统管理&gt;&gt;用户维护</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				</div>
				<!-- 主datagrid -->
	<table id="users" style="width:800px" height="900px"></table>
	
	<!-- 添加对话框 -->
	<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-buttons">
	<div style="margin:10px 0;"></div> 
		<div style="width:400px;padding:10px">
		<table id="contentTable">
			<tr><td>用户代码:</td><td><input  type="text" id="userId"
			 class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'" missingMessage="请输入3-10字符" invalidMessage="请输入3-10字符"/></td></tr>
			<tr><td>昵称:</td><td><input type="text" class="easyui-validatebox" data-options="required:true" id="userName" missingMessage="该项不能为空！"></td></tr>
		<tr><td>密码:</td><td><input type="password" class="easyui-validatebox" data-options="required:true,validType:'length[6,10]'" missingMessage="请输入6-10字符" invalidMessage="请输入6-10字符"   id="password"></td></tr>
			<tr><td>联系电话:</td><td><input type="text" id="contactTel" class="easyui-validatebox" data-options="required:true" missingMessage="该项不能为空！"></td></tr>
			<tr><td>电子邮件:</td><td><input type="text" id="email" class="easyui-validatebox" data-options="required:true,validType:'email'" missingMessage="该项不能为空！" invalidMessage="请输入合法的邮件地址！"></td></tr>
			<tr><td>所属分销商:</td><td><input type="text" class="easyui-validatebox"  data-options="required:true" readonly="readonly" missingMessage="请选择分销商" id="agentName" ondblclick="popAgent('add')"/>
										<input type="hidden" id="belongAgentId"></td></tr>
		</table>
		</div>
	</div>
	
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="addUser()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>  
    </div>  
    
    
    	<!-- 修改对话框 -->
	<div id="mdlg" class="easyui-dialog" closed="true" buttons="#mdlg-buttons">
		<table id="mcontentTable">
			<tr><td>用户代码:</td><td><input type="text" id="userId"  class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'" missingMessage="请输入3-10字符" invalidMessage="请输入3-10字符" disabled="disabled"></td></tr>
			<tr><td>昵称:</td><td><input type="text" class="easyui-validatebox" data-options="required:true" id="userName" missingMessage="该项不能为空！" id="userName"></td></tr>
			<tr><td>联系电话:</td><td><input type="text" class="easyui-validatebox" data-options="required:true" missingMessage="该项不能为空！" id="contactTel"></td></tr>
			<tr><td>电子邮件:</td><td><input type="text" class="easyui-validatebox" data-options="required:true,validType:'email'" missingMessage="该项不能为空！" invalidMessage="请输入合法的邮件地址！" id="email"></td></tr>
			<tr><td>所属分销商:</td><td><input type="text" class="easyui-validatebox"  data-options="required:true" readonly="readonly" missingMessage="请选择分销商" ondblclick="popAgent('modify')" id="agentName"/>
			<input type="hidden" id="belongAgentId"/></td></tr>
		</table>
	</div>
	 <div id="mdlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modifyUser()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#mdlg').dialog('close')">取消</a>  
    </div>
    
    <div id="agents">
    	<div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="chooseAgent()">选择</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#agents').dialog('close')">取消</a>  
    </div>  
    </div>
    
</body>
</html>
