<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
</head>
<body>
<link rel="stylesheet" href="<%=base%>cssfiles/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="<%=base%>cssfiles/default/easyui.css">
<link rel="stylesheet" href="<%=base%>cssfiles/icon.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript">
$(function(){
	loadTree();
})

	function loadTree() {
	$.ajax({
			type : 'POST',
			url : '<%=base%>basedata/AgentAction!getTree.action',
			success:getTreeCallback
	})
}

function getTreeCallback(datas){
	var setting = {	
			callback: {
				onClick: zTreeOnClick,
				//onRightClick:rightClick
			}
	};
	var d = eval(datas);
	$.fn.zTree.init($("#tree"), setting, d);
}


var currentNode;
function zTreeOnClick(event, treeId, treeNode){
	currentNode = treeNode;
/* 	var w = window.opener;
	w.chooseAgentCallback(treeNode);
	w.close(); */
}

function chooseAgent(){
	if(!currentNode){
		alert("请选择分销商");return;
	}
	var w = window.opener;
	if(window.name=='add'){
		w.addAgentCallback(currentNode);
	}else if(window.name=='modify'){
		w.modifyAgentCallback(currentNode);
	}
	
	window.close();
}


</script>
 
<div id="contentDiv" style="text-align:center">
<ul id="tree" class="ztree"></ul>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="chooseAgent()">选择</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="window.close()">取消</a> 
</div>
</body>
</html>