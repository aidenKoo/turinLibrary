<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// POST 한글 파라미터 깨짐 처리
	request.setCharacterEncoding("UTF-8");

// 사용할 객체 초기화
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
// 파라미터

	String mode = request.getParameter("mode");
	String subject = request.getParameter("subject");
	String writer = (String)session.getAttribute("ID");
	String contents = request.getParameter("contents");
	String num = request.getParameter("num");
	String NUMKEY = "";
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	try {
		// 데이터베이스 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");
		// 처리 (W:등록, M:수정, D:삭제)
		
		// DB CONNECT
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/dbturinlibrary", "root", "1234");



				// 게시물 상세 조회 쿼리 실행 
 		pstmt = conn.prepareStatement(
				"SELECT count(NUM) from tblnoticeboards");
		rs = pstmt.executeQuery();
		rs.next();
        out.println(rs.getString("count(NUM)"));
        String count_NUM = rs.getString("count(NUM)");     
        int  count_NUM2 = Integer.parseInt( count_NUM );
        
        
		
		
		if(count_NUM2 == 0)
		{
			pstmt = conn.prepareStatement(
					"INSERT INTO tblnoticeboards (NUM, SUBJECT, WRITER, CONTENTS, REG_DATE, MOD_DATE) "+
					"VALUES (?, ?, ?, ?, NOW(), NOW())");
			    pstmt.setString(1, "01");
				pstmt.setString(2, subject);
				pstmt.setString(3, writer);
				pstmt.setString(4, contents);
				pstmt.executeUpdate();
		
				response.sendRedirect("7_admin_BoardList.jsp");
				return;
		}
		
		
		if (count_NUM2 > 0 && "W".equals(mode)) {
			
			pstmt = conn.prepareStatement(
					"SELECT NUM from tblnoticeboards");
			rs = pstmt.executeQuery();
			rs.last();
	        out.println(rs.getString("NUM"));
	        
	        String numRequestKey = rs.getString("NUM");
	        int numRequestKey2 = Integer.parseInt(numRequestKey)+1;
	        numRequestKey = Integer.toString(numRequestKey2);
	        
	        String numRequestKey3 = 0+Integer.toString(numRequestKey2);
	        
	        
			pstmt = conn.prepareStatement(
					"SELECT * FROM dbturinlibrary.tblnoticeboards;");
			rs = pstmt.executeQuery();
	        rs.next(); 
	        
	        
	        if(numRequestKey2 < 10)
        	{
			

			
			pstmt = conn.prepareStatement(
				"INSERT INTO tblnoticeboards (NUM, SUBJECT, WRITER, CONTENTS, REG_DATE, MOD_DATE) "+
				"VALUES (?, ?, ?, ?, NOW(), NOW())");
			pstmt.setString(1, numRequestKey3);
			pstmt.setString(2, subject);
			pstmt.setString(3, writer);
			pstmt.setString(4, contents);
			pstmt.executeUpdate();
	
			response.sendRedirect("7_admin_BoardList.jsp");
			return;
			}
		
	        else
	        {
	        	pstmt = conn.prepareStatement(
	    				"INSERT INTO tblnoticeboards (NUM, SUBJECT, WRITER, CONTENTS, REG_DATE, MOD_DATE) "+
	    				"VALUES (?, ?, ?, ?, NOW(), NOW())");
	    			pstmt.setString(1, numRequestKey);
	    			pstmt.setString(2, subject);
	    			pstmt.setString(3, writer);
	    			pstmt.setString(4, contents);
	    			pstmt.executeUpdate();
	    	
	    			response.sendRedirect("7_admin_BoardList.jsp");
	    			return;
	        }
	        
	        
	        
		}
	        
		   if ("M".equals(mode)) {
			   
			   
		 		pstmt = conn.prepareStatement(
						"SELECT NUM from tblnoticeboards");
				rs = pstmt.executeQuery();
				rs.last();
		        out.println(rs.getString("NUM"));
		        
		        String numRequestKey = rs.getString("NUM");
		        int numRequestKey2 = Integer.parseInt(numRequestKey)+1;
		        numRequestKey = Integer.toString(numRequestKey2);
		        
		        String numRequestKey3 = 0+Integer.toString(numRequestKey2);


		   
			pstmt = conn.prepareStatement(
				"UPDATE tblnoticeboards  SET SUBJECT = ?, WRITER = ?, CONTENTS = ?, MOD_DATE = NOW() "+
				"WHERE NUM = ?");
			pstmt.setString(1, subject);
			pstmt.setString(2, writer);
			pstmt.setString(3, contents);
			pstmt.setString(4, num);
			pstmt.executeUpdate();
			
			response.sendRedirect(
				"7_admin_BoardList.jsp?num="+num+"&pageNum="+pageNum+"&searchType="+searchType+"&searchText="+searchText);
			return;
		}
		
		else if ("D".equals(mode)) {
			pstmt = conn.prepareStatement("DELETE FROM tblnoticeboards WHERE NUM = ?");
			pstmt.setString(1, num);
			pstmt.executeUpdate();
			
			response.sendRedirect(
				"7_admin_BoardList.jsp?pageNum="+pageNum+"&searchType="+searchType+"&searchText="+searchText);
		} else {
			response.sendRedirect("7_admin_BoardList.jsp");
		}

		
	}
	
		catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}
%>
