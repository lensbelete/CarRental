package com.itsc.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.itsc.model.UserModel;
import com.itsc.services.CarService;
import com.itsc.services.UserService;

@WebServlet("/edit_profile")
public class EditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EditProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    

     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		
		try {
			int id = UserService.getFromRequest(request).id;
			
			if (type != null && type.equals("delete")) {
				UserService.delete(id);
				response.sendRedirect("/rental/");
				return;
			}
			
			System.out.print(id);
			UserModel user = UserModel.fromRequest(request);
			user.id = id;
			UserService.saveEdit(user);
			response.sendRedirect("/rental/app/edit_profile.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e.getMessage());
			e.printStackTrace();
		}
		
		
	}

}
