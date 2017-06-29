<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>


<%
request.setCharacterEncoding("UTF-8");

String memberID = (String)session.getAttribute("ID");
String rating = request.getParameter("rating");
String bookCode = request.getParameter("bookCode");
ResultSet rs = null;
Connection conn = null;

String dbID="root";
String dbPassword="1234";

String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
Class.forName("com.mysql.jdbc.Driver").newInstance();

conn = DriverManager.getConnection(jdbcURL,dbID,dbPassword);

PreparedStatement pstmt = null;



String strSQL ="SELECT count(*) FROM tblrating where memberID = ? and bookCode = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setString(1, memberID);
pstmt.setString(2, bookCode);



rs = pstmt.executeQuery();
rs.next();
	if (rs.getInt(1)!=0){
		%>
		<script type="text/javascript">
			alert("You already gave a rating .");
		</script>
		<%
	}
	else{
		strSQL = "INSERT INTO tblrating(memberID,bookCode,rating)"
				+"VALUES(?, ?, ?)";
		pstmt = conn.prepareStatement(strSQL);
		pstmt.setString(1, memberID);
		pstmt.setString(2, bookCode);
		pstmt.setInt(3, Integer.parseInt(rating));

		pstmt.executeUpdate();
		%>
		<script type="text/javascript">
			alert("You gave <%=rating%> points.");
		</script>
		<%
	}

    

	rs.close();
	pstmt.close();
	conn.close();

%>

<script type="text/javascript">
	history.go(-1);
</script>