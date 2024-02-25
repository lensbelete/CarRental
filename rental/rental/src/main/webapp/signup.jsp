

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
                    <p style="display: block;">Basic Info:</p>
                    <form action="signup" method="post">
                        <table class="table">
                            <tr>
                                <td>
                                    <label for="firstName">First Name: </label>
                                </td>
                                <td>
                                    <input type="text" name="firstName" value="abebe" required>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="lastName">Last Name: </label>
                                </td>
                                <td>
                                    <input type="text" name="lastName" value="kebede" required>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="email" >Email:</label>
                                </td>
                                <td>
                                    <input type="email" name="email" value="abebe@gmail.com" required>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="password">Password:</label>
                                </td>
                                <td>
                                    <input type="password" name="password" value="abebe" required>
                                </td>
                            </tr>
                          
                            <tr>
                                <td>
                                    <label for="sex">Sex: </label></br>
                                </td>
                                <td>
                                    <label for="male">Male</label>
                                    <input type="radio" name="sex" value="male" required checked></br>
                                    <label for="female">Female</label>
                                    <input type="radio" name="sex" value="female" required>
                                </td>
                            </tr>
                        </table>
                        
                        <input class="btn btn-primary"  type="submit" name="signup" value="Sign Up">
                    </form>
                    </div>
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