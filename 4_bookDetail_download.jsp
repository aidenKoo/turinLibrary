<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.ServletUtils" %>
<%@ page import = "java.sql.*, java.util.*" %>
<%

	
	String bookCode = request.getParameter("bookCode");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
	String dbID="root";
	String dbPassword="1234";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

	String strSQL= "select fileDirectory from tblbook where bookcode = '" +bookCode+ "'";
	
	pstmt=conn.prepareStatement(strSQL);
	rs = pstmt.executeQuery(strSQL);
	rs.next();
					/* get the file directory */
	
	String filename = rs.getString("fileDirectory"); /* "no_image.jpg"; */ 

	String savePath = "Ebook_Files";
	
	ServletContext context = getServletContext();
	
	String sDownloadPath = context.getRealPath(savePath);
	String sFilePath = sDownloadPath + "\\" + filename;
	
	
	byte[] b = new byte[4096];
	
	File oFile = new File(sFilePath);
	
	FileInputStream in = new FileInputStream(sFilePath);
	
	String sMineType = getServletContext().getMimeType(sFilePath);
	
	//octet-stream은 8비트로 된 일련의 데이터를 의미한다.
	//지정되지 않은 화일 형식을 의미한다.
	if(sMineType == null){
		sMineType = "application/octet-stream";
	}
	
	response.setContentType(sMineType);
	
	String sEncoding = new String(filename.getBytes("utf-8"),"8859_1");
	//한글 업로드(한글명이 깨지는 것을 방지)
	
	response.setHeader("Content-Disposition","attachment; filename="+sEncoding);
	
	ServletOutputStream out2 = response.getOutputStream();
	
	int numRead;
	
	//바이트 배열 b의 0번 부터 numRead번 까지 브라우저 출력
	while((numRead = in.read(b,0,b.length))!=-1){
		out2.write(b,0,numRead);
	}
	out2.flush();
	out2.close();
	in.close();
	
%>
<script>alert('권한이 없어요!'); window.history.back(); </script>
