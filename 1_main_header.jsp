<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- jQuery -->
    <script src="vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="vendor/scrollreveal/scrollreveal.min.js"></script>
    <script src="vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

    <!-- Theme JavaScript -->
    <script src="js/creative.min.js"></script>
    
	<% String basicFileDirectory = "Ebbok_Files/"; %>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Turin Library</title>

    <!-- Bootstrap Core CSS -->
    <link href="/turinLibrary/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/turinLibrary/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>

    <!-- Plugin CSS -->
    <link href="/turinLibrary/vendor/magnific-popup/magnific-popup.css" rel="stylesheet">

    <!-- Theme CSS -->
    <link href="/turinLibrary/css/creative.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

	<script>
	function classChoice(category) {
		searching.classification.value = category;	
		searching.dropdownButton.value = category;
	}
	</script>
</head>
<body id="page-top">

<nav id="mainNav"  class="navbar navbar-default navbar-fixed-top">
  <div class="container-flid">
    <div class="navbar-header">
    
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
        <span class="sr-only">Toggle navigation</span><i class="fa fa-bars"></i>
        <a class="navbar-brand page-scroll" href="#page-top"></a>
      </button>

      
      
      
      
      
      
      
      
      
      <% Object memberID = session.getAttribute("ID"); %>



	      <a class="navbar-brand" href="1_main_index.jsp">Home</a>



	
  </div>
  
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
     <ul class="nav navbar-nav navbar-right">
            <% if( memberID == null )
            	{
            	%>
            	 <li>
                        <a class="page-scroll" data-toggle="modal" href="#loginModal">Login</a>
                    </li>
            	<% 
            	}
            	 
            	  else { %>
                         <li>
                        <a class="page-scroll" data-toggle="modal" href="#loginModal"><%=session.getAttribute("ID")%></a>
                    </li>
                     <li><a class="page-scroll" href="1_main_logout.jsp"><span class="glyphicon glyphicon-user"></span> Logout </a></li> 
  						    <li class="dropdown">
			 	             <a href="/community/notice.php" class="glyphicon glyphicon-tags" data-toggle="dropdown">  My page</a>
     				         <span class="dropdown-arrow"></span>
    			          <ul class="dropdown-menu">
						   <li><a href="5_reviewBoard_mylistboard.jsp"> Review board </a></li>
       			        <li><a href="6_qna_mypage.jsp?member"> Q & A board</a></li>	
                 	</ul>
      </li> 
                    <% } %>
                    
                    
     
                   

        <li><a class="page-scroll" href="#howToUse"><span class="glyphicon glyphicon-question-sign"></span> How To Use</a></li>
      </ul>
  </div>  <!-- header 첫줄, how to use까지 -->

	<form name = "searching" class="form-center" role="search" action="3_search_result.jsp" method = "get"><!--class="navbar-form/form/form-inline(all the elements are inline -->
  	 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
    	  <div class="col-md-offset-3">
     		 <ul class="nav navbar-nav">
				<li class="dropdown">
          			<a href="#" name ="dropdownButton" id ="dropdownButton" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" value ="All" ><span class="caret"></span></a>
             		<ul class="dropdown-menu" role="menu">
             			<li><a href="#" onClick="classChoice('all')">All</a></li>
           	    		<li class="divider"></li>
             			<li><a href="#" onClick="classChoice('bookTitle')">Book Title</a></li>
           	    		<li class="divider"></li>
           			    <li><a href="#" onClick="classChoice('author')">Author</a></li>
          			    <li class="divider"></li>
          			    <li><a href="#" onClick="classChoice('publisher')">Publisher</a></li>
              			<li class="divider"></li>
              			<li><a href="#" onClick="classChoice('summary')">Summary</a></li>
              			<li class="divider"></li>
        			    <li><a href="#" onClick="classChoice('subject')">Subject</a></li>
              			<li class="divider"></li>
              			<li><a href="#" onClick="classChoice('section')">Section</a></li>
              			<li class="divider"></li>
              			<li><a href="#" onClick="classChoice('publicationYear')">Year</a></li>
            		</ul>
           		</li>
     		</ul>
      </div>
      <ul>
        
        <div class="form-group col-md-6">
             <input type="text" name="keyword" class="form-control" placeholder="Select category" id="keyword">
             <input type="hidden" name="classification" id="classification" value = "all">
        </div>
        <button type="submit" class="btn btn-default">Search</button>
     
      </ul>
   	</div>
   </form>
 </div><!--container fluid  -->
 </nav>
     
<jsp:include page="1_main_loginmodal.jsp"/> 