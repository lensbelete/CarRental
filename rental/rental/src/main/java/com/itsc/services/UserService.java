package com.itsc.services;
import com.itsc.model.*;

import jakarta.servlet.http.HttpServletRequest;

import java.sql.*;

public class UserService {
	
	public static int signup(UserModel user) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"INSERT INTO user (firstName, lastName, email, password, sex)" +
			"VALUES (?, ?, ?, ?, ?);");
		
		ps.setString(1, user.firstName);
		ps.setString(2, user.lastName);
		ps.setString(3, user.email);
		ps.setString(4, user.password);
		ps.setString(5, user.sex);
		
		return ps.executeUpdate();
	}
	
	public static UserModel getByEmailAndPassword(String email, String password) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"SELECT id, firstName, lastName, email, password, sex, admin FROM user "
		+ "WHERE email = ? AND password = ?;"
				);
		
		ps.setString(1, email);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		
		
		if (!rs.next()) return null;
		
		return UserModel.fromResultSet(rs);
		
	}
	
	public static UserModel get(int id) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"SELECT id, firstName, lastName, email, password, sex, admin FROM user WHERE id = ?;"
				);
		
		ps.setInt(1, id);
		ResultSet rs = ps.executeQuery();
		
		
		if (!rs.next()) return null;
		
		return UserModel.fromResultSet(rs);
		
	}
	
	public static UserModel getFromRequest(HttpServletRequest request) throws ClassNotFoundException, SQLException {
		Object maybeId = request.getSession().getAttribute("uid");
		if (maybeId != null) {
			int id = (int) maybeId;
			return get(id);
		}else {
			return null;
		}
				
	}
	
	public static int saveEdit(UserModel user) throws ClassNotFoundException, SQLException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"UPDATE user "
		+ "SET firstName=?, lastName=?, email=?, password=?, sex=? "
		+ "WHERE id = ?;"
		);
		
		ps.setString(1, user.firstName);
		ps.setString(2, user.lastName);
		ps.setString(3, user.email);
		ps.setString(4, user.password);
		ps.setString(5, user.sex);
		ps.setInt(6, user.id);
		
		return ps.executeUpdate();
		
	}
	
	public static int delete(int id) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"DELETE FROM user WHERE id = ?");
		
		ps.setInt(1, id);		
		return ps.executeUpdate();
	}
}
