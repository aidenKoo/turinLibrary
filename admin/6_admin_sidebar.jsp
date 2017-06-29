<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>


<link href="/turinLibrary/css/bootstrap.min.css" rel="stylesheet">
<link href="/turinLibrary/css/datepicker3.css" rel="stylesheet">
<link href="/turinLibrary/css/styles.css" rel="stylesheet">
   <div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
      <form role="search">
         <div class="form-group">
            <input type="text" class="form-control" placeholder="Search">
         </div>
      </form>
      <ul class="nav menu">


               <li>
                  <a class="" href="/turinLibrary/admin/7_admin_BoardList.jsp">
                     <svg class="glyph stroked table"><use xlink:href="#stroked-table"></use></svg> Announcement List
                  </a>
               </li>

         <li><a href="/turinLibrary/admin/7_admin_NoticeWriteForm.jsp"><svg class="glyph stroked pencil"><use xlink:href="#stroked-pencil"></use></svg> New Announcement</a></li>
         
         <li><a href="/turinLibrary/admin/8_admin_fileUpload.jsp"><svg class="glyph stroked upload"><use xlink:href="#stroked-upload"></use></svg> E-BOOK UPLOAD</a></li>
         
         <li><a href="/turinLibrary/admin/8_admin_ebookList.jsp"><svg class="glyph stroked upload"><use xlink:href="#stroked-upload"></use></svg> E-BOOK MANAGEMENT</a></li>
         
         <li><a href="/turinLibrary/admin/6_admin_qnaList.jsp"><svg class="glyph stroked table"><use xlink:href="#stroked-table"></use></svg> Q&A LIST</a></li>
         
         
         <li role="presentation" class="divider"></li>
         
      </ul>

   </div><!--/.sidebar-->
</head>
</html>