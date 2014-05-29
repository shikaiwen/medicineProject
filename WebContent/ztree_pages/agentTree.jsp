<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>

<%@ page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet,java.util.List,java.util.ArrayList" %>
<%@ page import="java.sql.DriverManager,java.sql.ResultSetMetaData" %>
<%@ page import="java.util.Map,java.util.HashMap" %>
<%@ page import="com.drp.util.JsonUtil" %>

<link rel="stylesheet" href="<%=base%>cssfiles/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=base%>/cssfiles/themes/icon.css">
<script type="text/javascript" src="<%=base%>jsfiles/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=base%>jsfiles/jquery.ztree.core-3.5.js"></script>

<%
	String sql = "select agent_id,pid,agent_name from t_agent";//sql语句

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List<String> columnNameList = new ArrayList<String>();
		List<Map<Object,Object>> resultList = new ArrayList<Map<Object,Object>>();
		try{
			//System.out.println(idColumn+" "+pidColumn+" "+sql);
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			for(int i=0;i<columnCount;i++){
				String columnName = rsmd.getColumnName(i+1);//columnname是从1开始
				columnNameList.add(columnName);
			}
			
			while(rs.next()){
				Map<Object,Object> map = new HashMap<Object,Object>();
				for(int i=0;i<columnNameList.size();i++){
					map.put(columnNameList.get(i).toLowerCase(), rs.getString(columnNameList.get(i)));
				}
				resultList.add(map);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		String treeStr = JsonUtil.toJsonStr(resultList);
		System.out.println(treeStr);

%>
<%! 
public Connection getConnection(){
	Connection conn = null;
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		 conn = DriverManager.getConnection("jdbc:oracle:thin:1521:orcl", "drp", "drp");
	}catch(Exception e){
		e.printStackTrace();
	}
	return conn;
}
%>


<script type="text/javascript">
$(function(){
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
		var d = <%=treeStr%>;
		$.fn.zTree.init($("#tree"), setting, d);
})

</script>


<ul class="ztree" id="tree"></ul>