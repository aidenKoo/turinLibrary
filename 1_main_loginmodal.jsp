<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- Button trigger modal -->
<!-- 로그인 Modal -->
<script>


 function modal_Login() 
{
if(login.ID.value.length < 1){
	alert("Insert ID");
	Member_Input.ID.focus();
	return false;
	}else if (login.password.value.length < 1){
	alert("Insert password");
	Member_Input.password.focus();
	return false;
	}else{
		on.submit();
	}		
}


</script>



<style>
.modal, .modal.fade.in {
    top: 0; /* was 10% */
}

.modal-dialog-center { <!-- modal 창이 가운데로 있게 하려면 설정해야 합니다.-->
    margin-top: 25;
    top: 1%;
    left:-1%;
}
</style>

<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-center">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">Login</h4>
      </div>
      <div class="modal-body">
      <form role="form" action="1_main_sessionLogin.jsp" method="post">

         <div style="margin-bottom: 25px" class="input-group">
               <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
               <input type="text" class="form-control" name="memberID" placeholder="ID">                                        
           </div>
       
 		  <div style="margin-bottom: 25px" class="input-group">
               <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
               <input type="password" class="form-control" name="password" placeholder="password">
           </div>
            <input type = "hidden" value = "admin" name = "admin" >

       
  		 <div class="input-group">
             <div class="checkbox">
               <label>
<!--                  <input id="login-remember" type="checkbox" name="remember" value="1"> Remember me
 -->               </label>
             </div>
           </div>
           
           

  <button class="btn btn-primary" onclick="modal_Login()"> Login </button>
  
</form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

