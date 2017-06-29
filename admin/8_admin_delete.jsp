<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*, java.sql.*, java.io.File, java.text.*"%>

<%

// String reset
String bookRequestKey = request.getParameter("bookRequestKey");
	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// 파라미터
  
	
	try {
		
		
		





		// DB CONNECT
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");

		pstmt = conn.prepareStatement("DELETE FROM tblbook WHERE bookPrimaryKey = ?");
		pstmt.setString(1, bookRequestKey);
		pstmt.executeUpdate();
		
		response.sendRedirect("8_admin_ebookList.jsp");
	
        
/* <!-- SQL CONNECTION --> */
		
		
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<a href="#" onclick="javascript:filecheck.submit()">
		페이지</a>

</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) rs.close();
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}
%>

