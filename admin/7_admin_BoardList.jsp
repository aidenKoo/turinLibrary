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
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<link href="/turinLibrary/css/bootstrap.min.css" rel="stylesheet">
<link href="/turinLibrary/css/datepicker3.css" rel="stylesheet">
<link href="/turinLibrary/css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="/turinLibrary/js/lumino.glyphs.js"></script>
<script type="text/javascript">

</script>
<!--[if lt IE 9]>
<script src="/turinLibrary/js/html5shiv.js"></script>
<script src="/turinLibrary/js/respond.min.js"></script>
<![endif]-->


 <jsp:include page="6_admin_header.jsp"/> 
							

		    <jsp:include page="6_admin_sidebar.jsp"/> 


<%
	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int pageNumTemp = 1;
	int listCount = 1;
	int pagePerBlock = 10;
	String whereSQL = "";
	// 파라미터
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	// 파라미터 초기화
	if (searchText == null) {
		searchType = "";
		searchText = "";
	}
	if (pageNum != null) {
		pageNumTemp = Integer.parseInt(pageNum);
	}
	// 한글파라미터 처리
	String searchTextUTF8 = new String(searchText.getBytes("ISO-8859-1"), "UTF-8");
	// 데이터베이스 커넥션 및 질의문 실행
	// 검색어 쿼리문 생성

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");
		// 게시물의 총 수를 얻는 쿼리 실행
		pstmt = conn.prepareStatement("SELECT COUNT(NUM) AS TOTAL FROM tblnoticeboards" + whereSQL);
		if (!"".equals(whereSQL)) {
			if ("ALL".equals(searchType)) {
				pstmt.setString(1, searchTextUTF8);
				pstmt.setString(2, searchTextUTF8);
				pstmt.setString(3, searchTextUTF8);
			} else {
				pstmt.setString(1, searchTextUTF8);
			}
		}
		rs = pstmt.executeQuery();
		rs.next();
		int totalCount = rs.getInt("TOTAL");
		listCount = totalCount;
		// 게시물 목록을 얻는 쿼리 실행
		pstmt = conn.prepareStatement("SELECT * FROM tblnoticeboards "+whereSQL+" ORDER BY NUM DESC LIMIT ?, ?");
		if (!"".equals(whereSQL)) {
			// 전체검색일시
			if ("ALL".equals(searchType)) {
				pstmt.setString(1, searchTextUTF8);
				pstmt.setString(2, searchTextUTF8);
				pstmt.setString(3, searchTextUTF8);
				pstmt.setInt(4, listCount * (pageNumTemp-1));
				pstmt.setInt(5, listCount);			
			} else {
				pstmt.setString(1, searchTextUTF8);
				pstmt.setInt(2, listCount * (pageNumTemp-1));
				pstmt.setInt(3, listCount);			
			}
		} else {	
			pstmt.setInt(1, listCount * (pageNumTemp-1));
			pstmt.setInt(2, listCount);
		}
		rs = pstmt.executeQuery();
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
				<h1 class="page-header">Announcement List</h1>
			</div>
		</div><!--/.row-->
				
		
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading"></div>
					<div class="panel-body">
						<table data-toggle="table"  data-show-refresh="true" data-show-toggle="true" data-show-columns="true" data-search="true" data-select-item-name="toolbar1" data-pagination="true" data-sort-name="name"  data-sort-order="desc">
						    <thead>
						    <tr>
						        <th data-checkbox="true" >Num</th>
						        <th  data-sortable="true">Num</th>
						        <th  data-sortable="true">Subject</th>
						        <th   data-sortable="true">Writer</th>
						        <th  data-sortable="true">date</th>
						    </tr>
						    </thead>
						    <tbody>
			<%
			if (totalCount == 0) {
			%>
			<tr>
				<td align="center" colspan="5">등록된 게시물이 없습니다.</td>
			</tr>
			<%
			} else {
				int i = 0;
				while (rs.next()) {
					i++;
			%>
			<tr>
				<td align="center"><%=totalCount - i + 1 - (pageNumTemp - 1) * listCount %></td>
				<td align="center"><%=rs.getString("NUM") %></td>
				<td><a href="7_admin_BoardView.jsp?num=<%=rs.getString("NUM")%>&amp;pageNum=<%=pageNumTemp%>&amp;searchType=<%=searchType%>&amp;searchText=<%=searchText%>"><%=rs.getString("SUBJECT") %></a></td>
				<td align="center"><%=rs.getString("WRITER") %></td>
				<td align="center"><%=rs.getString("REG_DATE").substring(0,16) %></td>
			</tr>
			<%
				}
			}
			%>
		</tbody>

						</table>
					</div>
				</div>
			</div>
		</div><!--/.row-->	

	</div><!--/.main-->

	<script src="/turinLibrary/js/jquery-1.11.1.min.js"></script>
	<script src="/turinLibrary/js/bootstrap.min.js"></script>
	<script src="/turinLibrary/js/chart.min.js"></script>
	<script src="/turinLibrary/js/chart-data.js"></script>
	<script src="/turinLibrary/js/easypiechart.js"></script>
	<script src="/turinLibrary/js/easypiechart-data.js"></script>
	<script src="/turinLibrary/js/bootstrap-datepicker.js"></script>
	<script src="/turinLibrary/js/bootstrap-table.js"></script>
	<script>
		!function ($) {
			$(document).on("click","ul.nav li.parent > a > span.icon", function(){		  
				$(this).find('em:first').toggleClass("glyphicon-minus");	  
			}); 
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function () {
		  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function () {
		  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
		})
	</script>	
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