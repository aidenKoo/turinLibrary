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
	// 등록 폼 체크
	function ebookWriteCheck() {
		var form = document.ebookWriteForm;
		if (form.booktitle.value == '') {
			alert('check booktitle.');
			form.booktitle.focus();
			return false;
		}
		if (form.author.value == '') {
			alert('check author');
			form.writer.focus();
			return false;
		}
		if (form.publicationYear.length() > 5) {
			alert('check publicationYear');
			form.writer.focus();
			return false;
		}
		
		return true;
	}
</script>
<%
out.println("42");
	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// 파라미터
	String bookRequestKey = request.getParameter("bookRequestKey");
	//bookPrimaryKey
	String pageNum = request.getParameter("pageNum");
	String searchType = request.getParameter("searchType");
	String searchText = request.getParameter("searchText");
	String category = request.getParameter("category");
	
	try {
		// 데이터베이스 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");


%>

</head>
<% String bookModifyKey = request.getParameter("bookRequestKey"); %>

<body>
<div class="col-sm-9 col-sm-offset-2 main">	
<form class="form-horizontal" role="form" enctype="Multipart/form-data"  method="post" name="ebookWriteForm" action="8_admin_ebookProcess.jsp"  onsubmit="return ebookWriteCheck();">		

<!-- Form Name -->
<legend>E-book Upload</legend>

<div class="control-group">
  <label class="control-label" for="selectbasic-0">Select Basic</label>
  <div class="controls">
    <select name="category" class="input-xlarge" id="selectbasic-0">
    <%
    		// DB CONNECT
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/dbturinlibrary", "root", "1234");


		// tblcategory connect
		// category 
		pstmt = conn.prepareStatement(
				"SELECT category FROM tblcategory");
		rs = pstmt.executeQuery();
		while(rs.next())
		{ %>
			<option><%=rs.getString("category") %></option>
			<% 
		}
%>
     
<%
// 게시물 상세 조회 쿼리 실행 
pstmt = conn.prepareStatement(
		"SELECT * FROM tblbook WHERE bookPrimaryKey = ?");
pstmt.setString(1, bookRequestKey);
rs = pstmt.executeQuery();
rs.next();
String publicationYear = rs.getString("publicationYear");
String bookTitle = rs.getString("bookTitle");
String author = rs.getString("author");
String publisher = rs.getString("publisher");
String content = rs.getString("content");
String sectionCode = rs.getString("sectionCode");
String summary = rs.getString("summary");
if(publicationYear.equals(""))
{  publicationYear = "empty";        }
if(bookTitle.equals(""))
{  bookTitle = "empty";        }
if(author.equals(""))
{  author = "empty";        }
if(publisher.equals(""))
{  publisher = "empty";        }
if(content.equals(""))
{  content = "empty";        }

%>
<table class="table table-striped" style="background-color:transparent;"">
<tr>
<th class="text-center col-md-2" >Title</th>
<td><input type="text" value = <%=bookTitle %> name="bookTitle" class="form-control input-lg"></td>
</tr>
<tr>
<th class="text-center col-md-2" >Author</th>
<td><input type="text" name="author" value = <%=author %> class="form-control input-lg"></td>
</tr>
<tr>
<th class="text-center col-md-2" >category</th>
<td><input type="text"  value = <%=category %> readonly = "readonly" class="form-control input-lg"></td>
</tr>
<tr>
<th class="text-center col-md-2" >sectionCode</th>
<td><input type="text" name="sectionCode" value = <%=sectionCode %> class="form-control input-lg"></td>
</tr>
<tr>
<th class="text-center col-md-2" >Publisher</th>
<td><input type="text" name="publisher" value = <%=publisher %> class="form-control input-lg"></td>
</tr>

<tr>
<th class="text-center col-md-2" >Year</th>
<td><input type="number" name="publicationYear" min ="1800" max ="2100" value = <%=publicationYear %> class="form-control input-lg"></td>
</tr>

<tr>
<th class="text-center col-md-2" >content</th>
<td>
<textarea type="text" name="content" rows="10" class="form-control input-lg"><%=content %></textarea>

</td>
<tr>
<th class="text-center col-md-2" >summary</th>
<td><input type="text" name="summary" value = <%=summary %> class="form-control input-lg"></td>
</tr>

<tr>
<th class="text-center col-md-2" >Thumbnail</th>
<td><input type="file" name="thumbnail" class="form-control input-lg"  ><span>*recommended 150*220 (px)</span></td>
</tr>
<tr>
<th class="text-center col-md-2" >Ebook File</th>
<td><input type="file" name="file1" class="form-control input-lg input-file" > </td>
</tr>
<tr>
<td></td><td class="col-md-offset-2 text-center"><button type="submit" name="button1" class="btn btn-primary" id="button1" OnClick="javascript:ebookWriteCheck()">Submit</button>
&nbsp;&nbsp;&nbsp;<button type="reset" name="button2" class="btn btn-danger" id="button2" onclick="goUrl('8_admin_ebookList.jsp');">reset </button></td> 
</tr>
</table>
<input type="hidden" name="mode" value="M" />
<input type="hidden" name="bookModifyKey" value="<%=bookModifyKey %>" />
   <!-- mode = Modify -->
</form>
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





