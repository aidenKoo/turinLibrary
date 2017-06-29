<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
  <jsp:include page="../1_main_header.jsp"/>  

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE> Announcement</TITLE>

<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	{font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->
</style>

</HEAD>

<BODY>
<br>
<br>
<br>
<br>
<br>
<br>
<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("number"); 

PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;

String dbID="root";
String dbPassword="1234";

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
Class.forName("com.mysql.jdbc.Driver").newInstance();

conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);


try {
String strSQL = "SELECT * FROM tblnoticeboards WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();


String subject = "";
String contents = "";
String writer = "";
String reg_date = "";
String mod_date = "";

subject = rs.getString("SUBJECT");
contents = rs.getString("CONTENTS");
writer = rs.getString("WRITER");
reg_date = rs.getString("REG_DATE");
mod_date = rs.getString("MOD_DATE");
%>
<div class="title">
<div class="row">
<div class="col-md-12"><h5><center> Announcement </center></h5></div></div></div>
<div class="container">
<div class="panel panel-default">
	<div class="panel-heading text-center">
		<h5 class="panel-title"> <%=subject %></h5>
	</div>

	<div class="panel-body">
		<table class="table table-border">
			<thead>
       		 	<tr>
       		 		<th> Writer </th>	<td><%=writer %> </td> <th> Date </th> <td> : <%=reg_date %> </td>
       		 		<th> mod_date  </th> <td> <%=mod_date %>  </td>
       		 	</tr>
       		 	</thead>
       		 	
       		 </table>
       		<table  class="table table-border">
			<tr>
	        <td>  <%=contents %> </td>
	        </tr>
		</table>
		</div>
	</div>
	
	<TABLE border='0' width='600'>
	<TR>
		<TD align='right'>
			<a href='7_Announcement_List.jsp'>[view list]</a>

<%-- 			<form>
			<input type="hidden" value="<%=owner %>">
			<a href="6_qna_reply.jsp?num=<%=num%>" onclick()=submit()>[답변하기]</a>
			</form> --%>
 		</TD>
	</TR>
</TABLE>



<%

}catch(SQLException e){
   	out.print("SQL error ¯ " + e.toString());
}catch(Exception ex){
   	out.print("JSP error ¯ " + ex.toString());
}finally{  
	rs.close();
	pstmt.close();
	conn.close();
}
%>

</div>

</BODY>
</HTML>
