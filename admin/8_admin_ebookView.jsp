<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>E-bookAmin</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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


</head>

<%
out.println("42");
	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// 파라미터
	String bookRequestKey = request.getParameter("bookRequestKey");
	String sectionCode = request.getParameter("sectionCode");
	//bookPrimaryKey
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	String category = "";
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");
		

%>

<body>
<div class="col-sm-9 col-sm-offset-2 main">	

<!-- Form Name -->
<legend>E-book View</legend>

<div class="control-group">

</div>
<%
// 데이터베이스 객체 생성


pstmt = conn.prepareStatement(
		"SELECT * FROM tblcategory WHERE sectionCode = ?");
pstmt.setString(1, sectionCode);
rs = pstmt.executeQuery();
rs.next();
category = rs.getString("category");

// 게시물 상세 조회 쿼리 실행 
pstmt = conn.prepareStatement(
		"SELECT * FROM tblbook WHERE bookPrimaryKey = ?");
pstmt.setString(1, bookRequestKey);
rs = pstmt.executeQuery();
rs.next();

%>
<table class="table table-striped" style="background-color:transparent;"">
<tr>
<th class="text-center col-md-2" >Title</th>
<td><%=rs.getString("bookTitle") %></td>
</tr>
<tr>
<th class="text-center col-md-2" >Author</th>
<td><%=rs.getString("author") %></td>
</tr>
<tr>
<th class="text-center col-md-2" >Category</th>
<td><%=category %></td>
</tr>
<tr>
<th class="text-center col-md-2" >sectionCode</th>
<td><%=rs.getString("sectionCode") %></td>
</tr>
<tr>
<th class="text-center col-md-2" >Publisher</th>
<td><%=rs.getString("publisher") %></td>
</tr>

<tr>
<th class="text-center col-md-2" >Year</th>
<td><%=rs.getString("publicationYear") %></td>
</tr>
<tr>
<th class="text-center col-md-2" >content</th>
<td>
<textarea  name="content" rows="10" class="form-control input-lg"  readonly = "readonly">
<%=rs.getString("content") %>
</textarea>
</td>
</tr>
<tr>
<th class="text-center col-md-2" >summary</th>
<td><%=rs.getString("summary") %></td>
</tr>
<tr>
<th class="text-center col-md-2" >Thumbnail</th>
<td><%=rs.getString("thumbnail") %></td>
</tr>
<tr>
<th class="text-center col-md-2" >Ebook File</th>
<td><%=rs.getString("fileDirectory") %></td>
</tr>
<tr>
<td></td><td class="col-md-offset-2 text-center"><button type="submit" name="button1" class="btn btn-primary" id="button1" onclick="goUrl('8_admin_ebookList.jsp');"/>list</button>
&nbsp;&nbsp;&nbsp;
<button type="reset" name="button2" class="btn btn-danger" id="button2" onclick="goUrl('8_admin_ebookModify.jsp?bookRequestKey=<%=bookRequestKey%>&amp;category=<%=category%>');"/>modify</button>
&nbsp;&nbsp;&nbsp;
<button type="reset" name="button2" class="btn btn-danger" id="button2" onclick="deleteCheck('8_admin_delete.jsp?mode=D&amp;bookRequestKey=<%=bookRequestKey%>');"/>delete</button></td> 
</tr>
</table>
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
