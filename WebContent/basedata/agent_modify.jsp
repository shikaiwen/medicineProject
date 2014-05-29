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
		//Ϊ���ڵ㸳ֵ
		$("#pid").val(window.parent.frames['leftFrame'].pid);
		//��ȡ�����̼���
		$.ajax({
			url:'<%=base%>/datadict/DictAction!getDictHtml.action?dict.category=A',
			success:function(datas){
				$("#agent_level").html(datas);
				//��ֵ���ú�
				//alert($("#agent_level").val());
				$("#agent_level").val($("#hiddenAgentLevel").val());
			}
		})
		
		//��ȡʡ
		$.ajax({
			url:'<%=base%>/datadict/DictAction!getAllProvince.action',
			success:function(datas){
				$("#provinceSelect").html(datas);
				//��ֵ
				$("#provinceSelect").val($("#hiddenProvinceId").val());
			}
		})
		
		//�����к���
		$("#citySpan").hide();
		$("#areaSpan").hide();
		
	})
	
	function modifyAgent(){
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
	
	
	
	$(function(){
		initialData();
	})
	//��ʼ�����غ�����
	function initialData(){
		var province_id = $("#hiddenProvinceId").val();
		if(province_id !=''){
			$("#provinceSelect").val($("#hiddenProvinceId").val());
		}
		if($("#hiddenCityId").val()!=''){
			//��ȡ��
			$.ajax({
				async:false,
				url:'<%=base%>/datadict/DictAction!getCityByProvince.action?areaDataModel.areaId='+province_id,
				success:function(datas){
					$("#citySelect").html(datas);
					$("#citySpan").show();
					//��ֵ���ú�
					$("#citySelect").val($("#hiddenCityId").val());
				}
			})
		}
//		alert("city_id:"+$("#hiddenCityId").val());
		var city_id = $("#hiddenCityId").val();
		if(city_id!=''){
			//��ȡ��
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
							<b>�������ݹ���&gt;&gt;<span id="operate_module">�������޸�</span></b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
	<div style="margin-right:auto;margin-left:auto;width:650px">
		<table id="contentTable">
			<input type="hidden" name="agent.agentId" value='<s:property value="agent.agentId"/>'/>
			<tr><td>����:</td><td><input type="text" name="agent.agentName" id="agentName" class="easyui-validatebox" data-options="required:true" missingMessage="���������Ʋ���Ϊ��" value='<s:property value="agent.agentName"/>'> </td></tr>
			<tr><td>��ϵ��:</td><td><input type="text" name="agent.contactMan" id="contactMan" class="easyui-validatebox" data-options="required:true" missingMessage="��ϵ�˲���Ϊ��" value='<s:property value="agent.contactMan"/>'></td></tr>
			<tr><td>��ϵ�绰:</td><td><input type="text" name="agent.telephone" id="telephone" value='<s:property value="agent.telephone"/>'></td></tr>
			<tr><td>�̶��绰:</td><td><input type="text" name="agent.fixedPhone" id="fixedPhone" value='<s:property value="agent.fixedPhone"/>'></td></tr>
			<tr><td>�����ʼ�:</td><td><input type="text" name="agent.email" class="easyui-validatebox" data-options="required:true,validType:'email'" missingMessage="�����Ϊ�գ�" invalidMessage="������Ϸ����ʼ���ַ��" id="email" value='<s:property value="agent.email"/>'></td></tr>
			<tr><td>�����̼���:</td><td><select type="text" name="agent.agentLevel" id="agent_level"></select></td></tr>
			<input type="hidden" id="hiddenAgentLevel" value='<s:property value="agent.agentLevel"/>'/>
			<input type="hidden" id="hiddenProvinceId" value='<s:property value="agent.areaDataModel.provinceId"/>'/>
			<input type="hidden" id="hiddenCityId" value='<s:property value="agent.areaDataModel.CityId"/>'/>
			<input type="hidden" id="hiddenAreaId" value='<s:property value="agent.areaDataModel.AreaId"/>'/>
			<tr><td>��ַ:</td>
			<td><span>ʡ��:<select name="agent.areaDataModel.provinceId" id="provinceSelect" onchange="changeProvince(this)"></select></span>
			<span id="citySpan">��:<select name="agent.areaDataModel.cityId" id="citySelect" onchange="changeCity(this)"></select></span>
			<span id="areaSpan">��(��):<select name="agent.areaDataModel.areaId" id="areaSelect" onchange="cityChange(this)"></select></span>
			</td></tr>
			<tr><td>��ϸ��ַ��</td><td><input type="text" name="agent.detailedAddress" value='<s:property value="agent.detailedAddress"/>' id="detailedAddress"></td></tr>
			<input type="hidden" name="agent.areaDataModel.provinceName" id="hiddenProvinceName"/>
			<input type="hidden" name="agent.areaDataModel.cityName" id="hiddenCityName"/>
			<input type="hidden" name="agent.areaDataModel.areaName" id="hiddenAreaName"/>
			<input type="hidden" name="agent.isAgent" value="Y"/>
			<input type="hidden" name="agent.pid" id="pid"/>
		</table>
		
		<div id="oper_button" style="margin-left:20px;margin-top:20px">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modifyAgent()">����</a>&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">ȡ��</a>  
    </div> 
	</div>
	</div>
</form>
    
</body>
</html>