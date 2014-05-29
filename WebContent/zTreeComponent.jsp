<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
//out.write(basePath);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="<%=base%>cssfiles/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/icon.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.ztree.core-3.5.js"></script>
</head>
<script type="text/javascript">

	function getTree(){
		$.ajax({
			type:'POST',
			url:'<%=base%>basedata/zTreeComponent!generateStr.action',
			success:function(datas){
				alert(datas);
				test2(datas);
			}
		})
	}


	function test2(datas){
		var setting = {	
				data: {
					key:{
						name:'agentName'
					},
					simpleData: {
						enable: true,
						idKey:'agentId',
						pIdKey:'pid'
					}
				}
		};
		var d = eval(datas);
	var data = [
	            {"agentId":100,"agentName":"所有分销商","isLeaf":"N","pid":0,"agentLevel":0,"address":0},
	            {"agentId":165,"agentName":"23","contactMan":"12","telephone":"121","fixedPhone":"21","email":"21","isAgent":"N","isLeaf":"Y","pid":102,"agentLevel":0,"createDate":"2013-06-07 02:13:57","address":69},
	            {"agentId":102,"agentName":"华南区","contactMan":"乔布斯","telephone":"18849896354","fixedPhone":"6666666","email":"apple@apple.com","isLeaf":"N","pid":100,"agentLevel":0,"address":24},
	            {"agentId":126,"agentName":"华北区","contactMan":"施凯文","telephone":"123456","fixedPhone":"321654","email":"222@gmail.com","isAgent":"N","isLeaf":"N","pid":100,"agentLevel":0,"createDate":"2013-05-16 04:58:39","address":28},
	            {"agentId":127,"agentName":"蒙古医疗中心","contactMan":"88","telephone":"888","fixedPhone":"888","email":"889","isAgent":"Y","isLeaf":"Y","pid":126,"agentLevel":194,"createDate":"2013-05-16 05:00:39","detailedAddress":"蒙牛路1号","address":29},
	            {"agentId":168,"agentName":"湖南地区","contactMan":"施凯文","telephone":"18673166174","fixedPhone":"87665654","email":"baidu@126.com","isAgent":"N","isLeaf":"Y","pid":102,"agentLevel":0,"createDate":"2013-06-08 09:16:23","address":0},
	            {"agentId":104,"agentName":"西北地区","contactMan":"fgfg","telephone":"dfas","fixedPhone":"das","email":"dfadf","isLeaf":"N","pid":100,"agentLevel":0,"address":55},
	            {"agentId":158,"agentName":"分销商1","contactMan":"刘德华","telephone":"18673166174","fixedPhone":"225412-223","email":"huazai@126.com","isAgent":"Y","isLeaf":"Y","pid":143,"agentLevel":194,"createDate":"2013-06-07 02:05:47","detailedAddress":"22号","address":64},
	            {"agentId":159,"agentName":"分销商2","contactMan":"323","telephone":"32","fixedPhone":"32","email":"2weet@123.com","isAgent":"Y","isLeaf":"Y","pid":143,"agentLevel":199,"createDate":"2013-06-07 02:06:31","detailedAddress":"33号","address":65},
	            {"agentId":140,"agentName":"华东区","contactMan":"比尔盖茨","telephone":"89888889","fixedPhone":"3333333","email":"12345@sky.com","isAgent":"N","isLeaf":"N","pid":100,"agentLevel":0,"createDate":"2013-05-16 09:32:06","address":41},
	            {"agentId":142,"agentName":"西安大街药房","contactMan":"122","telephone":"2222","fixedPhone":"222","email":"222","isAgent":"Y","isLeaf":"Y","pid":104,"agentLevel":199,"createDate":"2013-05-17 02:14:08","address":56},
	            {"agentId":141,"agentName":"上海浦东大药房","contactMan":"阿克苏","telephone":"333333333","fixedPhone":"3333","email":"333666","isAgent":"Y","isLeaf":"Y","pid":140,"agentLevel":194,"createDate":"2013-05-16 09:34:02","detailedAddress":"aaa路bbb号","address":42},
	            {"agentId":143,"agentName":"西北子区域1","contactMan":"大大","telephone":"222","fixedPhone":"343","email":"434","isAgent":"N","isLeaf":"N","pid":104,"agentLevel":0,"createDate":"2013-05-17 02:15:44","address":33},
	            {"agentId":145,"agentName":"测试区域分销商","contactMan":"444","telephone":"333","fixedPhone":"444","email":"3434","isAgent":"Y","isLeaf":"Y","pid":125,"agentLevel":199,"createDate":"2013-05-17 02:19:18","address":58},
	            {"agentId":160,"agentName":"分销商3","contactMan":"323","telephone":"32323","fixedPhone":"6555","email":"3233@33.com","isAgent":"Y","isLeaf":"Y","pid":143,"agentLevel":256,"createDate":"2013-06-07 02:07:24","detailedAddress":"145号","address":66}
	           ];
		$.fn.zTree.init($("#tree"), setting, d);
	}
	
	
	function submitData(){
		var data = new Object();
		data['idColumn'] = $("#idColumn").val();
		data['pidColumn'] = $("#pidColumn").val();
		data['treeName'] = $("#treeName").val();
		data['treeCode'] = $("#treeCode").val();
		data['nodeName'] = $("#nodeName").val();
		data['sql'] = $("#sqlArea").val();
//		alert(JSON.stringify(data))
		
		$.ajax({
			type:'POST',
			url:'<%=base%>basedata/zTreeComponent!test1.action',
			data:data,
			success:function(datas){
				alert(datas)
				callback(datas);
			}
		})
	}
	
	function callback(datas){
		var setting = {	
				data: {
					key:{
						name:'agent_name'
					},
					simpleData: {
						enable: true,
						idKey:'agent_id',
						pIdKey:'pid'
					}
				}
		};
		var d = eval(datas);
		$.fn.zTree.init($("#tree"), setting, d);
	}
</script>

<body>  
<ul class="ztree" id="tree"></ul>
  <input type="button" value="获取树" onclick="getTree()"/>
  <input type="button" value="222" onclick="test2()"/>
  <br>
  树名称:<input type="text" id="treeName" value="分销商树"><br>
 树代码:<input type="text" id="treeCode" value="agentTree"><br>
id:<input type="text" size="5" name="id" id="idColumn" value="agent_id"><br>
pid:<input type="text" size="5" name="pid" id="pidColumn" value="pid"><br>
节点名:<input type="nodeName" size="5" id="nodeName" value="agent_name"/>
  <div id="configurationDiv">
  	请输入查询的sql:<textarea rows="10" cols="50" name="sqlArea" id="sqlArea">
  	select agent_id,pid,agent_name from t_agent
  	</textarea>
  </div>
  <input type="button" value="完成" onclick="submitData()">
</body>  
</html>  
