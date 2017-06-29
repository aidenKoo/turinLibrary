<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
	<jsp:include page="1_main_header.jsp"/> 

<TITLE> Review Board </TITLE>

<link href="css/jquery.raty.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="js/jquery.raty.js"></script>


<script type="text/javascript">

$(function() {
	var TEMP = document.getElementById('marksValue'); 
    $('div#star').raty({ //Rating
        score: TEMP.value
        ,path : "/img"  // define img directory
        ,readOnly : true
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

</script>

<BODY>

<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("num"); 

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

try {
String strSQL = "SELECT * FROM tblreview WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();

String memberID = rs.getString("memberID");
String title = rs.getString("title");
String content = rs.getString("content").trim();
String date = rs.getString("date");
int views = rs.getInt("views");
String bookCode = rs.getString("bookCode");
%>
<div class="title">
<div class="row">
<div class="col-md-12"><h5><center>Review Board</center></h5></div></div></div>

<div class="container">
<div class="panel panel-default">
	<div class="panel-heading text-center">
		<h5 class="panel-title"> <%=title %></h5>
	</div>
	
	<div class="panel-body">
		<table class="table table-border">
			<thead>
       		 	<tr>
       		 		<th> Writer </th>	<td> <%=memberID %></td> <th> Date </th> <td> : <%=date %></td>
       		 		<th> Views  </th> <td> <%=views %>  </td>
       		 	</tr>
	        </thead>
	     
		</table>	
		<table  class="table table-border">
			<tr>
	        <td>  <%=content %> </td>
	        </tr>
		</table>	
	</div>
</div>


<div class="widget stacked widget-table action-table">




<TABLE border='0' width='600'>
	<TR>
    		<TD align='right'>
		<font size='2'><br><font size='2'></font>
    		</TD>
	</TR>
</TABLE>

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
  	<TR>
  		<TD><hr size='1' noshade>
  		</TD>
  	</TR>
</TABLE>

<TABLE border='0' width='600'>
	<TR>
		<TD align='right'>
			<a href='5_reviewBoard_modify.jsp?num=<%=num%>&bookCode=<%=bookCode%>'>[modify]</a>
			<a href='5_reviewBoard_delete_input.jsp?num=<%=num%>&bookCode=<%=bookCode%>'>[remove]</a>			
			<a href='5_reviewBoard_write.jsp'>[Writing review]</a>
			<a href='5_reviewBoard_listboard.jsp'>[view list]</a>

 		</TD>
	</TR>
</TABLE>

<%
strSQL = "UPDATE tblReview SET views=views+1 WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.executeUpdate();

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


</div></div>
</BODY>
</HTML>
