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
	function boardWriteCheck() {
		var form = document.boardWriteForm;
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
		return true;
		
	}
</script>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	%>
</head>

<body>
<div class="col-sm-9 col-sm-offset-2 main">	
<form class="form-horizontal " role="form" enctype="Multipart/form-data"  method="post" name="boardWriteForm" action="8_admin_ebookProcess.jsp"  onsubmit="return boardWriteCheck();">		

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
			"jdbc:mysql://localhost:3310/dbturinlibrary", "root", "1234");


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
     

    </select>
  </div>
</div>
<table class="table table-striped" style="background-color:transparent;"">
<tr>
<th class="text-center col-md-2" >Title</th>
<td><input type="text" name="bookTitle" class="form-control input-lg"></td>
</tr>
<tr>
<th class="text-center col-md-2" >Author</th>
<td><input type="text" name="author" class="form-control input-lg"></td>
</tr>
<tr>
<th class="text-center col-md-2" >Publisher</th>
<td><input type="text" name="publisher" class="form-control input-lg"></td>
</tr>

<tr>
<th class="text-center col-md-2" >Year</th>
<td><input type="number" name="publicationYear" class="form-control input-lg" min ="1800" max = "2100"></td>
</tr>
<tr>
<th class="text-center col-md-2" >content</th>
<td>
<textarea type="text" name="content" rows="10" class="form-control input-lg"></textarea>

</td>
<tr>
<th class="text-center col-md-2" >summary</th>
<td><input type="text" name="summary" class="form-control input-lg" ></td>
</tr>
<tr>
<th class="text-center col-md-2" >Thumbnail</th>
<td><input type="file" name="thumbnail" class="form-control input-lg"><span>*recommended 150*220 (px)</span></td>
</tr>
<tr>
<th class="text-center col-md-2" >Ebook File</th>
<td><input type="file" name="file1" class="form-control input-lg input-file"></td>
</tr>
<tr>
<td></td><td class="col-md-offset-2 text-center"><button type="submit" name="button1" class="btn btn-primary" id="button1" OnClick="javascript:boardWriteCheck()">Submit</button>
&nbsp;&nbsp;&nbsp;<button type="reset" name="button2" class="btn btn-danger" id="button2" onclick="goUrl('7_admin_BoardList.jsp');">reset </button></td> 
</tr>
</table>
<input type="hidden" name="mode" value="W" />
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
