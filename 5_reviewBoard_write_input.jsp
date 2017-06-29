<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>


<%
request.setCharacterEncoding("utf-8");
String memberID   =(String)session.getAttribute("ID");  
String title  = request.getParameter("title");
String contents  = request.getParameter("contents");
String bookTitle  = request.getParameter("bookTitle");
String bookCode = request.getParameter("bookCode");

Connection conn = null;
ResultSet rs = null;
String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

PreparedStatement pstmt1 = null, pstmt2 = null;
	
Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));
	
String strSQL ="SELECT Max(num) FROM tblreview";
pstmt1 = conn.prepareStatement(strSQL);
rs = pstmt1.executeQuery();

int num = 1;

if(!rs.wasNull()){
	rs.next();
	num = rs.getInt(1) + 1;
}

strSQL = "INSERT INTO tblReview(num, memberID,  title, content, date, views , bookCode)"
			+"VALUES(?, ?, ?, ?, ?, ?, ?)";

pstmt2 = conn.prepareStatement(strSQL);
pstmt2.setInt(1, num);
pstmt2.setString(2, memberID);
pstmt2.setString(3, title);
pstmt2.setString(4, contents);
pstmt2.setString(5, indate);
pstmt2.setInt(6, 0);
pstmt2.setString(7, bookCode);

pstmt2.executeUpdate();
    

rs.close();
pstmt1.close();
pstmt2.close();
conn.close();

response.sendRedirect("4_bookDetail_details.jsp?bookCode="+bookCode); 
%>
