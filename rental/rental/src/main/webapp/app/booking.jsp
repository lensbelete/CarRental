<!DOCTYPE html>
<html>
    <head>
        <title>Booking</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mb-5">
            <h1 class="text-center my-5">Book Now</h1>
          
            <div class="row">
              <div class="col-md-6">
                <h3 class="h3"> Choose your dates </h3>
                <form action="" method="post">
                    <table class="table table-hover">
                        <tr>
                            <td>
                                <label for="carId">car Id</label>
                            </td>
                            <td>
                                <input type="text" disabled>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="pickup-date">Start Date:</label>
                            </td>
                            <td>
                                <input type="date" class="form-control" name="pickup_date" required>
                            </td>
                           
                        </tr>
                        <tr>
                            <td>
                                <label for="dropoff-date">End Date:</label>
                            </td>
                            <td>
                                <input type="date" class="form-control" name="dropoff_date" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="btn btn-primary" type="submit" value="Request">
                            </td>
                            
                        </tr>
                    </table>
                </form>
            </div>
            
          </div>
          <%@ include file="/components/footer.jsp" %>
    </body>
</html>