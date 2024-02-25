<%@ page import="com.itsc.services.*" %>
<%@ page import="com.itsc.model.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Requests</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    </head>

    <body>
        <%@ include file="components/nav.jsp" %>

            
        
        <main class="my-5">
        <div class="container min-vh-100">
        <h1 class="h1">Pending Requests</h1> 
        
            <div class="row">
            
            <!-- Requests -->
            <%
            	
            	ArrayList<RequestModel> rs = RequestService.getPendingRequests();
            %>
            
            <% if (rs.size()==0) { %>
           		<p>No pending requests. You can rest!</p>
           	<% } %>
            
            <% if (rs.size()>0) { %>
            <% for (RequestModel r: rs){
            	UserModel user = UserService.get(r.userId);
            	CarModel car =  CarService.get(r.carId);
            	
            	String phrasing = "New rental request";
            	String detailPhrasing = "From "+ r.startDate + " to " + r.endDate ;
            	
            	if (r.type.equals("month")){
            		phrasing = "Extension by a month request";
            		detailPhrasing =  "From "+ r.startDate + " to " + r.endDate + " +30days";
            		
            	}else if (r.type.equals("remove")){
            		phrasing = "Rental termination request";
            		detailPhrasing = "";
            	}
            	
			%>
						
             <!-- request -->
            <div class="col-6 col-md-6 col-lg-3 mb-3">
	        <div class="card" >
	            <img style="width:100%; height:200px; object-fit:cover;" class="border" src="<%= CarService.getPhotoPath(car) %>" alt=""/>
	            <div class="card-body">
		            <h2 class="card-title"><%= car.model %></h2>
		            <p><%= phrasing%> </p>
		            <p> <%= detailPhrasing %></p>
		            
		            <p>Requested by <%= user.firstName + " " + user.lastName %> (<%= user.email %>)</p>
	       			
	       			<div class="d-flex justify-content-between">
			          <form action="/rental/react-request" method="post">
			            <input type="text" name="accept" value="true"  hidden/>
			            <input type="text" name="requestId" value="<%= r.id %>"  hidden/>
			            <button class=" btn btn-primary">Accept</button>
			          </form>
			          
			          <form action="/rental/react-request" method="post">
			            <input type="text" name="accept" value="false"  hidden />
			            <input type="text" name="requestId" value="<%= r.id %>" hidden />
			            <button class="btn btn-danger">Decline</button>
			          </form>
					</div>	     
	            </div>
	        </div>
	        </div>
	        
	        <!-- /request -->
           <% } %>
           <% } %>
                
       		 </div> 
            </div>
            
        </main>
        

        

	<%@ include file="/components/footer.jsp" %>

    </body>

</html>