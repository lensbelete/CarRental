
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
@WebServlet("/modify-request")
public class ModifyRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			UserModel user = UserService.getFromRequest(request);
			int userId = user.id;
			
			String type = request.getParameter("type");
			int carId = Integer.parseInt(request.getParameter("carId"));
			
            if (type.equals("month")){
                RequestService.requestExtension(userId, carId);
            }else if (type.equals("remove")){
                RequestService.requestRemoval(userId, carId);
            }
            

            response.sendRedirect("/rental/app/requests.jsp");
			
		} catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e.getMessage());
			e.printStackTrace();
		}
		
	}

}
