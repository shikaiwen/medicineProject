<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Basic Dialog - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="../cssfiles/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../cssfiles/icon.css">

	<script type="text/javascript" src="../jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="../jsfiles/jquery.easyui.min.js"></script>
	
	<script>
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

	</script>
</head>
<body>
	<div style="margin:10px 0;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="show()">Open</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('close')">Close</a>
	</div>
	
	
	<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-buttons">
		The dialog content.
	</div>
	 <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">save</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">cancel</a>  
    </div>  
</body>
</html>