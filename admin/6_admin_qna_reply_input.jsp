<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>

<%
request.setCharacterEncoding("utf-8");
int num   = Integer.parseInt(request.getParameter("num")); 
String owner   = request.getParameter("owner");  
String title  = request.getParameter("title");
String contents  = request.getParameter("contents");
String memberID = (String)session.getAttribute("ID");

ResultSet rs = null;
Connection conn = null;

String dbID="root";
String dbPassword="1234";

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
Class.forName("com.mysql.jdbc.Driver").newInstance();

conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

PreparedStatement pstmt = null;


Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

pstmt = conn.prepareStatement("SELECT COUNT(num) AS TOTAL FROM tblqnaboard");
rs = pstmt.executeQuery();
rs.next();
int TOTAL = rs.getInt("TOTAL");




pstmt = conn.prepareStatement("UPDATE tblqnaboard SET hasAnswer=? WHERE num=?");
pstmt.setString(1, "Y"); //When an administrator changes in response to the value of Y hasAnswer
pstmt.setInt(2, num);
pstmt.executeUpdate();


String strSQL = "UPDATE tblqnaboard SET num = num + 1 WHERE num = " + num + " OR num > " + num;



pstmt = conn.prepareStatement(strSQL);
pstmt.executeUpdate();

strSQL = "INSERT INTO tblqnaBoard(num, memberID, title, contents, writedate, readcount, owner)"
      +"VALUES(?, ?, ?, ?, ?, ?, ?)";

pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, TOTAL);
pstmt.setString(2, memberID);
pstmt.setString(3, title);
pstmt.setString(4, contents);
pstmt.setString(5, indate);
pstmt.setInt(6, 0);
pstmt.setString(7, owner);

pstmt.executeUpdate();


pstmt.close();                   
pstmt.close();
pstmt.close();
conn.close();

response.sendRedirect("6_admin_qnaList.jsp"); 
%>