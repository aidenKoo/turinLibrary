<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<link href="/css/bootstrap-select.min.css" rel="stylesheet" type="text/css"  />
<script src="/js/bootstrap-select.min.js" ></script>

<META http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	{font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->
</style>




<%
request.setCharacterEncoding("utf-8");
String bookCode =  request.getParameter("bookCode");


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

PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);


Connection conn2 = DriverManager.getConnection(jdbcURL,dbID,dbPassword);
PreparedStatement pstmt2 = null;
ResultSet rs2 = null;
String	strSQL2;
strSQL2 = "SELECT * FROM tblbook WHERE bookCode = " + bookCode + "";
pstmt2 = conn2.prepareStatement(strSQL2);
rs2 = pstmt2.executeQuery();
rs2.next();
String bookTitle = rs2.getString("bookTitle");
rs2.close();






int count = 0;

String	strSQL = "SELECT count(*) FROM tblreview WHERE bookCode = " + bookCode + "";
pstmt=conn.prepareStatement(strSQL);
rs = pstmt.executeQuery();

if(rs.next()){
lastRow = rs.getInt(1);
}
%>
<div class="container">

<div class="row">

	<div class="col-md-9">
		<div class="row tabs">
			<div class="title">
					<div class="row">
					</div>
					<div class="row text-center">
        			<div class="content-wide">
					<div class="col-md-9">
					<div class="panel panel-default">

					<div class="panel-body">
					<table class="table table-striped table-hover table-border">
	           		 <thead>
	           		 	<tr>
	           		 		<th> # </th>
	           		 		<th> Title </th>
	           		 		<th> Writer </th>
	           		 		<th> Date </th>
	           		 		<th> Views  </th>

	           		 	</tr>
	           		 </thead>
	           		  <tbody>

	           	<%  		
	           		if(lastRow > 0 && bookCode != null){
	           			strSQL = "SELECT * FROM tblreview WHERE bookCode= " + bookCode + " ORDER BY num DESC";	           			
	           			rs = pstmt.executeQuery(strSQL);

	           		for (i = 1; i < listSize; i++){	

	           			while(rs.next()){
						
	           			int dbnum = rs.getInt("num");
	           			int listnum = lastRow - (listSize * (Integer.parseInt(pageNum)-1)) - count;
	           			String memberID = rs.getString("memberID");
	           			String title = rs.getString("title");
	           			String date = rs.getString("date");
	           			int views = rs.getInt("views");
	           			
	           			
	           			count++;
				%>
	           			<tr>     
						<td><font size=2 color='black'>
				                                    <%=listnum %></font></td>     
						<td>
							<a href="5_reviewBoard_write_output.jsp?num=<%=dbnum %>">
							<font size=2 color="black"><%=title %></font></a>
						</td>
						<td align=center>    
							<font size=2 color="black"><%=memberID %></font></a>     
						</td>     
						<td align=center><font size=2><%=date %></font>
						</td>     
						<td align=center><font size=2><%=views %></font>     
						</td>	 
	           		 </tr>
	           		 <%     
						
						}//end while	
					}//end for
								
	           	}else{

	           	}
				%>
	           		</tbody>
	           		</table>
					</div>
				</div>
			<div class="text-center">  There are <%= count %> reviews. </div>      	
			<div class="pull-right">
	<%if(session.getAttribute("ID")!=null){ %>	
	 	<a href="5_reviewBoard_write.jsp?bookCode=<%=bookCode %>" class="btn btn-primary btn-embossed mlm"><span class="glyphicon glyphicon-pencil"></span> Writing reviews </a>
	<%} %>	
		</div>
		      
          
				
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


	                   
<%



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
		<li><a href="5_reviewBoard_listboard.jsp?pageNum=1"> &laquo;</a></li>
		<li class="active"><a href="5_reviewBoard_listboard.jsp?pageNum=1"> 1 </a></li>	

<% 
	while(setPage <= lastPage&& setPage!=1) { //1페이지는 정의해놓았으므로, 1페이지 제외, setPage가 lastPage 일때까지 리스트를 동적생성한다.
%>
			<li><a href="5_reviewBoard_listboard.jsp?pageNum=<%=setPage%>"><%=setPage%></a></li>
<%
		setPage = setPage + 1;
	}
	if(lastPage > currentPage) {
%>
		<li><a href="5_reviewBoard_listboard.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	
<%
	}else{
%>
		<li><a href="5_reviewBoard_listboard.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	
	
<%		
	}
%>	
	</ul></div> 
<%
}
rs.close();
pstmt.close();
conn.close();
%> 



