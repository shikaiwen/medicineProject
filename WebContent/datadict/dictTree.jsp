<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<link rel="stylesheet" href="<%=base%>cssfiles/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="<%=base%>cssfiles/default/easyui.css">
<link rel="stylesheet" href="<%=base%>cssfiles/icon.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
</head>

<script type="text/javascript">
	$(function(){
		loadTree();
	})
	
	function loadTree(){
		$.ajax({
			type:'POST',
			url:'<%=base%>datadict/DictAction!getTree',
			success:getTreeCallback
		})
	}
	
	function getTreeCallback(datas){
//	alert(datas.length);
		//var zNodes = $.parseJSON(datas);
	//	datas = $.parseJSON(datas);
//	alert(datas)
		datas = eval(datas);
		var setting = {	
				callback: {
					onClick: zTreeOnClick,
					onRightClick:rightClick
				}
		};
		$.fn.zTree.init($("#tree"), setting, datas);

	}
	
	function zTreeOnClick(event, treeId, treeNode) {
		var rightWindow = window.parent.frames['rightFrame'];
		rightWindow.show(treeNode);
	 
	};


	function rightClick(event,treeId,treeNode){
		rightClickNode = treeNode;
		 $("#mm").css("width","90px");
		 $('#mm').menu('show', {  
            left: event.pageX,  
            top: event.pageY  
        });
	}
	
	
	var rightClickNode ;
	//删除节点
	function toDelete(){
	top.$.messager.confirm('确认框', '确定要删除吗?', function(r){
		if (r){
			var data = new Object();
			data['dict.dictId'] = rightClickNode.id;
			$.ajax({
				type:'post',
				url:'datadict/DictAction!deleteMainDict.action',
				data:data,
				success:function(datas){
					//删除成功,刷新整棵树
					loadTree();
				}
			})
		}
	});

	}
	

	
	
</script>
<body>
    <div id="mm" class="easyui-menu" style="width:60px;">  
        <div onclick="javascript:toDelete()" style="width:90px;">删除</div>  
    </div>  
<ul id="tree" class="ztree"></ul>
</body>
</html>