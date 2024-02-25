package com.itsc.servlets;

import jakarta.servlet.ServletException;
import com.itsc.model.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.itsc.services.UserService;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		boolean asAdmin = request.getParameter("admin") != null;
		
		
		
		UserModel user;
		try {
			user = UserService.getByEmailAndPassword(email, password);
			if (user == null || (asAdmin && !user.admin)) {
				user = null;
			}
			
			System.out.println(email + password);
			if (user == null) { 
				if (asAdmin) response.sendRedirect("admin-login.jsp");
				else response.sendRedirect("login.jsp");
				
				return;
			}
			
			request.getSession().setAttribute("uid",  user.id);
			
			if (asAdmin) response.sendRedirect("admin/home.jsp");
			else response.sendRedirect("app/home.jsp");
			
			
		} catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e.getMessage());
			e.printStackTrace();
		}
		
	}

}
