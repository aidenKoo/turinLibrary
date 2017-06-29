<%@ page language="java" contentType="text/html; charset=UTF-8" %>
  <jsp:include page="1_main_header.jsp"/>  
<HTML>
<HEAD>
<TITLE> 리뷰 게시판 글 삭제 </TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
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
String num = request.getParameter("num");
%>

<center><font size='3'><b>Check password</b></font>                                                

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>                 

<Form Action='r_delete_input.jsp' Method='post'>                 
<input type='hidden' name='num' value='<%=num%>'>

<TABLE border='0' width='300' align='center'>
 	<TR>
         	<TD align='center'>
            		<font size=2><B>Password</B></font>
	 	</TD>
	 	<TD>
            		<input type='password' name='pass' size=20 maxlength=20>
            		<input type='submit' value=' 확 인 ' style='background-color:cccccc; font-weight:bolder'>
	 	</TD>
      	</TR>
</TABLE>
                                   
<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>                    

<center><a href='r_listboard.jsp'>[List]</a></center>      

</FORM>

</BODY>
</HTML>