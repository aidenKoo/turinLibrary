<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*, java.util.*" %>

<%
	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// 파라미터
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	try {
		// 데이터베이스 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");
		// 게시물 상세 조회 쿼리 실행 
		pstmt = conn.prepareStatement(
			"SELECT NUM, SUBJECT, CONTENTS, WRITER,  REG_DATE FROM tblnoticeboards "+ 
			"WHERE NUM = ?");
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();
		rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Lumino - Charts</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<link href="/turinLibrary/css/bootstrap.min.css" rel="stylesheet">
<link href="/turinLibrary/css/datepicker3.css" rel="stylesheet">
<link href="/turinLibrary/css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="/turinLibrary/js/lumino.glyphs.js"></script>

<!--[if lt IE 9]>
<script src="/turinLibrary/js/html5shiv.js"></script>
<script src="/turinLibrary/js/respond.min.js"></script>
<![endif]-->


 <jsp:include page="6_admin_header.jsp"/> 
							

		    <jsp:include page="6_admin_sidebar.jsp"/> 
		    
<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 수정 폼 체크
	function boardModifyCheck() {
		var form = document.boardModifyForm;
		if (form.subject.value == '') {
			alert('제목을 입력하세요.');
			form.subject.focus();
			return false;
		}
		if (form.writer.value == '') {
			alert('작성자을 입력하세요');
			form.writer.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>



		<form role="form"  method="post" name="boardModifyForm" action="7_admin_BoardProcess.jsp"  onsubmit="return boardModifyCheck();">
	<input type="hidden" name="mode" value="M" />
	<input type="hidden" name="num" value="<%=num %>" />
	<input type="hidden" name="pageNum" value="<%=pageNum %>" />
	<input type="hidden" name="searchType" value="<%=searchType %>" />
	<input type="hidden" name="searchText" value="<%=searchText %>" />            
		  <!-- ///// 모드전송 -->
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">			
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="#"><svg class="glyph stroked home"><use xlink:href="#stroked-home"></use></svg></a></li>
				<li class="active">Icons</li>
			</ol>
		</div><!--/.row-->
		
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Notice Modify</h1>
			</div>
		</div><!--/.row-->
				
		
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">

					<div class="panel-body">
						<div class="col-md-6">
							<form role="form">
							
								<div class="form-group">
									<label>subject</label>
									<input class="form-control" value = "<%=rs.getString("SUBJECT")%>" name="subject" >
								</div>
								
																
                                <div class="form-group">
									<label>contents</label>
									<textarea name="contents" cols="80" rows="10"><%=rs.getString("CONTENTS") %></textarea>
														<script>
					CKEDITOR.replace('contents');
					</script>
								</div>
								
																
							<div class="col-md-6">
							

						<button type="submit" class="btn btn-primary" OnClick="javascript:boardModifyCheck()" >Submit Button</button>
								<button type="reset" class="btn btn-default" onclick="goUrl('7_admin_BoardList.jsp');">Reset Button</button>
							</div>
						</form>
					</div>
				</div>
			</div><!-- /.col-->
		</div><!-- /.row -->
	
	
	
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