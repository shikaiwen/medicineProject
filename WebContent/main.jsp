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
			$("#tabs").tabs('select',title)//选中并刷新
			var currTab = $("#tabs").tabs("getSelected");
			var url = $(currTab.panel('options').content).attr("src");//这里获得iframe的src
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
<body class="easyui-layout" >

    <div data-options="region:'north',split:false" class="banner" style="height:105px;">
    <div class="logobottom">
   <span>当前用户:${sessionScope.USER.userName}</span>&nbsp;&nbsp;&nbsp;
   <span><a class="a" href="<%=base%>sys/login!logOut.action" onclick="logout()">注销</a></span>
   </div>
   <!--  <input type="button" onclick="test()" value="aaaaaaaaaaaaaaa"/> -->
	</div>  
    <div data-options="region:'south',title:'',split:true" style="height:40px;"></div>  
	<div data-options="region:'west',split:true" style="width:150px;height:100px">
		<div id="aa"   class="easyui-accordion" fit="true" style="width:300px;height:200px;">  
			<div title="流向单" data-options="iconCls:'icon-save'" style="overflow:auto;padding:10px;'">  
				<p><a href="javascript:void(0);" src="<%=base%>flow_card/flow_card_add.jsp" class="t">添加流向单</a></p>
				<p><a href="javascript:void(0);" src="<%=base%>flow_card/flow_card_main.jsp" class="t">流向单查询</a></p>
			</div>  
			<div title="订单管理" data-options="selected:true">  
				<p><a href="javascript:void(0);" src="<%=base%>ordermgr/order_add.jsp" class="t">订单添加</a></p>
				<p><a href="javascript:void(0);" src="<%=base%>ordermgr/order_main.jsp" class="t">订单维护</a></p>
			</div> 
			<div title="基础数据管理" data-options="" style="padding:10px;">  
				  <p><a href="javascript:void(0);" src="<%=base%>basedata/medicine_main.jsp" class="t">药品管理</a></p>
				  <p><a href="javascript:void(0);" src="<%=base%>basedata/agentMain.jsp" class="t">分销商维护</a></p>
			</div>  
			<div title="库存管理" data-options="" style="padding:10px;">  
				  <p><a href="javascript:void(0);" src="<%=base%>storage/store_main.jsp" class="t">药品入库</a></p>
				  <p><a href="javascript:void(0);" src="<%=base%>storage/store_info.jsp" class="t">入库情况查询</a></p>
			</div>
			<div title="报表管理" data-options="">  
				<p><a href="javascript:void(0);" src="<%=base%>report/medicineSale.jsp" class="t">药品销售情况</a></p>
				<p><a href="javascript:void(0);" src="<%=base%>report/medicineSaleYearSum.jsp" class="t">年度销售报告</a></p> 
			</div>  
			<div title="系统管理" data-options="">  
				<p><a href="javascript:void(0);" src="<%=base%>sysmgr/user_main.jsp" class="t">用户维护</a></p>
			<!-- 	<p><a href="javascript:void(0);" src="<%=base%>sysmgr/user_main2.jsp" class="t">用户维护2</a></p> -->
				<p><a href="javascript:void(0);" src="<%=base%>datadict/main.jsp" class="t">类别参数维护</a></p>
				<p><a href="javascript:void(0);" src="<%=base%>sysmgr/password_modify.jsp" class="t">修改密码</a></p>
			</div>  
		</div>  	
	</div>  
    <div data-options="region:'center'" style="padding:5px;background:#eee;">

	<!--一下是tab内容-->
		
		 <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
                <div title="Home">
				这是center页面
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