package com.itsc.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.http.HttpServletRequest;

public class UserModel {
	public int id = -1;
	public String firstName = "";
	public String lastName = "";
	public String email = "";
	public String password = "";
	public String sex = "";
	public boolean admin = false; 
	
	public UserModel(
			int id, String firstName, String lastName,
			String email, String password, String sex, boolean admin
		){
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.sex = sex;
		this.admin = admin;
	}
	
	public static UserModel fromResultSet(ResultSet rs) throws SQLException {
		
		return new UserModel(				
				rs.getInt(1),
				rs.getString(2),
				rs.getString(3),
				rs.getString(4),
				rs.getString(5),
				rs.getString(6),
				rs.getBoolean(7));
	}
	
	public static UserModel fromRequest(HttpServletRequest req) {
		int id = -1;
		Object maybeId = req.getParameter("id");
		if(maybeId != null) {
			id = (int) maybeId;
		}
		String firstName = req.getParameter("firstName");
		String lastName = req.getParameter("lastName");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String sex = req.getParameter("sex");
		
		boolean admin = false;
		Object maybeAdmin = req.getParameter("admin");
		if (maybeAdmin != null) admin = true;
		
		return new UserModel(id, firstName, lastName, email, password, sex, admin);
	}
	
	public String toString() {
		return "id: " + id + " " +
				"firstName: " + firstName + " " +
				"lastName: " + lastName + " " +
				"email: " + email + " " +
				"password: " + password + " " +
				"sex: " + sex + " " ;
	}

}
