<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.ServletUtils" %>
<%@ page import = "java.sql.*, java.util.*" %>
	<jsp:include page="1_main_header.jsp"/> 
  	<% String basicFileDirectory = "Ebook_Files/"; %>
  <link href="css/jquery.raty.css" rel="stylesheet">
  <style>
  .separator { padding-right:5px;padding-left:5px; }
  </style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="js/jquery.raty.js"></script>
<script>
$(function() {
	var TEMP = document.getElementById('ratingValue'); 
    $('div#star').raty({ //별점
        score: TEMP.value
        ,path : "turinLibrary/img"  // 이미지 폴더 경로 지정.
        ,readOnly : true
        ,click: function(score, evt) {
            $("#starRating").val(score);
            $("#displayStarRating").html(score);
        }
    });
});

$(function() {
    $('div#star').raty({ //별점
        score: 3
        ,path : "/turinLibrary/img"  // 이미지 폴더 경로 지정.
        ,click: function(score, evt) {
            $("#starRating").val(score);
            $("#displayStarRating").html(score);
        },
        starOff : 'star-off-big.png',
        starOn  : 'star-on-big.png'
    });
}); 
</script>
<%

request.setCharacterEncoding("utf-8");



String bookCode = request.getParameter("bookCode");


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

String strSQL= "select count(memberID) as numberOfDownload from tbldownloadlog where bookcode = '" +bookCode+ "'";

pstmt=conn.prepareStatement(strSQL);
rs = pstmt.executeQuery(strSQL);
rs.next();

int numberOfDownload = rs.getInt("numberOfDownload");

	/* set numberOfDownload */

strSQL= "SELECT * FROM  tblbook where bookCode = '" + bookCode + "';" ;

pstmt=conn.prepareStatement(strSQL);

rs = pstmt.executeQuery(strSQL);

rs.next();
String thumbnail = " ";
String bookTitle = " ";
String author = " ";
String publisher = " ";
String publicationYear = " ";
String section=" ";
String content= " ";
String summary = " ";
double avgOfRating = 0.0;
int avgOfGrade=0;
int count=0;
	thumbnail = basicFileDirectory + rs.getString("thumbnail");
	bookTitle = rs.getString("bookTitle");
	author = rs.getString("author");
	publisher = rs.getString("publisher");
	publicationYear = rs.getString("publicationYear");
	String sectionCode	= rs.getString("sectionCode");
	content = rs.getString("content");
	summary = rs.getString("summary");

	if(thumbnail==null||thumbnail==""){
    	thumbnail="img/no_image.jpg";
    }
	strSQL= "SELECT category FROM  tblcategory where sectionCode = '" + sectionCode + "';" ;
	System.out.println(strSQL);

	pstmt=conn.prepareStatement(strSQL);

	rs = pstmt.executeQuery(strSQL);
	rs.next();
	
	section = rs.getString("category");
	
int star[] = {0, 0, 0, 0, 0, 0};
int total = 0;
 

strSQL = "SELECT Round(Avg(rating) ,1) AS avgOfRating , ROUND(Avg(rating),0) AS avgOfGrade, bookCode, "
		+" COUNT(rating) AS Total FROM tblrating GROUP BY tblrating.bookCode HAVING (((tblrating.bookCode)='" + bookCode + "'))" ;

	pstmt=conn.prepareStatement(strSQL);
	rs = pstmt.executeQuery(strSQL);
 
 	if(rs.next()){
 	
	avgOfRating = (double)((int) ((rs.getFloat("avgOfRating"))*10))/10 ; //평점 Float을 소수점으로 나타내기 위해 쓴 식
	avgOfGrade = rs.getInt("avgOfGrade"); //난이도
	total = rs.getInt("Total"); //별점 매긴 사람 수
		
	strSQL = "SELECT rating From tblrating Where bookCode = '"+bookCode+"'" ;
	rs = pstmt.executeQuery(strSQL);

	
 	while(rs.next()){ 
 	switch((int)(rs.getInt("rating"))){
		case 1:
			star[1]++; break;
		case 2:
			star[2]++; break;
		case 3:
			star[3]++;  break;
		case 4:
			star[4]++; break;
		case 5:
			star[5]++; break;
	} 
	}
 	for(int i = 0; i<star.length ; i ++){
 		float temp = (star[i]*100) / total;
		star[i] = (int)temp;
	}  
 	}
%>

<body>

<br>
<br>
<br>
<br>
<br>
<br>

<div class="container">
      <div class="row">
        <div class="content">
          <ul class="breadcrumb">
            <li><a href="1_main_index.jsp">Home</a></li>
             <li><a href=""><%=section %></a></li>
			<li class="active"><a href="#"><%=bookTitle %></a></li>
          </ul>
        </div>
      </div> <!-- /row -->
  
  
      
	<div class="hidden-sm hidden-xs" style="margin:10px 0 20px;">
		<h4><%=bookTitle %></h4>
	</div>
		<div class="visible-sm visible-xs" style="margin:20px 0;">
			<h4><%=bookTitle %></h4>
		</div>
		<div class="row">
			<div class="col-md-4">

           <div id="freeCarousel" class="carousel slide" data-ride="carousel">
          	<!-- Indicators -->
            <ol class="carousel-indicators">
              <li data-target="#freeCarousel" data-slide-to="0" class="active"></li>
            </ol>
            <!-- Wrapper for slides -->
            <div class="carousel-inner">
              <div class="item active">
                <img src=<%=thumbnail %> style="width:300; height:700;"/>
              </div>
              

            </div>
            <!-- Controls -->
<!--This script should be at the very bottom of the page (footer works for me)-->  

   		 </div>


		</div>

		<div class="visible-sm visible-xs"></div>
		<form name="bookInfo"  method="post">
		<input type="hidden" name="bookCode" value="<%=bookCode %>">
			<div class="col-md-6">
				<div style="padding:10px; height:auto; border:5px solid #eee;">
				<font size="5"><b><span class="glyphicon glyphicon-book"> </span>  &nbsp;Book Info </b></font>
			<div class="content-wide ptl">
        	<div class="table-responsive">
	        	<table class="table table-striped">
		        <tr>

					<td>Book Title</td>
		            <td><%=bookTitle%></td>      
		        </tr>
		        <tr>

					<td>Author</td>
		            <td><%=author %></td>      
		        </tr>
		        
	            <tr>
	              <td>Publisher</td>
	              <td><%=publisher %></td>
	            </tr>
	            
	            <tr>
	              <td>Publication Year</td>
	              <td><%=publicationYear %></td>	              
	            </tr>
	            
	            <tr>
	              <td>Section</td>
	              <td><%=section %></td>	              
	            </tr>
	            	            	            	        
				<tr>
	              <td>NumberOfDownload</td>
	              <td><strike><%=numberOfDownload%></strike>  

	       	              
	            </tr>
	          </table>           
	       <div class="text-center">
	       
            <a href="#" ><button  onclick="window.open('4_bookDetail_download.jsp?bookCode=<%=bookCode%>')" class="btn btn-primary btn-embossed mlm"><i class="glyphicon glyphicon-ok"></i>&nbsp;Download E-book</button></a>
            </div>
	         <!--  <button type="submit" class="btn btn-primary btn-block" style="margin-bottom:10px; padding:10px 0;">
							
				</button> -->
				
        	</div>          
        </div>
		</div>
	</div><!--  end col-md-6 -->
	</form><!--  end Form -->

<!-- 별점 -->
<input type ="hidden"  id ="ratingValue" value="<%=avgOfRating%>">
		<div class="col-md-4">

		</div>
		
        <div class="col-xs-12 col-md-6">
            <div class="well well-sm">
			<span class="glyphicon glyphicon-leaf">
            	         
                <div class="row">

                    <div class="col-xs-12 col-md-6 text-center">
                        <h1 class="rating-num"> <%= avgOfRating %>
                        
                            </h1>
                        <div class="rating">
                         <div id="star"></div> <div>	<input type="hidden" name = "rating" id="starRating" value="3"/> </div>
                        </div>
                        <div>

                            <span class="glyphicon glyphicon-user"></span> <%=total %> total
                        </div>

                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div class="row rating-desc">
                            <div class="col-xs-3 col-md-3 text-right">
                                <span class="glyphicon glyphicon-star"></span>5
                            </div>
                            <div class="col-xs-8 col-md-9">
                                <div class="progress progress-striped">
                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="20"
                                        aria-valuemin="0" aria-valuemax="100" style="width: <%=star[5]%>%">
                                        <span class="sr-only"><%=star[5]%>%</span>
                                    </div>
                                    
                                </div>
                            </div>
                            <!-- end 5 -->
                            <div class="col-xs-3 col-md-3 text-right">
                                <span class="glyphicon glyphicon-star"></span>4
                            </div>
                            <div class="col-xs-8 col-md-9">
                                <div class="progress">
                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="20"
                                        aria-valuemin="0" aria-valuemax="100" style="width: <%=star[4]%>%">
                                        <span class="sr-only"><%=star[4]%>%</span>
                                    </div>
                                </div>
                            </div>
                            <!-- end 4 -->
                            <div class="col-xs-3 col-md-3 text-right">
                                <span class="glyphicon glyphicon-star"></span>3
                            </div>
                            <div class="col-xs-8 col-md-9">
                                <div class="progress">
                                    <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20"
                                        aria-valuemin="0" aria-valuemax="100" style="width: <%=star[3]%>%">
                                        <span class="sr-only"><%=star[3]%>%</span>
                                    </div>
                                </div>
                            </div>
                            <!-- end 3 -->
                            <div class="col-xs-3 col-md-3 text-right">
                                <span class="glyphicon glyphicon-star"></span>2
                            </div>
                            <div class="col-xs-8 col-md-9">
                                <div class="progress">
                                    <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="20"
                                        aria-valuemin="0" aria-valuemax="100" style="width: <%=star[2]%>%">
                                        <span class="sr-only"><%=star[2]%>%</span>
                                    </div>
                                </div>
                            </div>
                            <!-- end 2 -->
                            <div class="col-xs-3 col-md-3 text-right">
                                <span class="glyphicon glyphicon-star"></span>1
                            </div>
                            <div class="col-xs-8 col-md-9">
                                <div class="progress">
                                    <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80"
                                        aria-valuemin="0" aria-valuemax="100" style="width: <%=star[1]%>%">
                                        <span class="sr-only"><%=star[1]%>%</span>
                                    </div>
                                </div>
                            </div>
                            <!-- end 1 -->
                        </div>
                        <!-- end row -->
                    </div>
                  
                </div>
           
            </div>
            	<form name = "StarRating" action="4_bookDetail_rating.jsp" method="post" >
					<div class="form-group">
						<label class="col-sm-5 control-label"><b>StarRating</b></label>
						<div class="col-sm-5">
							<div id="star"></div>
   			    			<button type="submit">Rating star points</button>
   				  			<div>
 			        			<input type="hidden" name = "rating" id="starRating" value="3"/>
 			        			<input type="hidden" name = "bookCode" value="<%=bookCode%>"/>
   			    			</div>
						</div>
						
					</div>
				</form>	
        </div><!--  end star -->

	
</div><!-- end row -->

<div class="row">
<div style="margin:20px; border-bottom:5px dotted #eee;"></div>
</div>



<div class="row">
<div class="col-md-8">



<ul class="nav nav-tabs">
<li class="active"><a href="#detail-view" data-toggle="tab"> Contents </a></li> <!-- 책 상세 정보 컨텐츠를 출력하는 탭입니다. -->
<li>
<a href="#reviewBoard" id="reviewBoard-btn" data-toggle="tab"> Review </a></li> <!--  해당 책과 관련된 리뷰 게시판을 출력하는 탭 입니다.  -->

</ul>
<div class="tab-content">
<div class="tab-pane active" id="detail-view">
<p style="text-align: center;"><span style="font-size: 14.0pt;"><strong>About the book </strong></span></p>
<div>
<p style="text-align: center;"><span style="font-size: 10.0pt;"><%=summary %></span><br></p>
</div>
<div style="text-align: center;">
<%=content %>
</div>
<div style="text-align: center;">&nbsp;</div>
<div style="text-align: center;">&nbsp;</div>
<div>
<div>
<div style="text-align: center;">
<div>
<p><span style="font-size: 10.0pt;">&nbsp;</span></p>
</div>
</div>
<div><span style="font-size: 10.0pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
</div>
</div>
</div>

</div>



<div class="tab-pane" id="reviewBoard"><!-- Review board output.-->
			<jsp:include page="5_reviewBoard_listboard.jsp"> 
			<jsp:param name="bookCode" value="<%=bookCode %>"/>
			</jsp:include>
		

<div class="clearfix"></div>
</div>


</div>
<div style="height:15px;"></div>
</div>

</div><!-- /container -->
<%
rs.close();
pstmt.close();

conn.close();
%>
</body>