<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Lumino - Charts</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<link href="/turinLibrary/css/bootstrap.min.css" rel="stylesheet">
<link href="/turinLibrary/css/datepicker3.css" rel="stylesheet">
<link href="/turinLibrary/css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="/turinLibrary/js/lumino.glyphs.js"></script>

<!--[if lt IE 9]>
<script src="/turinLibrary/js/html5shiv.js"></script>
<script src="/turinLibrary/js/respond.min.js"></script>
<![endif]-->


 <jsp:include page="6_admin_header.jsp"/> 
							

		    <jsp:include page="6_admin_sidebar.jsp"/> 


<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 등록 폼 체크
	function boardWriteCheck() {
		var form = document.boardWriteForm;
		if (form.subject.value == '') {
			alert('제목을 입력하세요.');
			form.subject.focus();
			return false;
		}
		if (form.writer.value == '') {
			alert('작성자을 입력하세요');
			form.writer.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>



		<form role="form"  method="post" name="boardWriteForm" action="7_admin_BoardProcess.jsp"  onsubmit="return boardWriteCheck();">
		<input type="hidden" name="mode" value="W" />            
		  <!-- ///// 모드전송 -->
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">			
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="#"><svg class="glyph stroked home"><use xlink:href="#stroked-home"></use></svg></a></li>
				<li class="active">Icons</li>
			</ol>
		</div><!--/.row-->
		
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Announcement Write</h1>
			</div>
		</div><!--/.row-->
				
		
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">

					<div class="panel-body">
						<div class="col-md-6">
							<form role="form">
							
								<div class="form-group">
									<label>subject</label>
									<input class="form-control"  name="subject">
								</div>
								
																
                                <div class="form-group">
									<label>contents</label>
									<textarea class="form-control" name = "contents" rows="3"></textarea>
														<script>
					CKEDITOR.replace('contents');
					</script>
								</div>
								

							<div class="col-md-6">
							

						<button type="submit" class="btn btn-primary" OnClick="javascript:boardWriteCheck()" >Submit Button</button>
								<button type="reset" class="btn btn-default" onclick="goUrl('7_admin_BoardList.jsp');">Reset Button</button>
							</div>
							</form>
						</form>
					</div>
				</div>
			</div><!-- /.col-->
		</div><!-- /.row -->
	
	
	
</body>
</html>


