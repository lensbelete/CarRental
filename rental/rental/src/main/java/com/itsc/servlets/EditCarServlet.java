package com.itsc.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.itsc.services.CarService;


@WebServlet("/edit-car")
public class EditCarServlet extends HttpServlet {


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		int carId = Integer.parseInt(request.getParameter("carId"));
		
		try {
			if (type.equals("fee")) {
				int newMonthlyFee = Integer.parseInt(request.getParameter("amount"));
				CarService.updateRentalFee(carId, newMonthlyFee);
			}else if (type.equals("disown")) {
				System.out.println(CarService.disOwn(carId));
			}else if (type.equals("delete")) {
				CarService.delete(carId);
			}
			response.sendRedirect("/rental/admin/cars.jsp");
			
		} catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e.getMessage());
			e.printStackTrace();
		}
			
		
	}

}
