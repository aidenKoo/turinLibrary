<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
  <jsp:include page="1_main_header.jsp"/>  
<!DOCTYPE html>
<HTML>
<HEAD>

<TITLE> Review board </TITLE>

<script type="text/javascript" src="js/jquery.raty.js"></script>
<%
String memberID = (String)session.getAttribute("ID");
String bookCode = request.getParameter("bookCode");
Class.forName("com.mysql.jdbc.Driver").newInstance();

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Connection conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

Statement stmt = conn.createStatement();;
ResultSet rs = null;




String strSQL= "SELECT bookTitle FROM tblbook where bookCode = '" + bookCode + "'" ;


rs = stmt.executeQuery(strSQL);

rs.next();
String bookTitle = rs.getString("bookTitle");
System.out.println(bookTitle);
%>
<SCRIPT language="JavaScript">
function write_Check()
{
if (Write.name.value.length < 1) {
	alert("Insert 'Writer'.");
	Write.name.focus(); 
        return false;
	}


if (Write.title.value.length < 1) {
	alert("Insert 'Article Title'.");
	Write.write_title.focus(); 
	return false;
        }

if (Write.contents.value.length < 1) {
	alert("Write 'Content'.");
	Write.content.focus(); 
	return false;
       }
        
}




</SCRIPT>
</HEAD>

<BODY>
<div class="title">
<div class="row">
<div class="col-md-12"><h5><center> Review Board</center></h5></div></div></div>
<div class="container">
<div class="panel panel-default">
	<div class="panel-heading text-center">
		<h5 class="panel-title"> Writing Review </h5>
	</div>
	
	<div class="panel-body">
	<Form name="write" action="5_reviewBoard_write_input.jsp" method="post" OnSubmit="return write_Check()">
	
	<input type="hidden" name="memberID" value="<%=memberID %>">
	<table class="table table-border">
	<tbody>
	<tr><td>
		<div class="form-group">
		<label class="col-sm-2"> Writer </label>
		<label class="col-sm-3"> <b><%=memberID%></b> </label>
		
		</div>
		</div>
	</td></tr>

	<tr><td>
		<div class="form-group" style="display:block">
		<label class="col-sm-2 control-label"><b>Book Title</b></label>
		<label class="col-sm-5" name="bookTitle" value=<%=bookTitle%>/>
		<%=bookTitle %></label>
		<input type="hidden" name="bookCode" value=<%=bookCode %> />
		</div>
	</td></tr>
	
		
	<tr><td>
		<div class="form-group">
		<label class="col-sm-2 control-label"><b>Article Title</b></label>
		<div class="col-sm-8">
		<input type="text" name="title" value="" class="form-control" placeholder="Article Title" required/>
		</div>
		</div>
	</td></tr>
	
	<tr><td>
		<div class="form-group">
		<div class="col-xs-12">
		<textarea name="contents" class="form-control" rows="5"></textarea>
		</div>
		</div>
	</tr></td>
	
	</tbody>
</table>
	<div class="text-center">	
	<input type="submit" value=" Save " class="btn btn-sm btn-primary btn-embossed mlm"/>
	<a href="javascript:history.go(-1);" class="btn btn-sm btn-primary btn-embossed mlm">Go back</a>
	</div>
</Form>
</div></div></div>
	

</BODY>
</HTML>