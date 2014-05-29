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
				onRightClick:rightClick
			}
	};
	var d = eval(datas);
	$.fn.zTree.init($("#tree"), setting, d);
}

var currentNode;
function zTreeOnClick(event, treeId, treeNode){
	currentNode = treeNode;
//	alert(JSON.stringify(treeNode));//return;
    if("Y"==treeNode.is_agent){
    	var rightWindow = window.parent.frames[1].frameElement;
    	var str = '<%=base%>basedata/AgentAction!toViewAgent.action?agent.agentId='+currentNode.agent_id;
    	$(rightWindow).attr("src",str);
    }else{
    	var rightWindow = window.parent.frames[1].frameElement;
    	var str = '<%=base%>basedata/AgentAction!toViewRegion.action?agent.agentId='+currentNode.agent_id;
    	$(rightWindow).attr("src",str);
    }
}

var rightClickCurrentNode;
function rightClick(event,treeId,treeNode){
	rightClickCurrentNode = treeNode;
//	alert(JSON.stringify(treeNode));
	//����Ƿ����̣�����pid��ֵ��pid����������򽫱��ڵ��id����pid
	if("Y"==treeNode.is_agent){
		pid = treeNode.pid;
	}else{
		pid = treeNode.agent_id;
	}
	 $("#mm").css("width","90px");
	 $('#mm').menu('show', {  
        left: event.pageX,  
        top: event.pageY  
    });
}
//���Ҽ�ʱ��ֵ
var pid ;
function toAddAgent(){
//	alert(JSON.stringify("pid is :"+pid));
alert(pid);
	var str = '<%=base%>basedata/agent_add.jsp';
	var rightWindow = window.parent.frames[1].frameElement;
	$(rightWindow).attr("src",str);
}
//�������
function toAddRegion(){
	var str = '<%=base%>basedata/region_add.jsp';
	var rightWindow = window.parent.frames[1].frameElement;
	$(rightWindow).attr("src",str);
}
//�޸ķ����̻�������
function toModify(){
	if("Y"==rightClickCurrentNode.is_agent){
		var str = '<%=base%>basedata/AgentAction!modifyAgent.action?prepare=Y&agent.agentId='+rightClickCurrentNode.agent_id;
	}else{
		var str = '<%=base%>basedata/AgentAction!modifyRegion.action?prepare=Y&agent.agentId='+rightClickCurrentNode.agent_id;
	}
	var rightWindow = window.parent.frames[1].frameElement;
	$(rightWindow).attr("src",str);
	
}
function toDelete(){
	var agent_id = rightClickCurrentNode.agent_id;
	var result = false;
	if('Y'==rightClickCurrentNode.is_agent){
		top.$.messager.confirm('ȷ�Ͽ�', 'ȷ��Ҫɾ����?', function(r){
			if(r){
				delet(true,agent_id);
			}
					
		});
	}else{
		top.$.messager.confirm('ȷ�Ͽ�', '�ýڵ�������ڵ㣬���ɾ�����ӽڵ�Ҳ��ȫ��ɾ��,ȷ��ɾ����?', function(r){
			if(r){
				delet(true,agent_id);	
			}
		});
	}
}

function delet(result,agent_id){
	if(result){
		$.ajax({
			url:'<%=base%>basedata/AgentAction!deleteAgent.action?agent.agentId='+agent_id,
			type:'POST',
			success:function(){
				alert("ɾ���ɹ�!");
				loadTree();
			}
		})
	}
}


</script>
    <div id="mm" class="easyui-menu" style="width:60px;">  
    	<div onclick="javascript:toAddAgent()" style="width:90px;" id="addDiv">����������</div>
    	<div onclick="javascript:toAddRegion()" style="width:90px;" id="addDiv">��������</div>    
    	<div onclick="javascript:toModify()" style="width:90px;">�޸�</div>  
        <div onclick="javascript:toDelete()" style="width:90px;">ɾ��</div>  
    </div>  
<ul id="tree" class="ztree"></ul>
</body>
</html>