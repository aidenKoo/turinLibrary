<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta 
="viewport" content="width=device-width, initial-scale=1">
<title>Lumino - Charts</title>
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
	// 삭제 체크
	function deleteCheck(url) {
		if (confirm('정말 삭제하시겠어요?')) {
			location.href=url;
		}
	}
</script>


<%
out.println("42");
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
				"SELECT * FROM tblnoticeboards WHERE NUM = ?");
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();
		rs.next();

%>

<!-- SQL CONNECTION -->


<body>
		
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">			
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="#"><svg class="glyph stroked home"><use xlink:href="#stroked-home"></use></svg></a></li>
				<li class="active">Icons</li>
			</ol>
		</div><!--/.row-->
		
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Notice </h1>
			</div>
		</div><!--/.row-->
							<div class="col-lg-12">
			<div class="col-md-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<%=rs.getString("SUBJECT") %>
					</div>
					<div class="panel-body">
						<p><%=rs.getString("CONTENTS") %></p>
					</div>
					<div class="panel-body">
											<p class="btn_align">
		<input type="button" value="list" onclick="goUrl('7_admin_BoardList.jsp?pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
		<input type="button" value="modify" onclick="goUrl('7_admin_BoardModifyForm.jsp?num=<%=num%>&amp;pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
		<input type="button" value="delete" onclick="deleteCheck('7_admin_BoardProcess.jsp?mode=D&amp;num=<%=num%>&amp;pageNum=<%=pageNum%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>');" />
	</p>
	</div>
				</div>
			</div>

					</div>




		
	</div><!--/.main-->

	<script src="/turinLibrary/js/jquery-1.11.1.min.js"></script>
	<script src="/turinLibrary/js/bootstrap.min.js"></script>
	<script src="/turinLibrary/js/chart.min.js"></script>
	<script src="/turinLibrary/js/chart-data.js"></script>
	<script src="/turinLibrary/js/easypiechart.js"></script>
	<script src="/turinLibrary/js/easypiechart-data.js"></script>
	<script src="/turinLibrary/js/bootstrap-datepicker.js"></script>
	<script src="/turinLibrary/js/bootstrap-table.js"></script>

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