package com.itsc.servlets;
import java.io.IOException;
import java.sql.SQLException;

import com.itsc.model.UserModel;
import com.itsc.services.UserService;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {"/app/*"})
public class AuthFilter implements Filter {


    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
		try {
			UserModel user = UserService.getFromRequest(httpRequest);
			System.out.println("filtering...");
			if (user == null) {
				httpResponse.sendRedirect("/rental/login.jsp"); 
			} else {
				chain.doFilter(request, response); 
			}
		} catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e.getMessage());
			e.printStackTrace();
		}
    }

 
}