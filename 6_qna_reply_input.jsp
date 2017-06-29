<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>

<%
request.setCharacterEncoding("utf-8");
int num   = Integer.parseInt(request.getParameter("num")); 
String owner   = request.getParameter("owner");  
String title  = request.getParameter("title");
String contents  = request.getParameter("contents");

ResultSet rs = null;
Connection conn = null;

String dbID="root";
String dbPassword="1234";

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
Class.forName("com.mysql.jdbc.Driver").newInstance();

conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

PreparedStatement pstmt1 = null, pstmt2 = null, pstmt3 = null;
	
	
Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));


pstmt3 = conn.prepareStatement("UPDATE tblqnaboard SET hasAnswer=? WHERE num=?");
pstmt3.setString(1, "Y"); //When an administrator changes in response to the value of Y hasAnswer
pstmt3.setInt(2, num);
pstmt3.executeUpdate();


String strSQL = "UPDATE tblqnaboard SET num = num + 1 WHERE num = " + num + " OR num > " + num;



pstmt1 = conn.prepareStatement(strSQL);
pstmt1.executeUpdate();

strSQL ="INSERT INTO tblqnaboard(num, memberID, title, contents, writedate, readcount, owner, hasAnswer)";
strSQL = strSQL + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
pstmt2 = conn.prepareStatement(strSQL);
pstmt2.setInt(1, num);
pstmt2.setString(2, "admin");
pstmt2.setString(3, title);
pstmt2.setString(4, contents);
pstmt2.setString(5, indate);
pstmt2.setInt(6, 0);
pstmt2.setString(7, owner);
pstmt2.setString(8, "  ");

pstmt2.executeUpdate();


pstmt1.close();                	
pstmt2.close();
pstmt3.close();
conn.close();

response.sendRedirect("6_admin_qnaboard.jsp"); 
%>
