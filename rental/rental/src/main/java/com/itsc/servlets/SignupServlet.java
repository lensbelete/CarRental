package com.itsc.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.itsc.model.UserModel;
import com.itsc.services.*;


@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserModel user = UserModel.fromRequest(request);
		
		System.out.println(user);
		try {
			int result = UserService.signup(user);
			response.sendRedirect("login.jsp");
			
		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().println(e.getMessage());
		} catch (ClassNotFoundException e) {
			response.getWriter().println(e.getMessage());
			e.printStackTrace();
		} 

		
		
	}

}
