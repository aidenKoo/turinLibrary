<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*, java.sql.*, java.io.File, java.text.*"%>

<%

// String reset
String name = "";
String bookCode = "";
String bookTitle = "";
String publicationYear = "";
String publisher = "";
String author = "";
String fileDirectory = "";
String thumbnail = "";
String category = "";
String sectionCode = "";
String mode = "";
String bookModifyKey = "";
String content = "";
String summary = "";



	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// 파라미터
  
	
	try {
		
		
		

        String uploadPath = request.getServletContext().getRealPath("Ebook_Files"); 

        
	    int size = 100 * 1024 * 1024;
        // file size limitation
     
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8",
				new DefaultFileRenamePolicy());      
		category = multi.getParameter("category");
/* 		String uploadPath2 = request.getServletContext().getRealPath("science"); */

		
		
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
        category = multi.getParameter("category");
	    mode = multi.getParameter("mode");
	    bookModifyKey = multi.getParameter("bookModifyKey");
	    content = multi.getParameter("content");
	    summary = multi.getParameter("summary");
		Enumeration files = multi.getFileNames();
		

        
	    String file1 = (String) files.nextElement();
		fileDirectory = multi.getFilesystemName(file1);
     	String thumbnailFile = (String) files.nextElement();
		thumbnail = multi.getFilesystemName(thumbnailFile);





		// DB CONNECT
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");


		// tblcategory connect
		// category 
		pstmt = conn.prepareStatement(
				"SELECT category, sectionCode FROM tblcategory "+ 
				"WHERE category = ?");
		pstmt.setString(1, category);
		rs = pstmt.executeQuery();
		rs.next();
        sectionCode = rs.getString("sectionCode");
		out.println(sectionCode);
		
				// 게시물 상세 조회 쿼리 실행 
 		pstmt = conn.prepareStatement(
				"SELECT count(bookPrimaryKey) from tblbook");
		rs = pstmt.executeQuery();
		rs.next();
        out.println(rs.getString("count(bookPrimaryKey)"));
        String count_bookPrimaryKey = rs.getString("count(bookPrimaryKey)");     
        int  count_bookPrimaryKey2 = Integer.parseInt( count_bookPrimaryKey );

        if(count_bookPrimaryKey2 == 0)
        
        {
    		pstmt = conn.prepareStatement(
    				"SELECT * FROM dbturinlibrary.tblbook;");
    		rs = pstmt.executeQuery();
            rs.next(); 
            pstmt = conn.prepareStatement(
    				"INSERT INTO tblbook (bookPrimaryKey, Bookcode, bookTitle, publicationYear, " +
    						"publisher, thumbnail, summary, content, sectionCode, fileDirectory, author) "+
    				"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    			pstmt.setString(1, "01");
    			pstmt.setString(2, sectionCode+"01");
    			pstmt.setString(3, bookTitle);
    			pstmt.setString(4, publicationYear);
    			pstmt.setString(5, publisher);
    			pstmt.setString(6, thumbnail);
    			pstmt.setString(7, summary);
    			pstmt.setString(8, content);
    			pstmt.setString(9, sectionCode);
    			pstmt.setString(10, fileDirectory);
    			pstmt.setString(11, author);
    			
    			pstmt.executeUpdate();
    			response.sendRedirect("8_admin_ebookList.jsp");
    			return;
        }
        
        
        
        
        
        
        if(count_bookPrimaryKey2 > 0 && "W".equals(mode))
        {
        	
 		pstmt = conn.prepareStatement(
				"SELECT bookPrimaryKey from tblbook");
		rs = pstmt.executeQuery();
		rs.last();
        out.println(rs.getString("bookPrimaryKey"));
        
        String bookRequestKey = rs.getString("bookPrimaryKey");
        int bookRequestKey2 = Integer.parseInt(bookRequestKey)+1;
        bookRequestKey = Integer.toString(bookRequestKey2);
        
        String bookRequestKey3 = 0+Integer.toString(bookRequestKey2);
        
        
		pstmt = conn.prepareStatement(
				"SELECT * FROM dbturinlibrary.tblbook;");
		rs = pstmt.executeQuery();
        rs.next(); 

        	

        	
        if(bookRequestKey2 < 10)
        	{
        	

		pstmt = conn.prepareStatement(
				"INSERT INTO tblbook (bookPrimaryKey, Bookcode, bookTitle, publicationYear, " +
						"publisher, thumbnail,summary, content, sectionCode, fileDirectory, author) "+
				"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

			pstmt.setString(1, bookRequestKey3);
			pstmt.setString(2, sectionCode+bookRequestKey3);
			pstmt.setString(3, bookTitle);
			pstmt.setString(4, publicationYear);
			pstmt.setString(5, publisher);
			pstmt.setString(6, thumbnail);
			pstmt.setString(7, summary);
			pstmt.setString(8, content);
			pstmt.setString(9, sectionCode);
			pstmt.setString(10, fileDirectory);
			pstmt.setString(11, author);
			
			pstmt.executeUpdate();
			response.sendRedirect("8_admin_ebookList.jsp");
			return;
        }
        	else {
        		
        		
        		
        		
        		pstmt = conn.prepareStatement(
        				"INSERT INTO tblbook (bookPrimaryKey, Bookcode, bookTitle, publicationYear, " +
        						"publisher, thumbnail,summary, content, sectionCode, fileDirectory, author) "+
        				"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

        			pstmt.setString(1, bookRequestKey);
                    pstmt.setString(2, sectionCode+bookRequestKey3);
        			pstmt.setString(3, bookTitle);
        			pstmt.setString(4, publicationYear);
        			pstmt.setString(5, publisher);
        			pstmt.setString(6, thumbnail);
        			pstmt.setString(7, summary);
        			pstmt.setString(8, content);
        			pstmt.setString(9, sectionCode);
        			pstmt.setString(10, fileDirectory);
        			pstmt.setString(11, author);
        			
        			pstmt.executeUpdate();
        			response.sendRedirect("8_admin_ebookList.jsp");
        			return;
        	}
        
        }
        
        
		if ("M".equals(mode)) {
			
	 		pstmt = conn.prepareStatement(
					"SELECT bookPrimaryKey from tblbook");
			rs = pstmt.executeQuery();
			rs.last();
	        out.println(rs.getString("bookPrimaryKey"));
	        
	        String bookRequestKey = rs.getString("bookPrimaryKey");
	        int bookRequestKey2 = Integer.parseInt(bookRequestKey)+1;
	        bookRequestKey = Integer.toString(bookRequestKey2);
	        
	        String bookRequestKey3 = 0+Integer.toString(bookRequestKey2);
			
			if(fileDirectory == null && thumbnail == null)
			{
			pstmt = conn.prepareStatement(
				"UPDATE tblbook  SET bookCode = ?, bookTitle = ?, publicationYear = ?, publisher = ?, " +
					"summary = ?, content = ?, sectionCode = ?, author = ?	WHERE bookPrimaryKey = ?");
			pstmt.setString(1, sectionCode+bookRequestKey);
			pstmt.setString(2, bookTitle);
			pstmt.setString(3, publicationYear);
			pstmt.setString(4, publisher);
			pstmt.setString(5, summary);
			pstmt.setString(6, content);
			pstmt.setString(7, sectionCode);
			pstmt.setString(8, author);
            pstmt.setString(9, bookModifyKey);
			pstmt.executeUpdate();
			}
			else if(fileDirectory == null)
			{
				pstmt = conn.prepareStatement(
						"UPDATE tblbook  SET bookCode = ?, bookTitle = ?, publicationYear = ?, publisher = ?, thumbnail = ?, " +
							"summary = ? , content = ?, sectionCode = ?, author = ?	WHERE bookPrimaryKey = ?");
					pstmt.setString(1, sectionCode+bookRequestKey);
					pstmt.setString(2, bookTitle);
					pstmt.setString(3, publicationYear);
					pstmt.setString(4, publisher);
					pstmt.setString(5, thumbnail);
					pstmt.setString(6, summary);
					pstmt.setString(7, content);
					pstmt.setString(8, sectionCode);
					pstmt.setString(9, author);
		            pstmt.setString(10, bookModifyKey);
					pstmt.executeUpdate();	
			}
			else if(thumbnail == null)
			{
				pstmt = conn.prepareStatement(
						"UPDATE tblbook  SET bookCode = ?, bookTitle = ?, publicationYear = ?, publisher = ?,  " +
							"summary = ?,content = ?, sectionCode = ?,fileDirectory = ?, author = ?	WHERE bookPrimaryKey = ?");
					pstmt.setString(1, sectionCode+bookRequestKey);
					pstmt.setString(2, bookTitle);
					pstmt.setString(3, publicationYear);
					pstmt.setString(4, publisher);
					pstmt.setString(5, content);
					pstmt.setString(6, summary);
					pstmt.setString(7, sectionCode);
					pstmt.setString(8, fileDirectory);
					pstmt.setString(9, author);
		            pstmt.setString(10, bookModifyKey);
					pstmt.executeUpdate();	
			}
			else 
			{
			pstmt = conn.prepareStatement(
				"UPDATE tblbook  SET bookCode = ?, bookTitle = ?, publicationYear = ?, publisher = ?, thumbnail = ?, " +
					"summary = ?,content = ?, sectionCode = ?, fileDirectory = ?, author = ?	WHERE bookPrimaryKey = ?");
			pstmt.setString(1, sectionCode+bookRequestKey);
			pstmt.setString(2, bookTitle);
			pstmt.setString(3, publicationYear);
			pstmt.setString(4, publisher);
			pstmt.setString(5, thumbnail);
			pstmt.setString(6, summary);
			pstmt.setString(7, content);
			pstmt.setString(8, sectionCode);
			pstmt.setString(9, fileDirectory);
			pstmt.setString(10, author);
            pstmt.setString(11, bookModifyKey);
			pstmt.executeUpdate();
			}
			
			response.sendRedirect(
				"8_admin_ebookList.jsp");
			return;
		}
		
 else {
			response.sendRedirect("8_admin_ebookList.jsp");
			
		}

	
        
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

