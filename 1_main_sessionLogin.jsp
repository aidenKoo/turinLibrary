<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>login</title>
<SCRIPT LANGUAGE="JavaScript">



</SCRIPT>
</head>
<link href="../css/theme.css" rel="stylesheet" type="text/css"  />

<body>


    <div class="container">    
        <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
            <div class="panel panel-default" >
                    <div class="panel-heading">
                        <div class="panel-title"> 로그인 </div>
                             </div>     

                    <div style="padding-top:30px" class="panel-body" >

                        <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>

   
                             <% 
                             
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
                             
        String loginID = "";
        String admin = request.getParameter("admin");
        loginID = request.getParameter("memberID");
        String loginPassword = request.getParameter("password");
        String id = "";
        String password = "";
        String adminID = "";
        String adminPassword = "";
        session.setAttribute("ID","");
            
   try{         

       
      
       if( loginID.equals(admin) )
       {    
          
       String jdbcURL="jdbc:mysql://localhost:3310/dbturinlibrary";
        String dbID="root";
        String dbPassword="1234";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(jdbcURL,dbID,dbPassword);
       pstmt = con.prepareStatement("SELECT * from tbladmin where adminID = ?");
      pstmt.setString(1, loginID);
      rs = pstmt.executeQuery();
      rs.next(); %>
      
   
<%
 adminID = rs.getString("adminID");
      adminPassword = rs.getString("adminPassword"); 
      session.setAttribute("ID", adminID);

       }
       
       
       
       else if(!loginID.equals(admin)){
            String jdbcURL="jdbc:mysql://moodle.polito.uz:3306/moodle";
          String dbID="kiv";
          String dbPassword="kivproject2016";
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection(jdbcURL,dbID,dbPassword);
           pstmt = con.prepareStatement("SELECT username, password FROM mdl_user where username = ?");
           pstmt.setString(1, loginID);
           rs = pstmt.executeQuery();
           rs.next();
           id = rs.getString("username");
           password = rs.getString("password");
           session.setAttribute("ID", id); 
           session.setAttribute("password", password);
       }
       
       else { %>

         <script type="text/javascript"> alert ("아이디 또는 비밀번호가 일치하지 않습니다.1"); 
         <% session.invalidate(); %>
         history.back(-1);</script>
           <%
    }
       
       if(adminID.equals(loginID) && adminPassword.equals(loginPassword))
       {
         %> <jsp:forward page="/admin/6_admin_index.jsp"/> <%
       }

       else if(session.getAttribute("ID").equals(loginID) && password.equals(loginPassword))
       {  %>
           
          <jsp:forward page="1_main_index.jsp"/>
          
            <%
       }   else { %>

            <script type="text/javascript"> alert ("아이디 또는 비밀번호가 일치하지 않습니다.2"); 
            <% session.invalidate(); %>
            history.back(-1);</script>
              <%
       }
   
   
       %>
   <%
   } catch (Exception e) {
      e.printStackTrace();
      %>
      <script type="text/javascript"> alert ("아이디 또는 비밀번호가 일치하지 않습니다.3"); 
            <% session.invalidate(); %>
            history.back(-1);</script>
      
      
      <% 
   } finally {
      if (rs != null) rs.close();
      if (pstmt != null) pstmt.close();
      if (con != null) con.close();
   }
%>

           

                        </div>                     
                    </div>  
        </div>

         
</body>
</html>