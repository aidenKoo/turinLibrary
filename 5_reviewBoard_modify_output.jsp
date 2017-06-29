<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>

<%
request.setCharacterEncoding("utf-8");
int num  = Integer.parseInt(request.getParameter("num"));
String memberID = request.getParameter("memberID");
String title = request.getParameter("title");
String contents = request.getParameter("contents");
String bookCode = request.getParameter("bookCode");
String bookTitle = request.getParameter("bookTitle");
Class.forName("com.mysql.jdbc.Driver").newInstance();

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Connection conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

ResultSet rs = null;

PreparedStatement pstmt = null;

Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

pstmt = conn.prepareStatement("UPDATE tblreview SET memberID=?, title=?, content=?, date=?  where num=? and bookCode = ?");
pstmt.setString(1, memberID);
pstmt.setString(2, title);
pstmt.setString(3, contents);
pstmt.setString(4, indate);
pstmt.setInt(5, num);
pstmt.setString(6, bookCode);

pstmt.executeUpdate();

pstmt.close();
conn.close();

response.sendRedirect("4_bookDetail_details.jsp?bookCode=" +bookCode+"");
%>