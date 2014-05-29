	<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
	<meta charset="GBK">
	<title>Full Layout </title>
	<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/layout.css">

	<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>

	<script>
	$(function(){
		$(".t").click(function(){
			var href = $(this).attr("src");
			var title = $(this).text();
			addTab(title,href);
		})

	})
	
	function addTab(title,url){
		if($("#tabs").tabs('exists',title)){
			$("#tabs").tabs('select',title)//ѡ�в�ˢ��
			var currTab = $("#tabs").tabs("getSelected");
			var url = $(currTab.panel('options').content).attr("src");//������iframe��src
			if(url != undefined ){
				$("#tabs").tabs('update',{
					tab:currTab,
					options:{content:createFrame(url)}
				})
			}
		}else{
			var content = createFrame(url);
			$("#tabs").tabs('add',{
				title:title,
				content:content,
				closable:true
			})
		}
	}
	
	function createFrame(url){
		var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		return s;
	}
	
	function logout(){
		
	}
	</script>
	<style>
		.banner{
			background-image:url('<%=base%>images/newadd/banner.jpg');
			background-repeat:no-repeat;
		}
		.logobottom{
			float:right;
			font-size:15px;
			margin-right:50px;
			margin-top:60px;
		}
		.a{
			text-decoration:none;
		}
	</style>
<body class="easyui-layout" style="text-align:center">

    <div data-options="region:'north',split:false" class="banner" style="height:105px;">
    <div class="logobottom">
   <span>��ǰ�û�:${sessionScope.USER.userName}</span>&nbsp;&nbsp;&nbsp;
   <span><a class="a" href="<%=base%>sys/login!logOut.action" onclick="logout()">ע��</a></span>
   </div>
	</div>  
    <div data-options="region:'south',title:'',split:true" style="height:40px;"></div>  
	<div data-options="region:'west',split:true" style="width:150px;height:100px">
			<div title="��������" data-options="selected:true">  
				<p><a href="javascript:void(0);" src="<%=base%>ordermgr/order_add.jsp" class="t">�������</a></p>
				<p><a href="javascript:void(0);" src="<%=base%>ordermgr/order_main.jsp" class="t">����ά��</a></p>
			</div> 
			<div title="ϵͳ����" data-options="">  
				<p><a href="javascript:void(0);" src="<%=base%>sysmgr/password_modify.jsp" class="t">�޸�����</a></p>
			</div>  
	</div>  	
	</div>  
    <div data-options="region:'center'" style="padding:5px;background:#eee;">

	<!--һ����tab����-->
		
		 <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
                <div title="Home">
				����centerҳ��
				</div>
      
		</div>
	</div>
	
	<script>
	function test(){
		var url="http://localhost:8080/medicineManage/ordermgr/order_modify.jsp";
		var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$("#tabs").tabs("add",{
			title:'baidu',
			content:s,
			closable:true
		})
	}
	</script>
</body>