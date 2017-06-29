<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- Button trigger modal -->




<style>
.modal, .modal.fade.in {
    top: 0; /* was 10% */
}

.modal-dialog-center { 
    margin-top: 25;
    top: 1%;
    left:-1%;
}
</style>

<!-- <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-center">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h5 class="modal-title">KIV2016@KissIT</h5>
      </div>
      <div class="modal-body">
      <form role="form" action="1_main_sessionLogin.jsp" method="post">

         <div style="margin-bottom: 25px" class="input-group">
               <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
               <input type="text" class="form-control" name="memberID" placeholder="id">                                        
           </div>
       
 		  <div style="margin-bottom: 25px" class="input-group">
               <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
               <input type="password" class="form-control" name="password" placeholder="password">
           </div>
           
        

  		 <div class="input-group">
             <div class="checkbox">
               <label>
                 <input id="login-remember" type="checkbox" name="remember" value="1"> Remember me
               </label>
             </div>
           </div>
           
           

  <button class="btn btn-primary" onclick="modal_Login()"> Login </button>
  
</form>
</div>
</div>
</div>
</div> -->



<div class="modal fade" id="KIVModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-center modal-lg">
    <div class="modal-content" style="background-color:rgba(213,196,179,0.9);">
      <div class="modal-header" style="color:#f3edec;">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h5 class="modal-title">Made by</h5>
      </div>
      <div class="modal-body" style="color:#f3edec;">
     
		<p class="text-center text-muted" style="margin-top:25px"><strong>2016 World Friends ICT Volunteers @ KissIT</strong></p>
		
		<div class="row text-center">
			<div class="col-md-1 col-sm-offset-2 text-center">
				<div style="margin-bottom:25px; margin-top:20px">
				<img src="img/kiv/CJ.jpg" class="img-circle" width="95" height="95">
				<h5 class="text-muted">&nbsp;&nbsp;&nbsp;<b>Chanjoong</h5>
				<h5 class="text-muted">&nbsp;&nbsp;&nbsp;<b>Jung</h5>
				</div>
			</div>
			
			<div class="col-md-1 col-sm-offset-1 text-center">
				<div style="margin-bottom:25px; margin-top:20px">
				<img src="img/kiv/Aiden.jpg" class="img-circle" width="95" height="95">
				<h5 class="text-muted">&nbsp;&nbsp;&nbsp;<b>Dongseop</h5>
				<h5 class="text-muted">&nbsp;&nbsp;&nbsp;<b>Koo</h5>
				</div>
			</div>
         	
         	<div class="col-md-1 col-sm-offset-1 text-center">
				<div style="margin-bottom:25px; margin-top:20px">
				<img src="img/kiv/Moo.jpg" class="img-circle" width="95" height="95">
				<h5 class="text-muted">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Jungmoo</h5>
				<h5 class="text-muted">&nbsp;&nbsp;&nbsp;<b>Jo</h5>
				</div>
			</div>
		
			<div class="col-md-1 col-sm-offset-1 text-center">
				<div style="margin-bottom:25px; margin-top:20px">
				<img src="img/kiv/Hera.jpg" class="img-circle" width="95" height="95">
				<h5 class="text-muted">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Hera</h5>
				<h5 class="text-muted">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Kang</h5>
				</div>
			</div>
		
		</div>
	

  		 <div class="input-group">
             <div class="checkbox">
               <label>
<!--                  <input id="login-remember" type="checkbox" name="remember" value="1"> Remember me
-->               </label>
             </div>
           </div>
           
           
  <div class="modal-footer">
  </div>
  
</div>
</div>
</div>
</div>




