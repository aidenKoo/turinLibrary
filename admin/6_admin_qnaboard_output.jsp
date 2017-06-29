<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import = "java.sql.*, java.util.*" %>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">

  <jsp:include page="6_admin_header.jsp"/>   
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Admin main
                            </li>
                        </ol>
                    </div>
                </div><!-- /.row -->

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

String memberID = rs.getString("memberID");
String title = rs.getString("title");
String contents = rs.getString("contents").trim();
String writedate = rs.getString("writedate");
String owner = rs.getString("owner");
int readcount = rs.getInt("readcount");
%>
                <div class="row">
<div class="panel panel-default">
	<div class="panel-heading text-center">
		<h5 class="panel-title"> <%=title %></h5>
	</div>

	<div class="panel-body">
		<table class="table table-border">
			<thead>
       		 	<tr>
       		 		<th> Writer </th>	<td> <%=memberID %></td> <th> Writer </th> <td> : <%=writedate %></td>
       		 		<th> Views  </th> <td> <%=readcount %>  </td>
       		 	</tr>
       		 	</thead>
       		 	
       		 </table>
       		<table  class="table table-border">
			<tr>
	        <td>  <%=contents %> </td>
	        </tr>
		</table>
		</div>
	</div>
	


<div class="text-center">
			<a href="6_admin_qna_delete.jsp?num=<%=num %>" class="btn btn-primary btn-embossed mlm"> <i class="fa fa-trash"></i>삭제하기  </a>		
			<a href="javascript:history.go(-1);" class="btn btn-default btn-embossed mlm">Go back</a>
			<a href="6_admin_qna_reply.jsp?num=<%=num%>" class="btn btn-success btn-embossed mlm">Reply</a>			
</div>

<%
strSQL = "UPDATE tblQnABoard SET readcount=readcount+1 WHERE num = ?";
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

</div>
                </div>  <!-- /.row -->



            </div> <!-- /.container-fluid -->

        </div> <!-- /#page-wrapper -->
    </div><!--  end wrapper -->
