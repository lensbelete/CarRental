<%@ page import="com.itsc.services.*" %>
<%@ page import="com.itsc.model.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    </head>

			 <%
            	ArrayList<CarModel> cars = new ArrayList<CarModel>();
            	UserModel user = UserService.getFromRequest(request);
            	String searchString = request.getParameter("search");
            	//System.out.println(searchString );
            	
            	boolean areMine = searchString == null || searchString.equals("");
            	if (areMine){
            		cars = CarService.getUserCars(user.id);
            	}else{
            		cars = CarService.getUnOwnedByModel(searchString, user.id);
            	}
            	//System.out.println(cars.size());
            
            %>
            
    <body>
    	<%@ include file="components/nav.jsp" %>
    
        <main class="my-5">
        <div class="container min-vh-100">
            
           <form class="d-flex mb-5">
                <input type="text" name="search" class="form-control mr-3" value="<%= searchString == null? "": searchString %>" placeholder="Search For Cars">
                <button class="btn btn-primary" >Search</button>
            </form>
            
            <div>
            	<h2 class="h2"><%= areMine ? "My Cars" : "Search Results" %></h2>
       		</div>
            
            <div class="row">
            
            
            <!-- Search Cars -->
            <% if (!areMine) { %>
            <% if (cars.size() == 0){ %>
	            <p class=" col-12">Nothing could be found, search for another car.</p>
            <%} %>
            
            <% for (CarModel car: cars){
            	String[] startEndDates = CarService.todayAndNextMonth();
            	String startDate = startEndDates[0];
            	String endDate = startEndDates[1];
            
            %>
            <!-- not mine card -->
	       	<div class="col-md-6 col-lg-4 mb-3">
	        <div class="card" >
	            <img style="width:100%; height:300px; object-fit:cover;" class="border" src="<%= CarService.getPhotoPath(car) %>" alt=""/>
	            <div class="card-body">
		            <h2 class="card-title"><%= car.model %></h2>
		            <p>Bought on <%= car.addDate %></p>
		            <p><%= car.rentalFee %> Birr per month</p>		            
		       
		            <form action="/rental/new-request" method="post">
		            	<input type="number" name="carId" value="<%= car.id %>" hidden />
		            	<input type="number" name="userId" value="<%= user.id %>" hidden />
		            	<input type="text" name="status" value="pending" hidden />
		            	<input type="text" name="type" value="new" hidden />
		            	
			            <div class="p-2">
				            From <input type="date" name="startDate" value="<%= startDate %>" required />
			            </div>
			            <div class="p-2">
			            	To <input type="date" name="endDate" value="<%= endDate %>" required/>
			            </div>
			            <div>
				            <button type="submit" class=" btn btn-primary w-100" >
				            	Rent
				            </button>
			            </div>
		            </form>
	            </div>
	        </div>
	        </div>
	        <!-- /not mine card -->
           <% } %>
           <% } %>
           <!-- /search cars -->
           
           <% if (areMine) { %>
            <% if (cars.size() == 0){ %>
            	<p class="col-12" >You haven't rented any cars! Search around and rent.</p>
            <%} %>
            
            <% for (CarModel car: cars){
            	String startDate = car.startDate;
            	String endDate = car.endDate; 
            %>
             <!-- my car card -->
	       	<div class="col-6 col-md-6 col-lg-4 mb-3">
	        <div class="card" >
	            <img style="width:100%; height:300px; object-fit:cover;" class="border" src="<%= CarService.getPhotoPath(car) %>" alt=""/>
	            <div class="card-body">
		            <h2 class="card-title"><%= car.model %></h2>
		            <p>Bought on <%= car.addDate %></p>
		            <p>$<%= car.rentalFee %> per month</p>
		            <p>From <%=startDate %> to <%= endDate %></p>           
		       </div>
		       <div class="d-flex justify-content-between">
		       <form  action="/rental/modify-request" method="post">
	            	<input type="number" name="carId" value="<%= car.id %>" hidden />
	            	<input type="text" name="type" value="month" hidden />
	            	
	            	<button type="submit" class=" btn btn-outline-primary" >
			            Extend by a month
			        </button>
	            </form>
	            
	            <form action="/rental/modify-request" method="post">
	            	<input type="number" name="carId" value="<%= car.id %>" hidden />
	            	<input type="text" name="type" value="remove" hidden />
	            	
	            	<button type="submit" class=" btn btn-outline-danger" >
			            Terminate Rent
			        </button>
	            </form>
	            
		       </div>
	        </div>
	        </div>
	        <!-- /my car card -->
           <% } %>
           <% } %>
           

                
       		 </div> 
            </div>
            
        </main>
        

        

	<%@ include file="/components/footer.jsp" %>

    </body>

</html>