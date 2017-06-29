
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
	<jsp:include page="1_main_header.jsp"/> 
	<jsp:include page="1_main_KIVModal.jsp"/> 

    <header>
        <div class="header-content">
            <div class="header-content-inner">
                <h1 id="homeHeading">Turin Polytechnic University<br> in Tashkent</h1>
                <hr>
                <p>start your E-book</p>
                <a href="#about" class="btn btn-primary btn-xl page-scroll">Find Out More</a>
                
             </div>
        </div>
    </header>
<!--newArrivals -->

<section id="new" class="container-fluid bg-light">
<div class="container">
  
  <div id="myCarousel" class="carousel slide text-center" data-ride="carousel">
  <h2 class="text-center">New Arrivals</h2>
  <hr class="primary"><br><br>
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
      <div class="item active">
		<div class="row">
			<div class="col-sm-offset-2 col-md-2 ">
			<img src="img/portfolio/thumbnails/rd1.jpg" alt="#" class="img-thumbnail img-responsive" width="220" height="300">
			</div>
			<div class="col-sm-offset-1 col-md-5 text-center">
			<h3 class="text-muted">������ ����</h3><br>
			<p>25���� �θ� �ڽ��� �θ�κ��� �ڽ����� �̾����� ���ְ��� ���ꡯ�� �����մϴ�. 
			 �ϳ��ϳ� ���ô� ���� �� ���̿��� ������ ������ ������ �ϼ��� �̴ϴ�. ���� �װ� ������� �����塯�̶� �θ��ϴ�.</p>
			</div>
		</div>
	  </div>
      <div class="item">
       <div class="row">
			<div class="col-sm-offset-2 col-md-2 ">
			<img src="img/portfolio/thumbnails/rd2.jpg" alt="#" class=" col-md-offset-1 img-thumbnail img-responsive" width="220" height="300">
			</div>
			<div class="col-sm-offset-1 col-md-5 text-center">
			<h3 class="text-muted">�ٴ��� �Ѳ�</h3><br>
			<p>�׻� �ҹ��ϰ� ������ �̾߱�� �츮���� �λ��ϴ� �۰� ��ø��� �ٳ����� �Ҽ�. ������ ������ ������ó�� ���� �޽��� �ִ� ��������� �̾߱⸦ ���� ����.</p>
			</div>
		</div>
      </div>
      <div class="item">
       <div class="row">
			<div class="col-sm-offset-2 col-md-2 ">
			<img src="img/portfolio/thumbnails/rd3.jpg" alt="#" class=" col-md-offset-1 img-thumbnail img-responsive" width="220" height="300">
			</div>
			<div class="col-sm-offset-1 col-md-5 text-center">
			<h3 class="text-muted">������ ����</h3><br>
			<p>17���� �Ͻ��׸���, ��뿡 ��Ǭ �� �źθ� �´� �� �ô��� ���� ����� ���̴�.
			 �׸���, �̴Ͼ�ó �Ͽ콺�� ���� ��ص��� �̾�����. �Ҽ� ��ǰ�� ���� �� �ִ� ��� ������ ������ �����̼��� ����Ų ��ǰ.</p>
			</div>
		</div>
      </div>
    </div>
<br>

    <!-- Left and right controls -->
	    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
	  	</a><br><br><br>
  </div>
 </div>
</section>   

<!-- //////////////////////////////////Best////////////////////////////////////////////////// -->

    <section id="services" class="bg-dark-green">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Best</h2>
                    <hr class="light">
                </div>
            </div>
        </div>
        
        <div class="container">
            <div class="row">
  				<div class="col-md-4 col-sm-4 animate-box">
						<div class="img-grid text-center">
							<img src="img/portfolio/thumbnails/book.jpg" alt="#" class="img-thumbnail img-responsive" width="150" height="220">
								<div>
									<p></p><h4 class="text-faded">�ְ��� ����</h4>
									<hr class="primary">
									<p class="text-faded">The Cinque Terre: A rugged portion of coast in the Liguria region of Italy.</p>
								</div>
							
						</div>
				</div>
				<div class="col-md-4 col-sm-4 animate-box">
						<div class="img-grid text-center">
							<img src="img/portfolio/thumbnails/book.jpg" alt="#" class="img-thumbnail img-responsive" width="150" height="220">
								<div>
									<p></p><h4 class="text-faded">me before you</h4>
									<hr class="primary">
									<p class="text-faded">The Cinque Terre: A rugged portion of coast in the Liguria region of Italy.</p>
								</div>
							
						</div>
				</div>
				<div class="col-md-4 col-sm-4 animate-box">
						<div class="img-grid text-center">
							<img src="img/portfolio/thumbnails/book.jpg" alt="#" class="img-thumbnail img-responsive" width="150" height="220">
								<div>
									<p></p><h4 class="text-faded">me before you</h4>
									<hr class="primary">
									<p class="text-faded">The Cinque Terre: A rugged portion of coast in the Liguria region of Italy.</p>
								</div>
							
						</div>
				</div>
            </div>
        </div>
    </section>
    


    <section class="bg-muted" id="portfolio text-center">
        <div class="container-fluid">
        <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Best Rated</h2>
                    <hr class="primary">
                </div>
            <div class="row no-gutter popup-gallery">
                <div class=" col-sm-offset-1 col-sm-2 col-sm-12">
                    <a href="img/portfolio/fullsize/rd1.jpg" class="portfolio-box">
                        <img src="img/portfolio/thumbnails/rd1.jpg" class="img-responsive" alt="" width="220" height="300">
                        <div class="portfolio-box-caption">
                            <div class="portfolio-box-caption-content">
                                <div class="project-category ">
                                    	�ְ��� ����
                                <hr class="light">
                                </div>
                                <div class="project-name ">
                                  		  �ڡڡڡ١�
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-2 col-sm-12">
                    <a href="img/portfolio/fullsize/2.jpg" class="portfolio-box">
                        <img src="img/portfolio/thumbnails/rd2.jpg" class="img-responsive" alt="" width="220" height="300">
                        <div class="portfolio-box-caption">
                            <div class="portfolio-box-caption-content">
                                <div class="project-category ">
                                    	�ٴ��� �Ѳ�
                                    <hr class="light">
                                </div>
                                <div class="project-name">
                                    	�ڡڡ١١�
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-2 col-sm-12">
                    <a href="img/portfolio/fullsize/3.jpg" class="portfolio-box">
                        <img src="img/portfolio/thumbnails/rd3.jpg" class="img-responsive " alt="" width="220" height="300">
                        <div class="portfolio-box-caption">
                            <div class="portfolio-box-caption-content">
                                <div class="project-category">
                                    	�̴Ͼ�ó����Ʈ
                                    <hr class="light">
                                </div>
                                <div class="project-name">
                                   	 �ڡڡ١١�
                                </div>
                            </div>
                        </div>
                    </a>
           		</div>
           		<div class="col-sm-2 col-sm-12">
                    <a href="img/portfolio/fullsize/3.jpg" class="portfolio-box">
                        <img src="img/portfolio/thumbnails/rd4.jpg" class="img-responsive " alt="" width="220" height="300">
                        <div class="portfolio-box-caption">
                            <div class="portfolio-box-caption-content">
                                <div class="project-category">
                                    	�ܼ��� ���� �Ƹ����
                                    <hr class="light">
                                </div>
                                <div class="project-name">
                                   	 �ڡڡ١١�
                                </div>
                            </div>
                        </div>
                    </a>
           		</div>
           		
           		<div class="col-sm-2 col-sm-12">
                    <a href="img/portfolio/fullsize/3.jpg" class="portfolio-box">
                        <img src="img/portfolio/thumbnails/rd5.jpg" class="img-responsive " alt="" width="220" height="300">
                        <div class="portfolio-box-caption">
                            <div class="portfolio-box-caption-content">
                                <div class="project-category ">
                                    	Ted Talks
                                    <hr class="light">
                                </div>
                                <div class="project-name">
                                   	 �ڡڡ١١�
                                </div>
                            </div>
                        </div>
                    </a>
           		</div>
           		
        </div>
        </div>
    </section>

<!-- 

    <aside class="bg-primary">
        <div class="container text-center">
            <div class="call-to-action">
                <h2>Free Download at Start Bootstrap!</h2>
                <a href="http://startbootstrap.com/template-overviews/creative/" class="btn btn-default btn-xl sr-button">Download Now!</a>
            </div>
        </div>
    </aside>
 

 -->

 

<section id="contact">  
<div class=" text-center text-muted">
  <hr class="primary">
  <p>TURIN POLYTECHNIC UNIVERSITY IN TASHKENT</p>
  <p></p>
</div>

<div class="container">
  <div class="row">
    <div class="col-sm-4 pull-left">
      <h3 class="text-primary text-center">CONTACT</h3><br>
      <p><i class="fa fa-phone sr-contact"></i>&nbsp;&nbsp;+99871 246-70-82</p>
      <p><i class="fa fa-envelope-o sr-contact"></i><a href="#">&nbsp;&nbsp;INFO@POLITO.UZ</a></p>
      <p><i class="fa fa-location-arrow sr-contact aria-hidden='true'" ></i>&nbsp;&nbsp;TASHKENT, KICHIK KHALKA YULI STR.,17</p>
    </div>
    <div class="col-sm-4 text-center">
      <h3 class="text-primary">Made by</h3><br>
     	  	<a class="page-scroll" data-toggle="modal" href="#KIVModal"><img class="img-responsive" src="img/KIV.jpg" alt="#" class="img-thumbnail img-responsive" width="200" height="200" ></a>
      <p><i class="fa fa-envelope-o sr-contactaria-hidden='true'"></i><a data-toggle="modal" href="#KIVModal">&nbsp;&nbsp;World Friends ICT Volunteers</a></p>
    </div>
    <div class="col-sm-4 text-center">
      <h3 class="text-primary">HOW TO USE</h3><br>
      <p><i class="fa fa-location-arrow sr-contact aria-hidden='true'" ></i>&nbsp;&nbsp;TASHKENT, KICHIK KHALKA YULI STR., 17</p>
    </div>
  </div>
</div>
</section>

<footer class="container-fluid text-center">
  <a href="#page-top" title="To Top">
    <span class="glyphicon glyphicon-chevron-up"></span>
  </a>
  <p>to top</p>
</footer>  


</body>

</html>