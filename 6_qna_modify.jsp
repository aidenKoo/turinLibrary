<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<jsp:include page="1_main_header.jsp"/>  
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE> Q & A board </TITLE>

<SCRIPT language="JavaScript">
function Check()
{
if (Modify.title.value.length < 1) {
	alert("Insert article title");
	Modify.title.focus(); 
	return false;
        }

if (Modify.contents.value.length < 1) {
	alert("Write article contents");
	Modify.contents.focus(); 
	return false;
        }

/* Modify.submit(); */
}

function list()
{
location.href = "6_qna_listboard.jsp";
}

</SCRIPT>
</HEAD>

<BODY>

<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("num"); 

PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;

String dbID="root";
String dbPassword="1234";

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
Class.forName("com.mysql.jdbc.Driver").newInstance();

conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);


try {

String strSQL = "SELECT * FROM tblQnABoard WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();

String memberID = rs.getString("memberID"); // 
String title = rs.getString("title");
String contents = rs.getString("contents").trim();
String writedate = rs.getString("writedate");
int readcount = rs.getInt("readcount");
String owner = rs.getString("owner");

%>
<div class="title">
<div class="row">
<div class="col-md-12"><h5><center> Q&A board</center></h5></div></div></div>
<div class="container">
<div class="panel panel-default">
	<div class="panel-heading text-center">
		<h5 class="panel-title"> QnA article modify</h5>
	</div>
	
	<div class="panel-body">
	<Form name="modify" action="6_qna_write_input.jsp" method="post" OnSubmit="return Check()">
	<input type='hidden' name='num' value='<%=num %>'>
	<input type='hidden' name='memberID' value="<%=memberID %>">
	
	<table class="table table-border">
	<tbody>	
		<tr><td>
		<div class="form-group" style="display:block">
		
		<%	if(memberID.equals("Admin")) { %>
			<label class="col-sm-2"><b> Questioner  </b> </label>
			<div class="col-sm-5">
			<%= owner %>
		<% }else{ %>
			<label class="col-sm-2"><b> Writer  </b> </label>
			<div class="col-sm-5">
			<%= memberID %>
		<% } %>
		</div></div></div>
		</td></tr>
		
		<tr><td>
		</td></tr>
		
		<tr><td>
			<div class="form-group">
			<label class="col-sm-2 control-label"><b>Article Title</b></label>
			<div class="col-sm-8">
			<input type="text" name="title" value="" class="form-control" value="title"/>
			</div>
			</div>
		</td></tr>		

		<tr><td>
			<div class="form-group">
			<div class="col-xs-12">
			<textarea name="contents" class="form-control" rows="20"><%=contents %></textarea>
			</div>
			</div>
		</tr></td>
	</tbody></table>
		<div class="text-center">
		<input type="reset" value="Rewrite" class="btn btn-sm btn-primary btn-embossed mlm"/>	
		<input type="submit" value="Submit modifying" class="btn btn-sm btn-primary btn-embossed mlm"/>
		<a href="javascript:history.go(-1);" class="btn btn-sm btn-primary btn-embossed mlm">Go back</a>
		</div
		>
	</Form>
	
	</div></div></div>          


<%
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


