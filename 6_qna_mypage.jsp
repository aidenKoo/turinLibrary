<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
 <jsp:include page="1_main_header.jsp"/>  

<HTML>
<HEAD>
<TITLE> Q & A Board  </TITLE>

<script language="JavaScript">
	function Check(){
		if(Form.userID.value.length < 1){
			alert("Please enter your search term.");
			Form.userID.foucs();
				return false;
		}
	}

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

if(member == null){//If the logged-in user not return to the main page .
	response.sendRedirect("1_main_index.jsp");
}
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

 if(key == null || owner == null ){
	strSQL = "SELECT count(*) FROM tblqnaBoard";
}else{
	strSQL = "SELECT count(*) FROM tblqnaBoard WHERE owner" + " like '%" + owner + "%'";
}

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
 					<div class="col-md-12 text-center"><font size='3'><b> Q&A Board </b></font></div>
					<div class="col-md-12 text-center"> ' <%=owner %> ',Your list of questions . </div>
	 				
					<div class="pull-right">
					<a href="6_qna_write.jsp" class="btn btn-primary "><span class="glyphicon glyphicon-pencil"></span> register </a>
					</div>
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
	           		 		<th> Article Title </th>
	           		 		<th> Writer </th>
	           		 		<th> Date </th>
	           		 		<th> Answer presence </th>
	           		 		<th> Views  </th>
	           		 	</tr>
	           		 </thead>
	           		 <tbody>
           		 	
				<%
				if(lastRow > 0) {
					if(key==null || owner==null){
						strSQL = "SELECT * FROM tblqnaboard WHERE num BETWEEN " + startRow + " and " + endRow + "ORDER BY num DESC";
						rs = stmt.executeQuery(strSQL);
					} else {
						strSQL = "SELECT * FROM tblqnaboard WHERE " + key + " like '%" + owner + "%' ORDER BY num DESC";
						rs = stmt.executeQuery(strSQL);
					}
				
					for (i = 1; i < listSize; i++){			
						while(rs.next()){
				
						int listnum = (lastRow-(currentPage-1)*listSize)-(i-1);
						int number = rs.getInt("num");
						String memberID = rs.getString("memberID");
						String title = rs.getString("title");
						String writedate = rs.getString("writedate");
						int readcount = rs.getInt("readcount");
						String hasAnswer = rs.getString("hasAnswer");
						if(hasAnswer==null){
							hasAnswer ="";
						}
						
				%>
					<tr>     
						<td><%=number %></td>     
						<td>
							<a href="6_qna_write_output.jsp?number=<%=number %>">
							<%=title %></a>
						</td>
						<td align=center> <%=memberID %>   
						</td>     
						<td align=center><%=writedate %>
						</td> 
						<td align=center><%=hasAnswer %>    
						<td align=center><%=readcount %>
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
}

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
