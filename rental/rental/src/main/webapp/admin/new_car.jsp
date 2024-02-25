



<!DOCTYPE html>
<%@ page import="com.itsc.services.*" %>
<%@ page import="com.itsc.model.*" %>
<%@ page import="java.util.ArrayList" %>


<html>
    <head>
        <title>New Car</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
    </head>
    <body>

        
        <%@ include file="components/nav.jsp" %>
        <main class="my-5">
        <div class="container mb-5 min-vh-100">
        
            <h1 class="h2">Add Car</h1>
            <div class="row">
              <div class="col-md-8">
                <div>
                
               		
                     <form action="/rental/new-car" method="post" enctype="multipart/form-data">
                        <table class="table">
                        	<tr>
                                <td>
                                    <label for="firstName">Car Photo: </label>
                                </td>
                                <td>
                                    <input type="file" name="photo" accept="image/*" required>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <label for="model">Model: </label>
                                </td>
                                <td>
                                    <input type="text" name="model" value="Toyota Corolla 2016" required>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="rentalFee">Rental Fee: </label>
                                </td>
                                <td>
                                    <input type="number" name="rentalFee" value="5000" required>
                                </td>
                            </tr>
                          
                        </table>
                        
                        <input class="btn btn-primary" type="submit" name="signup" value="Add Car">
                    </form>
                   
                 
                    
                    
               </div>
            </div>
            
          </div>
          </div>
          </main>
          <%@ include file="/components/footer.jsp" %>
    </body>
</html>
