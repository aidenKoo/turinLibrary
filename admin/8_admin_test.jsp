<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>

<%
	String uploadPath = request.getRealPath("upload");

	int size = 10 * 1024 * 1024;

	String name = "";
	String subject = "";
	String filename1 = "";
	String filename2 = "";
	String origfilename1 = "";
	String origfilename2 = "";

	try {
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
		subject = multi.getParameter("subject");

		Enumeration files = multi.getFileNames();

		String file1 = (String) files.nextElement();
		filename1 = multi.getFilesystemName(file1);
		origfilename1 = multi.getOriginalFileName(file1);

/* 		String file2 = (String) files.nextElement();
		filename2 = multi.getFilesystemName(file2);
		origfilename2 = multi.getOriginalFileName(file2); */
        out.println(subject);
	} catch (Exception e) {
		e.printStackTrace();
	}
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
	<a href="#" onclick="javascript:filecheck.submit()">업로드 확인 및 다운로드
		페이지</a>

</body>
</html>


