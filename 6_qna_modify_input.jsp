<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>

<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("num"); 

String title = request.getParameter("title");
String contents = request.getParameter("contents");


PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;

Class.forName("com.mysql.jdbc.Driver").newInstance();

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);


String strSQL = "UPDATE tblqnaBoard SET title=? contents=? WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setString(1, title);
pstmt.setString(2, contents);
pstmt.setInt(3, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();

response.sendRedirect("6_qna_listboard.jsp");	

rs.close();
pstmt.close();
conn.close();
%>
