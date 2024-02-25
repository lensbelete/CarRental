<!DOCTYPE html>
<%@ page import="com.itsc.services.*" %>
<%@ page import="com.itsc.model.*" %>
<%@ page import="java.util.ArrayList" %>


<html>
    <head>
        <title>Edit Car</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
    </head>
    <body>
           <%
        	int carId = Integer.parseInt(request.getParameter("car_id"));
        	CarModel car = CarService.get(carId);
        	boolean hasOwner = car.ownerId != 0;
        	
        	UserModel owner = null;
        	if (hasOwner) owner = UserService.get(car.ownerId);
        %>
        
        <%@ include file="components/nav.jsp" %>
        <main class="my-5">
        <div class="container mb-5">
        
            <h1 class="h1">Edit Car</h1>
            <div class="row">
              <div class="col-md-8">
                <div>
               		<img style="width:100%; height:400px; object-fit:cover;" src="<%= CarService.getPhotoPath(car) %>" alt=""/>
                    <hr/>
                    <h2 class="h2" style="display: block;"><%= car.model %></h2>
                    <p> Bought in <%=car.addDate %> </p>
                    
                    <form action="/rental/edit-car" method="post" disabled="disabled">
                    	<input name="type" value="fee" hidden/>
                    	<input name="carId" value="<%= car.id %>" hidden/>
                        <table class="table">
                        	<tr class="row">
                                <td class="col-6">
                                    <p>Rental Fee (birr): </p>
                                    <input type="number" name="amount" value="<%=car.rentalFee %>" required>
                                </td>
                                 <td class="col-6">
                                	<% if (hasOwner){ %> <p><sup> Can't change while on rent </sup> </p><%} %>
			                        <button class="btn btn-primary" <%= hasOwner?"disabled":"" %>> Save</button>
                                </td>
                            </tr>
                            
                        </table>
                    </form>
                    
                    <% if (hasOwner){ %>
                     <form action="/rental/edit-car" method="post">
                    	<input name="type" value="disown" hidden/>
                    	<input name="carId" value="<%= car.id %>" hidden/>
                    	<table class="table">
                        	<tr class="row">
                                <td class="col-6">
                                	<p>Currently rented by <%= owner.firstName + " " + owner.lastName %>  (<%= owner.email %>)</p>
                                </td>
                                <td class="col-6">
			                        <button class="btn btn-danger"> End Rental</button>
                                </td>
                            </tr>
                            
                        </table>
                        
                     
                    </form>
                    <% } else {%>
                    	<table class="table">
                        	<tr class="row">
                                <td class="col-6">
			                        No owner ...
                                </td>
                            </tr>
                            
                        </table>
                    <%} %>
                    
                    <form action="/rental/edit-car" method="post">
                    	<input name="type" value="delete" hidden/>
                    	<input name="carId" value="<%= car.id %>" hidden/>
                        <table class="table">
                        	<tr class="row">
                                <td class="col-6">
                                	<p>Remove car from the system</p>
                                </td>
                                <td class="col-6">
			                        <% if (hasOwner){ %> <p><sup> Can't remove while on rent </sup> </p><%} %>
			                        <button class="btn btn-danger" <%= hasOwner?"disabled":"" %>> Remove</button>
                                </td>
                            </tr>
                            
                        </table>
                    </form>
                    
                    
                    </div>
            </div>
            
          </div>
          </div>
          </main>
          <%@ include file="/components/footer.jsp" %>
          
    </body>
</html>
