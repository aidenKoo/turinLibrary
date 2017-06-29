<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
   
  <jsp:include page="1_main_header.jsp"/>  
  <link href="css/bootstrap-select.min.css" rel="stylesheet" type="text/css"  />
<script src="js/bootstrap-select.min.js" ></script>
   
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE> Q&A board </TITLE>

<script language="JavaScript">
$(window).on('load', function ()
		{
		    $('.selectpicker').selectpicker(
		    {
		        'selectedText': 'cat'
		    });
		});

	function Check(){
		if(Form.keyword.value.length < 1){
			alert("Please enter your search term.");
			Form.keyword.foucs();
				return false;
		}
	}

</script>
<META http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	{font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->
</style>

</HEAD>
<BODY>

<%
request.setCharacterEncoding("utf-8");

String key = request.getParameter("key");
String keyword = request.getParameter("keyword");
String member = (String)session.getAttribute("memberID");
if(member == null){													//If the logged-in user not return to the main page .
	response.sendRedirect("1_main_index.jsp");
}
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

Connection conn = null;

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

Statement stmt = conn.createStatement();



String strSQL = "";
ResultSet rs = null;

if(key == null || keyword == null){
	strSQL = "SELECT count(*) FROM tblQnABoard";
}else{
	strSQL = "SELECT count(*) FROM tblQnABoard WHERE "+ key + " like '%" + keyword + "%'";
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
					<div class="col-md-12"><h5><center>Q & A board [for Admin ]</center></h5></div>
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
	           		 		<th> Writing Date </th>
	           		 		<th> Answer presence </th>
	           		 		<th> Views  </th>
	           		 	</tr>
	           		 </thead>
	           		 <tbody>
	           		 	
				<%
				if(lastRow > 0) {
					if(key==null || keyword==null){
						strSQL = "SELECT * FROM tblqnaBoard WHERE num BETWEEN " + startRow + " and " + endRow + "ORDER BY num DESC";
						rs = stmt.executeQuery(strSQL);
					} else {
						strSQL = "SELECT * FROM tblqnaboard WHERE " + key + " like '%" + keyword + "%' ORDER BY num DESC";
						rs = stmt.executeQuery(strSQL);
					}
				
					for (i = 1; i < listSize; i++){			
						while(rs.next()){
				
						int listnum = rs.getInt("num");
						String memberID = rs.getString("memberID");
						String title = rs.getString("title");
						String writedate = rs.getString("writedate");
						int readcount = rs.getInt("readcount");
						String hasAnswer = rs.getString("hasAnswer");
						
				%>
					<tr>     
						<td><%=listnum %></td>     
						<td>
							<a href="6_qna_write_output.jsp?num=<%=listnum %>">
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
		<div class="pull-right">
		<a href="6_qna_write.jsp" class="btn btn-primary "><span class="glyphicon glyphicon-pencil"></span> Register </a>
		</div>
		
<div class="text-center">
		<FORM Name='Form' class="form-inline" Method='POST' Action='6_qna_listboard.jsp' OnSubmit='return Check()'>
		<input type='hidden' name='search' value='1'>
		<div class="form-group">
			<span class="col-md-4">
			<select name='key' class="selectpicker form-control">
			<option value='title' selected>
	                       Article title </option>
			<option value='contents'>
	                                                    Contents</option>
			<option value='memberID'>
	                                                      Writer</option>
			</select>
			</span>
			<span class="col-md-5">
			<input type='text' placeholder="search" class="form-control " name='keyword' value=''>
			</span><span class="col-md-4">
			<input type='submit' class="btn btn-default" value='search'>
			</span>
		</div>
	  </FORM>
 </div>

	  
		</div>
	</div></div>
	
	
	</div></div>           		 
		
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
		<li><a href="5_reviewBoard_listboard.jsp?pageNum=1"> &laquo;</a></li>
		<li class="active"><a href="5_reviewBoard_listboard.jsp?pageNum=1"> 1 </a></li>	
<%	
while(setPage <= lastPage&& setPage!=1) { //One page , so laid define , except for page 1 , and dynamically generate the list to when the setPage lastPage

%>
			<li><a href="6_qna_listboard.jsp?pageNum=<%=setPage%>"><%=setPage%></a></li>
<%
		setPage = setPage + 1;
	}
	if(lastPage > currentPage) {
%>
		<li><a href="6_qna_listboard.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	
<%
	}else{
%>
		<li><a href="6_qna_listboard.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	

<%
	}
}
%>  
</ul></div></div></div></div>
                  
</BODY>                     
</HTML>
