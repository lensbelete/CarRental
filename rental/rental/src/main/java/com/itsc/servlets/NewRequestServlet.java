package com.itsc.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.itsc.model.RequestModel;
import com.itsc.model.*;
import com.itsc.services.*;

/**
 * Servlet implementation class NewRequestServlet
 */
@WebServlet("/new-request")
public class NewRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			RequestModel r = RequestModel.fromRequest(request);
//			UserModel user = UserService.getFromRequest(request);
			RequestService.create(r);
			response.sendRedirect("/rental/app/home.jsp");
			
		} catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e.getMessage());
			e.printStackTrace();
		}
		
	}

}
