<%@ page language="java" contentType="text/html; charset=UTF-8" %>
  <jsp:include page="1_main_header.jsp"/>  
<HTML>
<HEAD>
<TITLE> Review modify </TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
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
String num = request.getParameter("num");
%>

<center><font size='3'><b> Check password </b></font>                                                

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>                 

<Form Action='5_reviewBoard_modify_input.jsp' Method='post'>                 
<input type='hidden' name='num' value='<%=num %>'>

<TABLE border='0' width='300' align='center'>
 	<TR>
         	<TD align='center'>
            		<font size=2><B> password </B></font>
	 	</TD>
	 	<TD>
            		<input type='password' name='pass' size=20 maxlength=20>
            		<input type='submit' value='sumit' style='background-color:cccccc; font-weight:bolder'>
	 	</TD>
      	</TR>
</TABLE>
                                   
<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>                    

<a href='5_reviewBoard_listboard.jsp'>[List board]</a>    

</FORM>

</BODY>
</HTML>