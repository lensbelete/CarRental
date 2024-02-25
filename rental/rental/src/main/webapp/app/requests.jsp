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
        <header>
			<%@ include file="components/nav.jsp" %>
        </header>

        <main class="my-5">
        <div class="container min-vh-100">
        <h1 class="h1">Requests</h1> 
        
            <div class="row">
            
            <!-- Requests -->
            <%
            	UserModel user = UserService.getFromRequest(request);
            	ArrayList<RequestModel> rs = RequestService.getUserRequests(user.id);
            %>
            
            <% if (rs.size()==0) { %>
           		<p>You haven't asked for a rent so far!</p>
           	<% } %>
            
            <% if (rs.size()>0) { %>
            <% for (RequestModel r: rs){
            	CarModel car =  CarService.get(r.carId);
            	String phrasing = "New rental request";
            	String detailPhrasing = "From "+ r.startDate + " to " + r.endDate ;
            	String textColor = "text-primary";
            	
            	if (r.type.equals("month")){
            		phrasing = "Extension by a month request";
            		detailPhrasing =  "From "+ r.startDate + " to " + r.endDate + " +30days";
            		
            	}else if (r.type.equals("remove")){
            		phrasing = "Rental termination request";
            		detailPhrasing = "";
            	}
            	
            	if (r.status.equals("accepted")) textColor = "text-success";
            	else if  (r.status.equals("rejected")) textColor = "text-danger";
			%>
            
            <div class="col-md-3 col-sm-6 mb-3">
	        <div class="card" >
	            <img style="width:100%; height:150px; object-fit:cover;" class="border" src="<%= CarService.getPhotoPath(car) %>" alt=""/>
	            <div class="card-body">
		            <h2 class="card-title"><%= car.model %></h2>
		            <p><%= phrasing%> </p>
		            <p> <%= detailPhrasing %></p>
	       			<p class="<%= textColor%>"> <%= r.status %> </p>	     
	            </div>
	        </div>
	        </div>
	        
	        <!-- /request -->
           <% } %>
           <% } %>
           <!-- /search cars -->
                
       		 </div> 
            </div>
            
        </main>
        

        

<%@ include file="/components/footer.jsp" %>

    </body>

</html>