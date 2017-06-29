<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
  <jsp:include page="1_main_header.jsp"/>  
<!DOCTYPE html>
<HTML>
<HEAD>

<TITLE> Q&A board </TITLE>

<%
String memberID = (String)session.getAttribute("ID");


ResultSet rs = null;
Connection conn = null;

String dbID="root";
String dbPassword="1234";

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
Class.forName("com.mysql.jdbc.Driver").newInstance();

conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

Statement stmt = conn.createStatement();

String strSQL = "";




%>
<SCRIPT language="JavaScript">
function Check()
{
if (Write.name.value.length < 1) {
	alert("Insert writer Info");
	Write.name.focus(); 
        return false;
	}

if (Write.pass.value.length < 1) {
	alert("Insert password");
	Write.pass.focus(); 
	return false;
	}

if (Write.title.value.length < 1) {
	alert("Write article title");
	Write.write_title.focus(); 
	return false;
        }

if (Write.contents.value.length < 1) {
	alert("Write contents");
	Write.content.focus(); 
	return false;
        }

//Write.submit();
}

</SCRIPT>
</HEAD>

<BODY>
<br>
<br>
<br>
<br>
<br>
<br>
<div class="title">
<div class="row">
<div class="col-md-12"><h5><center> Q&A board</center></h5></div></div></div>
<div class="container">
<div class="panel panel-default">
	<div class="panel-heading text-center">
		<h5 class="panel-title"> Write</h5>
	</div>
	
	<div class="panel-body">
	<Form name="write" action="6_qna_write_input.jsp" method="post" OnSubmit="return Check()">
	<input type="hidden" name="memberID" value="<%=memberID %>">
	<table class="table table-border">
	<tbody>
	<tr><td>
		<div class="form-group">
		<label class="col-sm-2"> ID </label>
		<label class="col-sm-3"> <b><%=memberID%></b> </label>
		
		</div>
		</div>
	</td></tr>

	<tr><td>

		</div>
	</td></tr>
	
		
	<tr><td>
		<div class="form-group">
		<label class="col-sm-2 control-label"><b>Article title</b></label>
		<div class="col-sm-8">
		<input type="text" name="title" value="" class="form-control" placeholder="Article title"/>
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
	<input type="submit" value=" Register " class="btn btn-sm btn-primary btn-embossed mlm"/>
	<a href="javascript:history.go(-1);" class="btn btn-sm btn-primary btn-embossed mlm">Go back</a>
	</div>
</Form>
</div></div></div>
	

</BODY>
</HTML>