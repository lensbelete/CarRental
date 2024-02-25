package com.itsc.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.itsc.model.CarModel;
import com.itsc.services.CarService;



@MultipartConfig(fileSizeThreshold = 1024 * 1024,
maxFileSize = 1024 * 1024 * 5, 
maxRequestSize = 1024 * 1024 * 5 * 5)

@WebServlet("/new-car")
public class NewCarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String photoName = CarService.savePhotoAndGetName(request);
    	String model = request.getParameter("model");
    	int rentalFee = Integer.parseInt( request.getParameter("rentalFee"));
    	CarModel car = new CarModel(-1, model, rentalFee, photoName, "-1", -1, "-1", "-1");
    	try {
			CarService.save(car);
			response.sendRedirect("/rental/admin/cars.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			response.getWriter().println(e.getMessage());
		}
    	System.out.println(car.toString());
    }

}
