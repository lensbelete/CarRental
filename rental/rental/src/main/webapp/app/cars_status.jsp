<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">

    </head>
    <body>
        <!--we have all the booking history and we can unrent it and also edit-->
        <!--we gonna have a card for all car rent request made-->
        <h1 class="h1">Car Booking Status</h1> 
        <div class="card" style="width:50vw">
            <table class="table table-hover">
                <tr>
                    <td>
                        <label for="carId">CarId</label>
                    </td>
                    <td>
                        <input type="text" name="carId" value="car1" disabled>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="pickup-date">Start Date:</label>
                    </td>
                    <td>
                        <input type="text" name="pickup-date" value="date1" disabled>
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        <label for="dropoff-date">End Date: </label>
                    </td>
                    <td>
                        <input type="text" name="dropoff-date" value="date2" disabled>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="status">Status: </label>
                    </td>
                    <td>
                        <input type="text" name="status" value="status" disabled>
                        <!--the admin will change the status of the car-->
                    </td>
                </tr>
                <tr>
                    <td>
                        <input class="btn btn-secondary" type="submit" name="unrent" value="UnRent">
                    </td>
                    <td>
                        <input class="btn btn-secondary" type="submit" name="editStatus" value="Edit">
                    </td>
                </tr>
                
                
            </table>
        </div>
        
    <%@ include file="/components/footer.jsp" %>
        </body>
</html>