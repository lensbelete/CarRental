
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
@WebServlet("/react-request")
public class ReactRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("requestId"));
		System.out.println(request.getParameter("accept"));
		
		try {
			boolean accepted = request.getParameter("accept").equals("true");
			int requestId = Integer.parseInt(request.getParameter("requestId"));
			RequestModel r = RequestService.get(requestId);
            if (accepted) {
                if (r.type.equals("new")){
                    RequestService.acceptNew(r.id);
                }else if (r.type.equals("month")){
                    RequestService.extendByMonth(r.id);
                }else if (r.type.equals("remove")){
                    RequestService.remove(r.id);
                }
            } else {
                RequestService.reject(requestId);
            }

            response.sendRedirect("/rental/admin/home.jsp");
			
		} catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e.getMessage());
			e.printStackTrace();
		}
		
	}

}
