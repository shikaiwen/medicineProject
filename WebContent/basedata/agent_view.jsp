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
		//Ϊ���ڵ㸳ֵ
		$("#pid").val(window.parent.frames['leftFrame'].pid);
		//��ȡ�����̼���
		$.ajax({
			url:'<%=base%>/datadict/DictAction!getDictHtml.action?dict.category=A',
			success:function(datas){
				$("#agent_level").html(datas);
			}
		})
		
		//��ȡʡ
		$.ajax({
			url:'<%=base%>/datadict/DictAction!getAllProvince.action',
			success:function(datas){
				$("#provinceSelect").html(datas);
			}
		})
		
		//�����к���
		$("#citySpan").hide();
		$("#areaSpan").hide();
		
		
		//����Ӧ��ˢ���ұߵ�������Ϊ��ӣ��������޸ĺ󶼻ᵽ���ҳ��
		window.parent.frames['leftFrame'].loadTree();
	})
	
	function addAgent(){
		if(!validate()) return;//��֤�Ϸ���
		var form = $("#agentForm").get(0);
		form.submit();
		
	}
	
	function validate(){
		return true;
	}
	
	//�ı�ʡ���¼�
	function changeProvince(obj){
		var selectedOption = obj.options[obj.options.selectedIndex];
		var province_id = selectedOption.value;
		//�����ָ�ֵ��������
		$("#hiddenProvinceName").val(selectedOption.innerHTML);
		
		//��ȡ��
		$.ajax({
			async:false,
			url:'<%=base%>/datadict/DictAction!getCityByProvince.action?areaDataModel.areaId='+province_id,
			success:function(datas){
				$("#citySelect").html(datas);
				$("#citySpan").show();
			}
		})
	}
	
	//���иı��¼�
	function changeCity(obj){
		var selectedOption = obj.options[obj.options.selectedIndex];
		
		var city_id = selectedOption.value;
		//�����ָ�ֵ��������
		$("#hiddenCityName").val(selectedOption.innerHTML);
		//��ȡ��
		$.ajax({
			async:false,
			url:'<%=base%>/datadict/DictAction!getAreaByCity.action?areaDataModel.areaId='+city_id,
			success:function(datas){
				$("#areaSelect").html(datas);
				$("#areaSpan").show();
			}
		})
	}
	//�����ı���
	function cityChange(obj){
		var selectedOption = obj.options[obj.options.selectedIndex];
		//�����ָ�ֵ��������
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
							<b>�������ݹ���&gt;&gt;<span id="operate_module">�����̲鿴</span></b>
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
			border-spacing��0px;
			text-align:center;
		}
		.table td{
			border:1px solid black;
			padding:0px;
			border-spacing��0px;
		}
	</style>
		<table id="contentTable" class="table">
			<tr><td>����:</td><td><span><s:property value="agent.agentName"/></span></td></tr>
			<tr><td>��ϵ��:</td><td><span><s:property value="agent.contactMan"></s:property></span></td></tr>
			<tr><td>��ϵ�绰:</td><td><span><s:property value="agent.telephone"/></span></td></tr>
			<tr><td>�̶��绰:</td><td><span><s:property value="agent.fixedPhone"/></span></td></tr>
			<tr><td>�����ʼ�:</td><td><span><s:property value="agent.email"/></span></td></tr>
			<tr><td>�����̼���:</td><td><span><s:property value="agent_level"/></span></td></tr>
			<tr><td>��ַ:</td><td><span><s:property value="address"/></span></td></tr>
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