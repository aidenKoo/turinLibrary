<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>

<%
String num = request.getParameter("num"); 
String memberID = (String)session.getAttribute("ID"); 
String bookCode = request.getParameter("bookCode");

PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

String strSQL = "SELECT memberID FROM tblreview WHERE num = ? and bookCode = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.setString(2, bookCode);
rs = pstmt.executeQuery();
rs.next();


	strSQL = "DELETE From tblreview WHERE num=? and bookCode = ?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));
	pstmt.setString(2, bookCode);
	pstmt.executeUpdate();
	
	strSQL = "UPDATE tblreview SET num = num - 1 WHERE num > ?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));
	pstmt.executeUpdate();

rs.close();
pstmt.close();
conn.close();
%>
<script type="text/javascript">alert("The deletion is complete.");
history.go(-2);
location.reload(0); 
history.go(0);
</script>
