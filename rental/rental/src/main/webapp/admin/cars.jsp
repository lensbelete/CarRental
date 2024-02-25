<!DOCTYPE html>
<%@ page import="com.itsc.services.*" %>
<%@ page import="com.itsc.model.*" %>
<%@ page import="java.util.ArrayList" %>

<html>
    <head>
        <title>Cars</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    </head>
    <body>
        <%@ include file="components/nav.jsp" %>
        <main class="my-5">
        <div class="container min-vh-100">
        
        <h1 class="h1">Cars</h1> 
        <div class="row ">
        	
        <% 
        	ArrayList<CarModel> cars = CarService.getCars();
        %>
        
        <% if (cars.size()==0){ %> <p>No cars in the system, add a new car. </p><%} %>
        
        <% for (CarModel car: cars){ %>
	        <!-- card -->
	        <div class="col-6 col-md-6 col-lg-4  mb-3">
	        <div class="card" >
	            <img style="width:100%; height:200px; object-fit:cover;" class="border" src="<%= CarService.getPhotoPath(car) %>" alt=""/>
	            <div class="card-body">
		            <h2 class="card-title"><%= car.model %></h2>
		            <p>Added first on <%= car.addDate %></p>
		            <p><%= car.rentalFee %> birr per month</p>
					
						            
		            
		            <%  
		            UserModel owner = UserService.get(car.ownerId); //ownerId can be 0 => null
		            if (owner != null) { 
		            %>
		           		 <p>Owned by <%= owner.firstName %> <%= owner.lastName %> (<%= owner.email %>) </p>
			        	 <p> From <%= car.startDate %> to <%= car.endDate %> </p>
			        	 <p><%= CarService.totalFee(car) %> birr expected</p>
		            <% } else { %>
		            <p>Idle, not being rented</p>
		            <% } %>
	            </div>
	            
	            <a href="/rental/admin/edit_car.jsp?car_id=<%= car.id %>" class=" btn btn-primary" >
	            	Edit
	            </a>
	        </div>
	        </div>
	        <!-- /card -->
	        <% } %>
        	
        	
        </div>
        </div>
        </main>
        <%@ include file="/components/footer.jsp" %>
        </body>
</html>