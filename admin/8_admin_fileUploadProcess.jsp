<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*, java.sql.*"%>

<%

// String reset
String name = "";
String bookCode = "0010";
String bookTitle = "";
String publicationYear = "";
String publisher = "";
String author = "";
String filename1 = "";
String thumbnail = "";
String origfilename1 = "";
String origfilename2 = "";
   

   

	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// 파라미터

	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	
	try {
        String uploadPath = request.getServletContext().getRealPath("upload"); 
	    int size = 10 * 1024 * 1024;
        // 업로드 용량 설정

        
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8",
				new DefaultFileRenamePolicy());
        
        

/* 
		MultipartRequest 이 코드가 실제로 화일 업로드를 담당하는 부분이다.
		첫번째 인자는 폼에서 가져온 인자 값을 얻기 위해 request 객체를 전달해 주는 것이고
		두번째 인자는 업로드 될 화일의 위치를 의미한다.
		세번째는 한번에 업로드할 크기를 의미하며
		최대 크기를 넘는 경우 Exception이 발생한다.
		다섯번재 인자는 똑같은 화일을 업로드 할 경우 중복되지 않도록 화일 이름을 변환해주는 
		기능을 갖는다.
		*/

		name = multi.getParameter("name");
		bookTitle = multi.getParameter("bookTitle");
        publicationYear = multi.getParameter("publicationYear");
		publisher = multi.getParameter("publisher");
		author = multi.getParameter("author");

	
		Enumeration files = multi.getFileNames();
		

		

		String ebookFile = (String) files.nextElement();
		filename1 = multi.getFilesystemName(ebookFile);
		origfilename1 = multi.getOriginalFileName(ebookFile);

		String thumbnailFile = (String) files.nextElement();
		thumbnail = multi.getFilesystemName(thumbnailFile);
		origfilename2 = multi.getOriginalFileName(thumbnailFile);

		// DB CONNECT
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");


		// 게시물 상세 조회 쿼리 실행 
 		pstmt = conn.prepareStatement(
				"SELECT count(bookPrimaryKey) from tblbook");
		rs = pstmt.executeQuery();
		rs.next();
        out.println(rs.getString("count(bookPrimaryKey)"));

        String num = rs.getString("count(bookPrimaryKey)");
        bookCode = "0010"+num;
		pstmt = conn.prepareStatement(
				"SELECT count(bookPrimaryKey) from tblbook");
		rs = pstmt.executeQuery("SELECT * FROM dbturinlibrary.tblbook;");
        rs.next(); 
        

		pstmt = conn.prepareStatement(
				"INSERT INTO tblbook (bookprimaryKey, Bookcode, bookTitle, publicationYear, " +
						"publisher, thumbnail, fileDirectory, author) "+
				"VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, num+1);
			pstmt.setString(2, bookCode);
			pstmt.setString(3, bookTitle);
			pstmt.setString(4, publicationYear);
			pstmt.setString(5, publisher);
			pstmt.setString(6, thumbnail);
			pstmt.setString(7, filename1);
			pstmt.setString(8, author);
			
			pstmt.executeUpdate();
        
        
/* <!-- SQL CONNECTION --> */
		
		
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- 	<form action="fileCheck.jsp" name="filecheck" method="post">

		<input type="hidden" name="name" value="<%=name%>"> <input
			type="hidden" name="subject" value="<%=subject%>"> <input
			type="hidden" name="filename1" value="<%=filename1%>"> <input
			type="hidden" name="filename2" value="<%=filename2%>"> <input
			type="hidden" name="origfilename1" value="<%=origfilename1%>">
		<input type="hidden" name="origfilename2" value="<%=origfilename2%>">

	</form>
 --%>
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

