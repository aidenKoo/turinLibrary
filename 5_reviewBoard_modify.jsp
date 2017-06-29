<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
  <jsp:include page="1_main_header.jsp"/>  

<HTML>
<HEAD>
<TITLE> Review board </TITLE>

<SCRIPT language="JavaScript">
$(window).on('load', function ()
		{
		    $('.selectpicker').selectpicker(
		    {
		        'selectedText': 'cat'
		    });
		});

function Check()
{
if (Modify.name.value.length < 1) {
	alert("Insert Writer");
	Modify.name.focus(); 
        return false;
	}


if (Modify.title.value.length < 1) {
	alert("Insert Title");
	Modify.title.focus(); 
	return false;
        }

if (Modify.contents.value.length < 1) {
	alert("Write Contents");
	Modify.contents.focus(); 
	return false;
        }

Modify.submit();
}

function list()
{
location.href = "5_reviewBoard_listboard.jsp";
}

$(function() {
    $('div#star').raty({ //별점
        score: 3
        ,path : "../img"  // 이미지 폴더 경로 지정.
        ,click: function(score, evt) {
            $("#starRating").val(score);
            $("#displayStarRating").html(score);
        }
    });
});

$('div').raty({
  cancel : true,
  target : '#hint',

});



</SCRIPT>
</HEAD>

<BODY>
	
<br>
<br>
<br>
<br>
<br>
<%
String num = request.getParameter("num"); 
String bookCode = request.getParameter("bookCode");
Class.forName("com.mysql.jdbc.Driver").newInstance();

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Connection conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);


PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	String strSQL = "SELECT * FROM tblbook WHERE bookCode = ?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setString(1, bookCode);
	rs = pstmt.executeQuery();
	rs.next();
	String bookTitle = rs.getString("bookTitle");
	
strSQL = "SELECT * FROM tblReview WHERE num = ? and bookCode = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.setString(2, bookCode);

rs = pstmt.executeQuery();
rs.next();

String memberID = rs.getString("memberID");
String title = rs.getString("title");
String contents = rs.getString("content").trim();
String date = rs.getString("date");
int views = rs.getInt("views");

%>
                  
<div class="title">
<div class="row">
<div class="col-md-12"><h5><center>Review board</center></h5></div></div></div>
<div class="container">
<div class="panel panel-default">
	<div class="panel-heading text-center">
		<h5 class="panel-title"> Modify review</h5>
	</div>
	
<div class="panel-body">
	<FORM Name='Modify' Action='5_reviewBoard_modify_output.jsp' Method='POST' OnSubmit='return Check()'>
	<input type='hidden' name='num' value='<%=num %>'>
		<table class="table table-border">
	<tbody>
	<tr><td>
		<div class="form-group">
		<label class="col-sm-2">Writer</label>
		<div class="col-sm-3">
		<input type="text" name="memberID" value="<%=memberID %>" class="form-control" placeholder="Writer"/>
		</div>
		</div>
	</td></tr>
		

	<tr><td>
		<div class="form-group" style="display:block">
		<label class="col-sm-2 control-label">Book Title</label>
		<div class="col-sm-5">
		<input type="text" name="bookTitle" value="<%=bookTitle %>" class="form-control" placeholder="Book Title"/>
		<input type="hidden" name="bookCode" value="<%=bookCode %>"  placeholder="Book Code"/>
		</div>
		</div>
	</td></tr>
		
	<tr><td>
		<div class="form-group">
		<label class="col-sm-2 control-label">Review title</label>
		<div class="col-sm-8">
		<input type="text" name="title" value="<%=title %>" class="form-control" placeholder="Review title"/>
		</div>
		</div>
	</td></tr>
	
	
	<tr><td>
		<div class="form-group">
		<div class="col-xs-12">
		<textarea name="contents" class="form-control" rows="20"> <%=contents %></textarea>
		</div>
		</div>
	</tr></td>
	
		</tbody>
	</table>
	<div class="text-center">	
	<input type="submit" value=" write" class="btn btn-sm btn-primary btn-embossed mlm"/>
	<a href="javascript:history.go(-1);" class="btn btn-sm btn-primary btn-embossed mlm">Go back</a>
	</Form>	
	</div>
	</div>
</div>


<%System.out.println(bookCode);
}catch(SQLException e){
   	out.print("SQL error ¯ " + e.toString());
}catch(Exception ex){
   	out.print("JSP error ¯ " + ex.toString());
}finally{  
	rs.close();
	pstmt.close();
	conn.close();
}
%>

</BODY>
</HTML>


