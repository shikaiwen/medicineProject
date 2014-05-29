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
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=base%>cssfiles/self_location.css">

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
				//将值设置好
				//alert($("#agent_level").val());
				$("#agent_level").val($("#hiddenAgentLevel").val());
			}
		})
		
		//获取省
		$.ajax({
			url:'<%=base%>/datadict/DictAction!getAllProvince.action',
			success:function(datas){
				$("#provinceSelect").html(datas);
				//赋值
				$("#provinceSelect").val($("#hiddenProvinceId").val());
			}
		})
		
		//隐藏市和区
		$("#citySpan").hide();
		$("#areaSpan").hide();
		
	})
	
	function modifyAgent(){
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
	
	
	
	$(function(){
		initialData();
	})
	//初始化加载后数据
	function initialData(){
		var province_id = $("#hiddenProvinceId").val();
		if(province_id !=''){
			$("#provinceSelect").val($("#hiddenProvinceId").val());
		}
		if($("#hiddenCityId").val()!=''){
			//获取市
			$.ajax({
				async:false,
				url:'<%=base%>/datadict/DictAction!getCityByProvince.action?areaDataModel.areaId='+province_id,
				success:function(datas){
					$("#citySelect").html(datas);
					$("#citySpan").show();
					//将值设置好
					$("#citySelect").val($("#hiddenCityId").val());
				}
			})
		}
//		alert("city_id:"+$("#hiddenCityId").val());
		var city_id = $("#hiddenCityId").val();
		if(city_id!=''){
			//获取县
			$.ajax({
				async:false,
				url:'<%=base%>datadict/DictAction!getAreaByCity.action?areaDataModel.areaId='+city_id,
				success:function(datas){
				//	alert(datas);
					$("#areaSelect").html(datas);
					$("#areaSpan").show();
					$("#areaSelect").val($("#hiddenAreaId").val());
				}
			})
		}
		

	}
</script>

<body>
<form action="<%=base%>basedata/AgentAction!modifyAgent.action" id="agentForm" method="post">
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
							<b>基础数据管理&gt;&gt;<span id="operate_module">分销商修改</span></b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
	<div style="margin-right:auto;margin-left:auto;width:650px">
		<table id="contentTable">
			<input type="hidden" name="agent.agentId" value='<s:property value="agent.agentId"/>'/>
			<tr><td>名称:</td><td><input type="text" name="agent.agentName" id="agentName" class="easyui-validatebox" data-options="required:true" missingMessage="分销商名称不能为空" value='<s:property value="agent.agentName"/>'> </td></tr>
			<tr><td>联系人:</td><td><input type="text" name="agent.contactMan" id="contactMan" class="easyui-validatebox" data-options="required:true" missingMessage="联系人不能为空" value='<s:property value="agent.contactMan"/>'></td></tr>
			<tr><td>联系电话:</td><td><input type="text" name="agent.telephone" id="telephone" value='<s:property value="agent.telephone"/>'></td></tr>
			<tr><td>固定电话:</td><td><input type="text" name="agent.fixedPhone" id="fixedPhone" value='<s:property value="agent.fixedPhone"/>'></td></tr>
			<tr><td>电子邮件:</td><td><input type="text" name="agent.email" class="easyui-validatebox" data-options="required:true,validType:'email'" missingMessage="该项不能为空！" invalidMessage="请输入合法的邮件地址！" id="email" value='<s:property value="agent.email"/>'></td></tr>
			<tr><td>分销商级别:</td><td><select type="text" name="agent.agentLevel" id="agent_level"></select></td></tr>
			<input type="hidden" id="hiddenAgentLevel" value='<s:property value="agent.agentLevel"/>'/>
			<input type="hidden" id="hiddenProvinceId" value='<s:property value="agent.areaDataModel.provinceId"/>'/>
			<input type="hidden" id="hiddenCityId" value='<s:property value="agent.areaDataModel.CityId"/>'/>
			<input type="hidden" id="hiddenAreaId" value='<s:property value="agent.areaDataModel.AreaId"/>'/>
			<tr><td>地址:</td>
			<td><span>省份:<select name="agent.areaDataModel.provinceId" id="provinceSelect" onchange="changeProvince(this)"></select></span>
			<span id="citySpan">市:<select name="agent.areaDataModel.cityId" id="citySelect" onchange="changeCity(this)"></select></span>
			<span id="areaSpan">县(区):<select name="agent.areaDataModel.areaId" id="areaSelect" onchange="cityChange(this)"></select></span>
			</td></tr>
			<tr><td>详细地址：</td><td><input type="text" name="agent.detailedAddress" value='<s:property value="agent.detailedAddress"/>' id="detailedAddress"></td></tr>
			<input type="hidden" name="agent.areaDataModel.provinceName" id="hiddenProvinceName"/>
			<input type="hidden" name="agent.areaDataModel.cityName" id="hiddenCityName"/>
			<input type="hidden" name="agent.areaDataModel.areaName" id="hiddenAreaName"/>
			<input type="hidden" name="agent.isAgent" value="Y"/>
			<input type="hidden" name="agent.pid" id="pid"/>
		</table>
		
		<div id="oper_button" style="margin-left:20px;margin-top:20px">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modifyAgent()">保存</a>&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>  
    </div> 
	</div>
	</div>
</form>
    
</body>
</html>