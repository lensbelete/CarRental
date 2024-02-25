
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
		    					<form method="POST" action="login">
			                    <table class="table" style="border: none;">
			                        <tr>
			                            <td>
			                                <label for="Email">Email:</label>
			                            </td>
			                            <td>
			                                <input type="email" name="email" value="abebe@gmail.com" required aria-label="email">
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <label for="password">Password</label>
			                            </td>
			                            <td>
			                                <input type="password" name="password" value="abebe" required aria-label="">
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <input type="submit" value="Login" name="Login" class=" btn btn-primary">
			                            </td>
			                        </tr>
			                    </table>
			                </form>
		    				</div>
	    				</div>
        		</div>
        		<div class="col-1 col-lg-2"></div>
        		
        		<div class="d-none d-md-block col-md-6" style="">
		            <img style="height:100vh; width:100%; object-fit:cover; "
		            src="/rental/assets/hero2.jpg" alt="Explore amazing destinations with our car rentals">
        		</div>
        	</div>
        

        
      <%@ include file="/components/footer.jsp" %>    
    </body>
</html>
