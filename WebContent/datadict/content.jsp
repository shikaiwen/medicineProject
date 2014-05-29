	<%@ page language="java" contentType="text/html; charset=GBK"
	    pageEncoding="GBK"%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
	%>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>Insert title here</title>
	<link rel="stylesheet" href="<%=basePath%>cssfiles/drp.css">
	
	<link rel="stylesheet" type="text/css" href="<%=basePath%>cssfiles/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>cssfiles/default/easyui.css">
	<script type="text/javascript" src="<%=basePath%>jsfiles/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>jsfiles/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="<%=basePath%>jsfiles/datagrid-detailview.js"></script>
	</head>
	<script type="text/javascript">
		
	var currentNode;
	
	function show (node){
		currentNode = node;
		//ɾ��֮ǰ������
		$("#dictList").find("table tr").not(":first").remove();
		
		if('Y'==currentNode.isValueDict){
			var input = $("<input type='text'></input>");input.attr("id","dictValue");
			input.appendTo($("#optionSpan"));
		}else{
		//	alert(" in else");
		//	$("#optionSpan #valueSpan").html('');
			$("#optionSpan").children().remove();
		}
		
		
		$("#dlg").dialog({
	    title: '���������',  
		width: 800,  
		height: 350,  
		closed: false,  
		cache: false,  
		toolbar:[{
			text:'���',
			iconCls:'icon-add',
			handler:function(){addSubDict()}
			},
			{
			text:'�޸�',
			iconCls:'icon-edit',
			handler:function(){modifySubDict()}
			},
			{
			text:'ɾ��',
			iconCls:'icon-remove',
			handler:function(){deleteSubDict()}
			}
		
		],
	//	href: 'add.html',  
		modal: true
	})
		//��������

		var data = new Object();
		data['dict.category'] = node.category;
		$.ajax({
			type:'POST',
			url:'datadict/DictAction!getDictByType.action',
			data:data,
			success:function(datas){
			//	alert(JSON.stringify(datas));
			//	alert(JSON.stringify($.parseJSON(datas)));
				initialCategoryTable($.parseJSON(datas));
			}
		})
	}
	
		function initialCategoryTable(dicts){
			
			//Ϊȫѡ��ť���¼�
			$("input[name='flag']").first().bind("click",checkAll);
		//	alert(JSON.stringify(currentNode));
			var table = $("#dictList").find("table");
			
			if(currentNode.isValueDict=='Y'){
				table.find("tr:first").append($("<tr></tr>").html('�ֵ�ֵ'));
			}
			
			for(var v = 0;v<dicts.length;v++){
			//	alert(JSON.stringify(dicts));
				var tr = $("<tr></tr>");
				$("<td></td>").appendTo(tr);
				$("<td>"+dicts[v].dictId+"</td>").appendTo(tr);
				$("<td>"+dicts[v].dictName+"</td>").appendTo(tr);
				$("<td>"+currentNode.name+"</td>").appendTo(tr);
				if(currentNode.isValueDict=='Y'){
					$("<td></td>").html(dicts[v].value).appendTo(tr);
				}
				
				tr.appendTo(table);
			}
			
			//���checkbox
			table.find("tr").not(":first").each(function(){
				var checkBox = $("<input type='checkbox' name='flag'/>");
				$(this).find("td:first").append(checkBox);
			})
			
			//��ʾ���
			$("#dictList").show('slow');
		}
	
		
		function checkAll(){
			//�������δ�ӡ��������false���������ʵ����ȷ�ģ���chrome�»����������������Ϊ����
			var result = $(this).is(":checked");
			if(result){
				$("input[name='flag']").each(function(){
					$(this).attr("checked",true);
				})
			}else{
				$("input[name='flag']").each(function(){
					$(this).attr("checked",false);
				})
			}
		}
		//����ֵ�
		function addDict(){
			
			var data = new Object();
			data['dict.dictName'] = $("#dictName").val();
			data['dict.pid'] = 100;
			data['dict.is_leaf']='Y';
			data['dict.is_main'] = 'Y';
  			if($("#isValueDict").attr("checked")=='checked'){
  				data['dict.isValueDict']='Y';
  			}
			//alert(JSON.stringify(data));
			$.ajax({
				type:'POST',
				url:'datadict/DictAction!addDict.action',
				data:data,
				success:function(data){
					//ˢ����ߵ���
					alert("��ӳɹ�");
					//����ı�����Ϣ
					$("#dictName").val('');
					$("#isValueDict").attr("checked",false);
					window.parent.frames['leftFrame'].loadTree();
				}
			})
		}
		
		//���������
		function addSubDict(){
			//��ʾ��ӿ�
			
			$("#addSubDictDiv").show('slow');

			
			$("#addSubDictDiv").find("input[type='button']").attr("id","addSub");
			$("#addSub").attr("value","���");
			//�������ֵ�ֵ�
			if(currentNode.isValueDict== 'Y'){
				$("#subOption").css("display","inline");
				$("#subOption").show('slow');
			}
			$("#addSub").bind("click",function(){
				var data = new Object();
				data['dict.dictName'] = $("#subDictName").val();
				data['dict.pid'] = currentNode.id;
				data['dict.category'] = currentNode.category;
				//�������ֵ�ֵ�����
				if('Y'== currentNode.isValueDict){
					//data['dict.value'] = 
					var dictValue = $("#dictValue").val();
					data['dict.value'] = dictValue;
					data['dict.isValueDict'] = 'Y';
					if(''==dictValue){
						alert("������ֵ");
						return;
					}
				}
				data['dict.is_leaf'] = 'Y';
				data['dict.is_main'] = 'N';
			//	return;
				$.ajax({
					type:'POST',
					url:'datadict/DictAction!addSubDict.action',
					data:data,
					success:function(datas){
					//	alert(datas);
						alert("��ӳɹ�!");
						var result = $.parseJSON(datas);
						var dict = result.resultMap.dict;
						//������������ӵ������
						var tr = $("<tr></tr>");
						var td_1 = $("<td></td>");$("<input type='checkbox' name='flag'/>").appendTo(td_1);td_1.appendTo(tr);
						var td_2 = $("<td></td>");td_2.html(dict.dictId);td_2.appendTo(tr);
						var td_3 = $("<td></td>");td_3.html(dict.dictName);td_3.appendTo(tr);
						var td_4 = $("<td></td>");td_4.html(currentNode.name);td_4.appendTo(tr);
						var td_5 = $("<td></td>").html(dict.value).appendTo(tr);
						tr.appendTo($("#dictList").find("table"));
						//��Ӻ������ӿ�
						$("#subDictName").val("");
						$("#addSub").unbind("click");
						$("#addSubDictDiv").find("input[type='button']").attr("id","");
						$("#addSubDictDiv").hide('slow');
					}
				})
			});
		//	alert("add");
		}
		
		//�޸�������
		function modifySubDict(){
			var list = $("input[name='flag']:checked");
			if(list.length != 1){
				alert("��ѡ��һ��Ҫ��������");return;
			}
			
			var dictId = list.parent().parent().find("td:eq(1)").html();
			var dictName = list.parent().parent().find("td:eq(2)").html();
			
			$("#subDictName").val(dictName);
			//�������ֵ �ֵ�
			if(currentNode.isValueDict=='Y'){
				$("#dictValue").val($("input[name='flag']:checked").parent().parent().find("td:eq(4)").html());
			}
			$("#addSubDictDiv").find("input[type='button']").attr("id","modifySub");
			$("#modifySub").attr("value",'�޸�');
			$("#addSubDictDiv").show('slow');
			//���¼�
			$("#modifySub").bind("click",function(){
				
				var dictId = $("input[name='flag']:checked").parent().parent().find("td:eq(1)").html();
				var dictName = $("#subDictName").val();
				var data = new Object();
				data['dict.dictId'] = dictId;
				data['dict.dictName'] = dictName;
				if(currentNode.isValueDict=='Y'){
					data['dict.value'] = $("#dictValue").val();
				}
			//	alert(JSON.stringify(data));
				$.ajax({
					async:false,
					type:'POST',
					url:'datadict/DictAction!modifyDict.action',
					data:data,
					success:function(datas){
						var d = $.parseJSON(datas);
						//��������ݸ���
						$("input[name='flag']:checked").parent().parent().find("td:eq(2)").html($("#subDictName").val());
						alert('�޸ĳɹ�');
						//�����ɹ������ݱ�Ϊ��ʼ����
						if(currentNode.isValueDict=='Y'){
							$("input[name='flag']:checked").parent().parent().find("td:eq(4)").html($("#dictValue").val());
						}
						$("#modifySub").unbind("click");
						$("#addSubDictDiv").find("input[type='button']").attr("id","");
						$("#subDictName").attr("value","");
						$("#addSubDictDiv").hide('slow');
					}
				})
			})
		}
		
		//ɾ��������
		function deleteSubDict(){
			var list = $("input[name='flag']:checked");
		//	alert(list.length);
			if(list.length==0){
				$.messager.alert('��ʾ','��ѡ��Ҫɾ���Ķ���'); 
			}else{
				$.messager.defaults={ok:'ȷ��',cancel:'ȡ��'};
				$.messager.confirm('ȷ�Ͽ�','ȷ��Ҫɾ����?',function(result){  
					   if (result){  
						   var idArray = new Array();
						   var data = new Object();
						   //ƴ��idStr
						   var idStr = "";
						   $(list).each(function(){
							   var id = $(this).parent().parent().find("td:eq(1)").html();
							   idStr += "&dicts.dictId="+id;
							   idArray.push(id);
						   })
						   idStr = idStr.substr(1,idStr.length-1);
						   data['dicts.id'] = idArray;
						//   alert(JSON.stringify(data));
						   $.ajax({
							 	type:'GET',                                 
							 	async:false,
							 	url:'DictAction!deleteMultipleDict.action?'+idStr,
							 	success:function(datas){
							 		//ɾ���ɹ�
							 		alert('ɾ���ɹ�');
							 		$(list).each(function(){
							 			$(this).parent().parent().remove();
							 		})
							 	}
						   })
					       // $("#dictList").hide('slow');
					    }  
					});  
			}
		}
		
	
	</script>
	<body >
		<!--�б�Ի��� -->
		<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-buttons">
			<div id="dictList" style="margin-top:3%;display:none;">
				<table align="center" width="50%" >
					<tr><td><input type="checkbox" name='all'/></td><td>�ֵ����</td><td>����������</td><td>��������</td></tr>
				</table>
			</div>
			
			<!-- ��������ֵ� -->
	   		 <div  id="addSubDictDiv" style="text-align:center;width:110;height:70;display:none;margin-top:10px">
	    		����:<input type="text" id="subDictName"/><span id="valueSpan">ֵ:<span id="optionSpan"></span></span>
	    		<!-- ������ֵ�ֵ� -->
	    		<!-- <div style="display:none" id="subOption">ֵ:<input type="text" id="dictValue"/></div> -->
	    		<input type="button" value="ȷ��">
	  		  </div>
		</div>
		 <div id="dlg-buttons">  
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">save</a>  
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">cancel</a>  
	    </div> 
	    
	    
	    
	    
	    
	    	    <!-- ������ҳ������ -->
	    <div  id="mainDiv">
	    <input type="hidden" name="is_main" value="Y"/>
	    �Ƿ�Ϊ��ֵ�ֵ�:<input type="checkbox" id="isValueDict"/>
	    �ֵ�����:<input type="text" name="dictName" id="dictName"/>
	    <input type="button" id="addDict" value="���" onclick="addDict()"/>
	    </div>
	</body>
	</html>