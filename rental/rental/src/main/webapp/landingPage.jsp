<!DOCTYPE html>
<html>
    <head>
        <title>Guzo Rentals</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
    </head>
    <body>

    	
        	<div class="row">
        		<div class="col-1 col-lg-2"></div>
        		<div class="col-10 col-md-4 col-lg-2 d-flex flex-column">
        				<!--  nav -->
        				<%@ include file="components/outer-nav.jsp" %>
				    	
						<!--  /nav -->
						
		    			<div class="flex-grow-1 row">
	    					<div class="d-flex flex-column justify-content-center">
		    					<div>
				        		    <h1 class="h1">Rent your dream car. Hit the road!</h1>
				              		<p>Experience freedom and adventure with Guzo. Explore stunning locations with our wide range of reliable and affordable vehicles.</p>
				        		
				        			<div>
						                <a  href="/rental/login.jsp"><button class="btn btn-primary">Login</button></a> 
						                <a href="/rental/signup.jsp"><button class="btn btn-outline-primary">Sign up</button></a>
						            </div>
		    					</div>
		    				</div>
	    				</div>
        		</div>
        		<div class="col-1 col-lg-2"></div>
        		
        		<div class="d-none d-md-block col-md-6" style="">
		            <img style="height:100vh; width:100%; object-fit:cover; "
		            src="/rental/assets/hero.jpg" alt="Explore amazing destinations with our car rentals">
        		</div>
        	</div>
        

        <%@ include file="/components/footer.jsp" %>
          
    </body>
</html>