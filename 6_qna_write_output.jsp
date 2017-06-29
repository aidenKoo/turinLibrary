<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
  <jsp:include page="1_main_header.jsp"/>  

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE> Q & A Board </TITLE>

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
String strSQL = "SELECT * FROM tblqnaboard WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();

String memberID = rs.getString("memberID");
String title = rs.getString("title");
String contents = rs.getString("contents").trim();
String writedate = rs.getString("writedate");
String owner = rs.getString("owner");
int readcount = rs.getInt("readcount");
%>
<div class="title">
<div class="row">
<div class="col-md-12"><h5><center> Q & A Board</center></h5></div></div></div>
<div class="container">
<div class="panel panel-default">
	<div class="panel-heading text-center">
		<h5 class="panel-title"> <%=title %></h5>
	</div>

	<div class="panel-body">
		<table class="table table-border">
			<thead>
       		 	<tr>
       		 		<th> Writer </th>	<td> <%=memberID %></td> <th> Date </th> <td> : <%=writedate %></td>
       		 		<th> Views  </th> <td> <%=readcount %>  </td>
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
			<a href='6_qna_modify.jsp?num=<%=num%>'>[modify]</a>
			<a href='6_qna_delete_input.jsp?num=<%=num%>'>[remove]</a>			
			<a href='6_qna_write.jsp'>[write article]</a>
			<a href='6_qna_listboard.jsp'>[view list]</a>
			<a href="6_qna_reply.jsp?num=<%=num%>">[reply]</a>

<%-- 			<form>
			<input type="hidden" value="<%=owner %>">
			<a href="6_qna_reply.jsp?num=<%=num%>" onclick()=submit()>[답변하기]</a>
			</form> --%>
 		</TD>
	</TR>
</TABLE>

<%
strSQL = "UPDATE tblqnaBoard SET readcount=readcount+1 WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.executeUpdate();

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
