<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
 <jsp:include page="../1_main_header.jsp"/>  

<HTML>
<HEAD>
<TITLE> Announcement </TITLE>

<script language="JavaScript">

</script>
</HEAD>
<BODY>
<br>
<br>
<br>
<br>
<br>
<br>
<%
request.setCharacterEncoding("utf-8");
String owner = (String)session.getAttribute("ID");
String member = (String)session.getAttribute("ID");

String pageNum = request.getParameter("pageNum");


if(pageNum == null){
	pageNum = "1";
}

int listSize = 15;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * listSize + 1; 
int endRow = currentPage * listSize;
int lastRow = 0;	
int i = 0;
int num[] = {0};

ResultSet rs = null;
Connection conn = null;

String dbID="root";
String dbPassword="1234";

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
Class.forName("com.mysql.jdbc.Driver").newInstance();

conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

Statement stmt = conn.createStatement();

String strSQL = "";
String key = "owner";
String flag=""; //첫번쨰 쓴글인지알아보기위해서


int count = 0;

	strSQL = "SELECT count(*) FROM tblnoticeboards";


rs = stmt.executeQuery(strSQL);
rs.next();
lastRow = rs.getInt(1);

rs.close();  
%> 
<div class="container">

<div class="row">

	<div class="col-md-10">
		<div class="row tabs">
			<div class="title">
					<div class="row">
 					<div class="col-md-12 text-center"><font size='3'><b> Announcement Board </b></font></div>

	 				

								</div>

					<div class="row">
        			<div class="content-wide">
					<div class="col-md-12">
					<div class="panel panel-default">

					<div class="panel-body">
					<table class="table table-striped table-hover table-border">
	           		 <thead>
	           		 	<tr>
	           		 		<th> Number </th>
	           		 		<th> Subject </th>
	           		 		<th> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Writer </th>
	           		 		<th> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;registered time </th>
	           		 		<th> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;modified time  </th>
	           		 	</tr>
	           		 </thead>
	           		 <tbody>
           		 	
				<%
				if(lastRow > 0) 
				{
						strSQL = "SELECT * FROM tblnoticeboards WHERE num";
						rs = stmt.executeQuery(strSQL);

				
				
						while(rs.next()){
				
						int listnum = (lastRow-(currentPage-1)*listSize)-(i-1);
						int number = Integer.parseInt(rs.getString("NUM"));
						String subject = rs.getString("SUBJECT");
						String writer = rs.getString("WRITER");
						String contents = rs.getString("CONTENTS");
						String reg_date = rs.getString("REG_DATE");
						String mod_date = rs.getString("MOD_DATE");
						
						
				%>
					<tr>     
						<td><%=number %></td>     
						<td>
							<a href="7_Announcement_view.jsp?number=<%=number %>">
							<%=subject %></a>
						</td>
						<td align=center> <%=writer %>   
						</td>     
						<td align=center><%=reg_date.substring(0,16) %>    
						<td align=center><%=mod_date.substring(0,16) %>
						</td>   
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
       		 
		
<%
rs.close();
stmt.close();
conn.close();


if(lastRow > 0) {
	int setPage = 1;
	int lastPage = 0;
	if(lastRow % listSize == 0)
		lastPage = lastRow / listSize;
	else
		lastPage = lastRow / listSize + 1;

	if(currentPage > 1) {	
	}
%>
<div class="text-center">
	<ul class="pagination">
		<li><a href="6_qna_mypage.jsp?pageNum=1"> &laquo;</a></li>
		<li class="active"><a href="6_qna_mypage.jsp?pageNum=1"> 1 </a></li>	
<% 	
	while(setPage <= lastPage && setPage!=1) { //One page , so laid define , except for page 1 , and dynamically generate the list to when the setPage lastPage.
		
%>
			<li><a href="6_qna_mypage.jsp?pageNum=<%=setPage%>"><%=setPage%></a></li>
<%
		setPage = setPage + 1;
	}
	if(lastPage > currentPage) {
%>
		<li><a href="6_qna_mypage.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	
	
<%
	}else{
%>
	<li><a href="6_qna_mypage.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	
	
<%
	}
}
%> 
</ul>
</div></div>                  
	</div></div></div></div> 
                  
</BODY>                     
</HTML>
