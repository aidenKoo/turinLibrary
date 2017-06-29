<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>




<script type="text/javascript">
	function goUrl(url) {
		location.href=url;
	}
	// 삭제 체크
	function deleteCheck(url) {
		if (confirm('The deletion is complete.')) {
			location.href=url;
		}
	}
</script>

<%
String num = request.getParameter("num"); 
String memberID = (String)session.getAttribute("memberID"); 


PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
String dbID="root";
String dbPassword="1234";
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);


String strSQL = "SELECT memberID FROM tblqnaBoard WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();


	strSQL = "DELETE From tblqnaboard WHERE num=?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));
	pstmt.executeUpdate();
	
	strSQL = "UPDATE tblqnaboard SET num = num - 1 WHERE num > ?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));
	pstmt.executeUpdate();

/* 	response.sendRedirect("6_qna_listboard.jsp");
 */
rs.close();
pstmt.close();
conn.close();
response.sendRedirect("6_admin_qnaList.jsp");
%>
<script type="text/javascript">

</script>
