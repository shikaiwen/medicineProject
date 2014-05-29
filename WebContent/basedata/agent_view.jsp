<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<link rel="stylesheet" href="<%=base%>cssfiles/drp.css">

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/self_location.css">

<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/default/easyui.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(function(){
		//为父节点赋值
		$("#pid").val(window.parent.frames['leftFrame'].pid);
		//获取分销商级别
		$.ajax({
			url:'<%=base%>/datadict/DictAction!getDictHtml.action?dict.category=A',
			success:function(datas){
				$("#agent_level").html(datas);
			}
		})
		
		//获取省
		$.ajax({
			url:'<%=base%>/datadict/DictAction!getAllProvince.action',
			success:function(datas){
				$("#provinceSelect").html(datas);
			}
		})
		
		//隐藏市和区
		$("#citySpan").hide();
		$("#areaSpan").hide();
		
		
		//这里应该刷新右边的树，因为添加，或者是修改后都会到这个页面
		window.parent.frames['leftFrame'].loadTree();
	})
	
	function addAgent(){
		if(!validate()) return;//验证合法性
		var form = $("#agentForm").get(0);
		form.submit();
		
	}
	
	function validate(){
		return true;
	}
	
	//改变省份事件
	function changeProvince(obj){
		var selectedOption = obj.options[obj.options.selectedIndex];
		var province_id = selectedOption.value;
		//将名字赋值给隐藏域
		$("#hiddenProvinceName").val(selectedOption.innerHTML);
		
		//获取市
		$.ajax({
			async:false,
			url:'<%=base%>/datadict/DictAction!getCityByProvince.action?areaDataModel.areaId='+province_id,
			success:function(datas){
				$("#citySelect").html(datas);
				$("#citySpan").show();
			}
		})
	}
	
	//城市改变事件
	function changeCity(obj){
		var selectedOption = obj.options[obj.options.selectedIndex];
		
		var city_id = selectedOption.value;
		//将名字赋值给隐藏域
		$("#hiddenCityName").val(selectedOption.innerHTML);
		//获取县
		$.ajax({
			async:false,
			url:'<%=base%>/datadict/DictAction!getAreaByCity.action?areaDataModel.areaId='+city_id,
			success:function(datas){
				$("#areaSelect").html(datas);
				$("#areaSpan").show();
			}
		})
	}
	//县区改变了
	function cityChange(obj){
		var selectedOption = obj.options[obj.options.selectedIndex];
		//将名字赋值给隐藏域
		$("#hiddenAreaName").val(selectedOption.innerHTML);
	}
</script>

<body>
<form action="<%=base%>basedata/AgentAction!addAgent.action" id="agentForm" method="post">
	<div>
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
							<b>基础数据管理&gt;&gt;<span id="operate_module">分销商查看</span></b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
	<div style="margin-right:auto;margin-left:auto;width:650px">
	<style>
		.table{
			border:1px solid black;
			width:500px;
			height:300px;
			border-spacing：0px;
			text-align:center;
		}
		.table td{
			border:1px solid black;
			padding:0px;
			border-spacing：0px;
		}
	</style>
		<table id="contentTable" class="table">
			<tr><td>名称:</td><td><span><s:property value="agent.agentName"/></span></td></tr>
			<tr><td>联系人:</td><td><span><s:property value="agent.contactMan"></s:property></span></td></tr>
			<tr><td>联系电话:</td><td><span><s:property value="agent.telephone"/></span></td></tr>
			<tr><td>固定电话:</td><td><span><s:property value="agent.fixedPhone"/></span></td></tr>
			<tr><td>电子邮件:</td><td><span><s:property value="agent.email"/></span></td></tr>
			<tr><td>分销商级别:</td><td><span><s:property value="agent_level"/></span></td></tr>
			<tr><td>地址:</td><td><span><s:property value="address"/></span></td></tr>
			<input type="hidden" name="agent.areaDataModel.provinceName" id="hiddenProvinceName"/>
			<input type="hidden" name="agent.areaDataModel.cityName" id="hiddenCityName"/>
			<input type="hidden" name="agent.areaDataModel.areaName" id="hiddenAreaName"/>
			<input type="hidden" name="agent.isAgent" value="Y"/>
			<input type="hidden" name="agent.pid" id="pid"/>
		</table>
    </div> 
	</div>
	</div>
</form>
    
</body>
</html>