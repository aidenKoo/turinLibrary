<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*" %>
<jsp:include page="1_main_header.jsp"/>
	<% String basicFileDirectory = "Ebook_Files/"; %> <!--define baisc file directory -->
       <link href="../css/bootstrap-select.min.css" rel="stylesheet" type="text/css"  /> <!--  상세 검색 시 select box를 꾸며주기 위한 css 와 javascript 파일-->
<script src="../js/bootstrap-select.min.js" ></script>


<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<script language="JavaScript">
function show_detail(){	// 사용자가 상세보기 버튼을 눌렀을 경우 실행 됩니다.
	var srch = document.getElementById("srch");
if(srch.style.display=='none'){ 			// 사용자가 상세보기 를 눌렀을 경우 display = none이어서 숨겨져 있던 div 가 보여집니다.
	document.getElementById("srch").style.display='table-row';
}	else{	//display="table-row" 즉, div 가 보여져 있는 상태에서 다시 사용자가 상세보기 버튼을 누르면 div display가 none 으로 설정되며 다시 숨겨집니다.
	document.getElementById("srch").style.display='none';
	
}
}


$(window).on('load', function () //selectbox를 위한 jQuery function
{
    $('.selectpicker').selectpicker(
    {
        'selectedText': 'cat'
    });
});

/* function plus(){
	bookInfo.value = 
	
} */
</script>
<title>Searching result</title>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
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

String classification = request.getParameter("classification");
String keyword = request.getParameter("keyword"); //사용자가 input 창에 입력하는 검색어 입니다.

/* String member = (String)session.getAttribute("memberID");
if(member == null){//로그인 된 유저가 아닐 경우 메인페이지로 돌려보낸다.
	response.sendRedirect("index.jsp");
}
 */
String filter = request.getParameter("filter"); //가겨순, 이름순, 판매량 순 등으로 정렬 할 값을 받습니다.
String option = request.getParameter("option");  // 오름차순인지, 내림차순 인지를 결정합니다.
String pageNum = request.getParameter("pageNum"); //페이지 번호를 출력하기 위해 현재 페이지 번호를 받아옵니다. request Page 값이 없을 경우 ,기본 값을 1로 설정합니다.
if(pageNum == null){
	pageNum = "1";
}

int listSize = 15;  //한 페이지에 보여지는 리스트의 개수입니다.
int currentPage = Integer.parseInt(pageNum); //현재 페이지는 위의 코드에서 reuqest.getParameter로 받아온 값을 int로 변환합니다. (값 비교를 위해)
int startRow = (currentPage - 1) * listSize + 1;  //페이지 내의 제일 위의 행 번호입니다.
int endRow = currentPage * listSize; // 페이지 내의  제일 아래 행 번호입니다. ex ) 2페이지일 경우 30 번째 행
int lastRow = 0;	
int i = 0;
int num[] = {0};

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Class.forName("com.mysql.jdbc.Driver").newInstance();
con = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

String strSQL = "SELECT count(*) FROM tblBook";

 if(keyword == ""||keyword == null||classification==null){ //사용자가 검색 기능을 수행하지 않은 경우, key 나 keyword가 null 이므로, SQL문을 실행하지 않습니다..
	strSQL = "SELECT count(*) FROM tblBook";
}


else if(classification.equals("all")){ //all일 경우 모든 컬럼에서 검색

	strSQL = "SELECT * FROM tblBook WHERE bookTitle like '%" + keyword + "%' or "
			+ "author like '%"  + keyword + "%' or "
			+ "publisher like '%" + keyword + "%' or "
			+ "publicationYear like '%" + keyword + "%' or "
			+ "summary like '%" + keyword + "%' or "
			+ "content like '%" + keyword + "%'or "
			+ "sectionCode = (SELECT sectionCode from tblcategory where category like '%" + keyword +"%')";
}else if(classification.equals("section")){
	strSQL = "select * from tblbook where sectionCode = (select sectionCode from tblcategory where category like '%literature%')";
}
else{ //사용자가 검색기능을 수행하는 경우, Key 를 기준으로 해당하는 keyword(user가 input창에 입력한 값)으로 검색합니다.
	strSQL = "SELECT count(*) FROM dbturinlibrary.tblbook WHERE "+ classification + " like '%" + keyword + "%'";
}
pstmt=con.prepareStatement(strSQL);

rs = pstmt.executeQuery();
rs.next();
lastRow = rs.getInt(1);
%>

<div class="container">
<br>
<br>
<br>
<br>
<br>
<br>
<div class="row">

	<div class="col-md-8">
		<div class="row tabs">
<!-- 			<div class="title">
					<div class="row">
					<div class="col-md-9"><h5><center>검색 결과</center></h5></div>
					</div>
					<a href="#" class="btn btn-default" onclick="show_detail()"><span class="glyphicon glyphicon-zoom-in"></span> 상세 검색 </a>

					<div class="form-group">
					<div id="srch" style="display:none">
					<div class="well">
					<a onclick="show_detail()"></a>

					<div class="text-center"> 상세 검색 기능
					
					<FORM Name='Form' class="form-inline" Method='get' Action='3_search_result.jsp'>
					<input type='hidden' name='search' value='1'>
					
										<div class="form-group">
						<span class="col-md-4">
						<select name='classification' class="form-control selectpicker input-sm">  상세 검색 할 수 있는 필드  옵션입니다.
						<option value='bookTitle' selected>Title </option>
						<option value='author'>author</option>
						<option value='publisher'>publisher</option>
						</select>
						</span>

						<span class="col-md-5">
						<input type='text'  placeholder="검색" class="form-control" name='keyword' value='' required>  검색 기능 수행 시 input 창에 반드시 내용을 입력 해야 submit이 되도록 required 를 추가했습니다.
						</span><span class="col-md-3">
						<input type='submit' class="btn btn-default" value='검색'>
						</span>
					 </div>
				 	 </FORM>
					</div></div></div></div>
					
					</div>--></div>  
					
				<div class="text-right">
					<div class="btn-group"> <!--  정렬 기준은 이름순 / 가격순/ 판매량순으로 전송 할 수 있으며, a href 링크를 통해 get 방식으로 keyword 와 filter(정렬방식), option(오름/내림차순)을 전달합니다. -->
					  <button class="btn btn-default" type="button">정렬</button>
					  <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button"><span class="caret"></span>
					  </button>
					   <ul class="dropdown-menu">
						  <center>
		  		   		 	  <li><a href="3_search_result.jsp?keyword=<%=keyword%>&filter=bookTitle&option= asc">Book Title</a></li>
						 	  <li><a href="3_search_result.jsp?keyword=<%=keyword%>&filter=cost&option= asc">Author</a></li>
							  <li><a href="3_search_result.jsp?keyword=<%=keyword%>&filter=cost&option= asc">Publisher</a></li>
							  <li><a href="3_search_result.jsp?keyword=<%=keyword%>&filter=cost&option= desc">Publication Year</a></li>
							  <li><a href="3_search_result.jsp?keyword=<%=keyword%>&filter=cost&option= asc">Subject</a></li>
							  <li><a href="3_search_result.jsp?keyword=<%=keyword%>&filter=cost&option= asc">Section</a></li>
							  <li><a href="3_search_result.jsp?keyword=<%=keyword%>&filter=sales&option= desc">Number of download</a></li>
							  <li><a href="3_search_result.jsp?keyword=<%=keyword%>&filter=cost&option= desc">Rating</a></li> <!-- 이부분은 다시 쿼리를 만저야함! -->
					  	  </center>
					  	</ul>
  					</div>
  				</div> <!--  filter . 정렬 기능 끝 -->
  					
  					 <hr>
   				 <!-- Page Content -->
  				  <div class="container">

   			     <!-- Page Heading -->
   				     <div class="row">
  				          <div class="col-lg-9">
               				 <h1 class="page-header">Search Result
                    		 <small>Book</small>
             			     </h1>
            		 	  </div>
       			     </div>
        <!-- /.row -->

			<%
			if(lastRow==0){
				%>
						<h3>No results were found for your search.</h3>
				<%
			}
				if(lastRow > 0) { 
					if(keyword==""||keyword==null||classification==null){ // key나 keyword가 입력되지 않았으면, 전체 목록을 불러옵니다.
						strSQL = "SELECT * FROM tblBook";
						rs = pstmt.executeQuery(strSQL);
					}else if(classification.equals("all")){

							strSQL = "SELECT * FROM tblBook WHERE bookTitle like '%" + keyword + "%' or "
							+ "author like '%"  + keyword + "%' or "
							+ "publisher like '%" + keyword + "%' or "
							+ "publicationYear like '%" + keyword + "%' or "
							+ "summary like '%" + keyword + "%' or "
							+ "content like '%" + keyword + "%'or "
							+ "sectionCode = (SELECT sectionCode from tblcategory where category like '%" + keyword +"%')";
							
							rs = pstmt.executeQuery(strSQL);
					}else if(classification.equals("section")){
						strSQL = "select * from tblbook where sectionCode = (select sectionCode from tblcategory where category like '%literature%')";
						rs = pstmt.executeQuery(strSQL);
					}else { //filter 값이 null, 기본 검색을 했을 경우
						strSQL =  "SELECT * FROM tblBook WHERE "+ classification + " like '%" + keyword + "%'"; 
						rs = pstmt.executeQuery(strSQL);
					}
					
					if(filter != null){ //사용자가 정렬 기능을 사용했을 경우, classification(찾을 목록) keyword(사용자가 입력한 값)을 filter(정렬 목록) 에서 option(오름차순/내림차순)으로 정렬한 목록을 불러옵니다.
						strSQL = "SELECT * FROM tblBook WHERE "+ classification + " like '%" + keyword + "%' ORDER BY " + filter+option; 
						if(filter.equals("cost")){ //가격의 경우 int로 type casting을 합니다. (하지 않을 경우, 1, 10, 2, 3 이런 식으로 출력되기 때문에 cost(가격으로 검색 했을 경우, cast (cost as int)를 해주어야 합니다.)
 							strSQL = "SELECT * FROM tblBook WHERE "+ classification + " like '%" + keyword + "%' ORDER BY cast("+filter +" as int)"+option;
					}
						rs = pstmt.executeQuery(strSQL); // 쿼리 문을 수행합니다.
				}
					
						for (i = 1; i < listSize; i++){			
						while(rs.next()){
							
						String bookCode = rs.getString("bookCode");
							
						String thumbnail = basicFileDirectory + rs.getString("thumbnail");
						String bookTitle = rs.getString("bookTitle");
 						String author = rs.getString("author");
						String publisher = rs.getString("publisher");
						String publicationYear = rs.getString("publicationYear");
						String subject = rs.getString("subjectCode");
						String section = rs.getString("sectionCode");
						String summary = rs.getString("summary");	
						
						int numberOfDownload/* = rs.getInt("numberOfDownload") */;
						String rating="";  /* 추후 구현 */
				        
				        if(thumbnail==null||thumbnail==""){
				        	thumbnail="img/no_image.jpg";
				        }
				           	
						
				%>		
					    <!-- Page Content -->
     				    <!-- Project One -->
     				   <div class="row">
     				       <div class="col-md-3">
     				           <a href="#">

       		 	       		        <img class="img-responsive" src="<%=thumbnail %>" alt="#" class="img-thumbnail img-responsive" width="200" height="200" >
            				   	
            				   </a>
            			   </div>
           				   <div class="col-md-5">
                				<h3><%=bookTitle%></h3>
                				<h4><%=author%></h4>
                				<h5><%=publisher%>	published in <%=publicationYear%></h5>
                				<%-- <h5>section: <%=section%>	subject<%=subject%></h5> --%>
             	  				<p><%=summary%></p>
             				 	<a class="btn btn-primary" href="4_bookDetail_details.jsp?bookCode=<%=bookCode%>">View Details <span class="glyphicon glyphicon-chevron-right"></span></a>
            				</div>
        				</div>
        				<!-- /.row -->

				        <hr>
                

					<!-- end project -->
				<%		
					}
					
				}
			}
				%>



<%
rs.close();
pstmt.close();
con.close();
%>

	           		 </tbody>
	           		 </table>

				</div>

          		
		</div></div>
		<div class="col-md-12">
		
	

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
		<li><a href="3_search_result.jsp?pageNum=1"> &laquo;</a></li>
		<li class="active"><a href="3_search_result.jsp?pageNum=1"> 1 </a></li>	

<% 
	while(setPage <= lastPage&& setPage!=1) { //1페이지는 정의해놓았으므로, 1페이지 제외, setPage가 lastPage 일때까지 리스트를 동적생성한다.
		
%>
			<li><a href="3_search_result.jsp?pageNum=<%=setPage%>"><%=setPage%></a></li>
<%
		setPage = setPage + 1;
	}
	if(lastPage > currentPage) {
%>
		<li><a href="3_search_result.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	
<%
	}else{
%>
		<li><a href="3_search_result.jsp?pageNum=<%=lastPage%>">&raquo;</a></li>	
	
<%		
	}
}
%> 
</ul></div> 
</div>
			</div>
			</div>
			</div>
		</div>
	</div>

					
					
</body>
</html>