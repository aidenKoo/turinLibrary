<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import = "java.sql.*, java.util.*" %>
   
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
  <jsp:include page="6_admin_header.jsp"/>   
 <script language="JavaScript">
$(window).on('load', function ()
		{
/* 		    $('.selectpicker').selectpicker(
		    {
		        'selectedText': 'cat'
		    }); */
		});

	function Check(){
		if(Form.keyword.value.length < 1){
			alert("Please enter your search term.");
			Form.keyword.foucs();
				return false;
		}
	}

	
</script>

<%
request.setCharacterEncoding("utf-8");

String classification = request.getParameter("classification");
String keyword = request.getParameter("keyword");
String member = (String)session.getAttribute("memberID");

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

Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");


Connection conn = null;
ResultSet rs = null;

String dbID="root";
String dbPassword="1234";

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
Class.forName("com.mysql.jdbc.Driver").newInstance();

conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

Statement stmt = conn.createStatement();

String strSQL = "";

if(classification == null || keyword == null){
	strSQL = "SELECT count(*) FROM tblqnaBoard";
}else{
	strSQL = "SELECT count(*) FROM tblqnaboard WHERE "+ classification + " like '%" + keyword + "%'";
}

rs = stmt.executeQuery(strSQL);
rs.next();
lastRow = rs.getInt(1);

rs.close();
%>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Q & A for admin
                            </li>
                        </ol>
                    </div>
                </div><!-- /.row -->
           



                <div class="row">
	<div class="col-md-11">
		<div class="row tabs">
			<div class="title">
					<div class="row">
					<div class="col-md-11"><h5><center>Q & A Board [ Admin ]</center></h5></div>
					</div>

					<div class="row">
        			<div class="content-wide">
					<div class="col-md-12">
<ul class="nav nav-tabs">
<li class = "active">
<a href="#waiting" data-toggle="tab"> Unanswered List</a></li> <!-- 현재 진행중인 이벤트 목록을 출력하는 탭입니다. -->
<li>
<li>
<a href="#QnAList" data-toggle="tab"> Total Q & A List</a></li> <!-- 현재 진행중인 이벤트 목록을 출력하는 탭입니다. -->
</ul>

<div class="tab-content">

<div class="tab-pane active" id="waiting">

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
					
						strSQL = "SELECT * FROM tblQnABoard  Where hasAnswer = 'N' ORDER BY num DESC";
						rs = stmt.executeQuery(strSQL);
					
				
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
							<a href="admin_qboard_output.jsp?num=<%=listnum %>">
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
				}
				%>
				</tbody>
				</table>
				</div>
				
			</div>
</div><!--  end waiting List -->


<div class="tab-pane" id="QnAList">
					<div class="panel panel-default">

					<div class="panel-body">
					<table class="table table-striped table-hover table-border">
	           		 <thead>
	           		 	<tr>
	           		 		<th> Number </th>
	           		 		<th> Article title </th>
	           		 		<th> Writer </th>
	           		 		<th> Date </th>
	           		 		<th> Answer presence </th>
	           		 		<th> Views  </th>
	           		 	</tr>
	           		 </thead>
	           		 <tbody>
	           		 	
				<%
				if(lastRow > 0) {
					if(classification==null || keyword==null){
						strSQL = "SELECT * FROM tblqnaboard WHERE num BETWEEN " + startRow + " and " + endRow + "ORDER BY num DESC";
						rs = stmt.executeQuery(strSQL);
					} else {
						strSQL = "SELECT * FROM tblqnaboard WHERE " + classification + " like '%" + keyword + "%' ORDER BY num DESC";
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
							<a href="6_admin_qnaboard_output.jsp?num=<%=listnum %>">
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
				}
				%>
				</tbody>
				</table>
				</div>
				
			</div>
<div class="text-center">
		<FORM Name='Form' class="form-inline" Method='POST' Action='admin_qboard.jsp' OnSubmit='return Check()'>
		<input type='hidden' name='search' value='1'>
		<div class="form-group">
			<span class="col-md-4">
			<select name='classification' class="selectpicker form-control">
			<option value='title' selected>
	                                                     Article Title </option>
			<option value='contents'>
	                                                    Contents</option>
			<option value='memberID'>
	                                                      Writer</option>
			</select>
			</span>
			<span class="col-md-5">
			<input type='text' placeholder="Search" class="form-control " name='keyword' value=''>
			</span><span class="col-md-3">
			<input type='submit' class="btn btn-default" value='Search'>
			</span>
		</div>
	  </FORM>
 </div>
</div><!--  end QnAList -->
</div><!--  end tab content -->


		


	  
		</div>
	</div></div>
	
	
	</div></div>           		 
		
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
		<li><a href="6_admin_qnaboard.jsp?pageNum=1"> &laquo;</a></li>
		<li class="active"><a href="6_admin_qnaboard.jsp?pageNum=1"> 1 </a></li>	
<%	
while(setPage <= lastPage&& setPage!=1) { //One page , so laid define , except for page 1 , and dynamically generate the list to when the setPage lastPage.

%>
			<li><a href="6_admin_qnaboard.jsp?pageNum=<%=setPage%>"><%=setPage%></a></li>
<%
		setPage = setPage + 1;
	}
	if(lastPage > currentPage) {
%>
		<li><a href="6_admin_qnaboard.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	
<%
	}else{
%>
		<li><a href="6_admin_qnaboard.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	

<%
	}
}
%>  
</ul></div></div>



                </div>  <!-- /.row -->



            </div> <!-- /.container-fluid -->

        </div> <!-- /#page-wrapper -->
    </div><!--  end wrapper -->
