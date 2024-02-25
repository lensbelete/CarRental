<%@ page import="com.itsc.services.*" %>
<%@ page import="com.itsc.model.*" %>
<%
	
	UserModel user = UserService.getFromRequest(request);
	boolean isMale = user.sex.equals("male");
%>
			
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Profile</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    </head>
    <body>
		<%@ include file="components/nav.jsp" %>
		
		<main class="my-5 ">
		 
       		
		<div class="container min-vh-100">

			<div class="row ">
				<div class="col-8">
	            
				<form action="../edit_profile" method="post">
					<h2 class="h2">Edit Profile</h1>
                        <table class="table ">
                            <tr>
                                <td>
                                    <label for="firstName">First Name: </label>
                                </td>
                                <td>
                                    <input type="text" name="firstName" value="<%= user.firstName %>" required>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <label for="lastName">Last Name: </label>
                                </td>
                                <td>
                                    <input type="text" name="lastName" value="<%= user.lastName %>" required>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <label for="email">Email:</label>
                                </td>
                                <td>
                                    <input type="email" name="email" value="<%=user.email%>" required hidden>
                                    <p><%=user.email%></p>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <label for="password">Password:</label>
                                </td>
                                <td>
                                    <input type="password" name="password" value="<%= user.password %>" required>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <label for="sex">Sex: </label></br>
                                </td>
                                <td>
                                    <label for="male">Male</label>
                                    <input type="radio" name="sex" value="male"  <%= isMale?"checked":""  %> ></br>
                                    <label for="female">Female</label>
                                    <input type="radio" name="sex" value="female"  <%= isMale?"":"checked"  %> >
                                </td>
                            </tr>
                        </table>

                        <input class="btn btn-primary" type="submit" name="edit" value="Save">
                    </form>
				
				<%
					boolean hasCars = CarService.getUserCars(user.id).size() > 0;
					boolean isAdmin = user.admin;
				%>
				<form action="../edit_profile" method="post" class="mt-5">
				  	<input type="hidden" name="type" value="delete">
					<h2 class="h2">Permanent Actions</h2>
					<% if(isAdmin){ %> <p> <sup>Can't delete an admin account</sup></p>  <% } %>
					<% if(hasCars){ %> <p> <sup>Can't delete account while having ongoing rents</sup></p>  <% } %>
                    <input class="btn btn-danger" type="submit" value="Delete Account" <%= (hasCars || isAdmin)?"disabled":"" %>>
				</form>
				
				</div>
			</div>
		</div>
		
		<%@ include file="/components/footer.jsp" %>
		</main>
		
		

    </body>
</html>