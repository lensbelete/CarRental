package com.itsc.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import com.itsc.model.CarModel;
import com.itsc.model.RequestModel;
import com.itsc.model.UserModel;

import jakarta.servlet.http.HttpServletRequest;

public class RequestService {
    
	
	public static int create(RequestModel r) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"INSERT INTO request (user_id, car_id, type,  start_date, end_date, status)" +
			"VALUES (?, ?, ?,  ?, ?, ?);");
		
		ps.setInt(1, r.userId);
		ps.setInt(2, r.carId);
		ps.setString(3, r.type);
		ps.setString(4, r.startDate);
		ps.setString(5, r.endDate);
		ps.setString(6, r.status);
		
		return ps.executeUpdate();
	}
	
	public static RequestModel getByIds(int userId, int carId) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"SELECT * FROM request WHERE user_id = ? AND car_id = ?;"
		);
		
		ps.setInt(1, userId);
		ps.setInt(2, carId);
		ResultSet rs = ps.executeQuery();
		
		if (!rs.next()) return null;
		return RequestModel.fromResultSet(rs);
		
	}
	
	public static RequestModel get(int id) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"SELECT * FROM request WHERE id = ?;"
		);
		
		ps.setInt(1, id);
		ResultSet rs = ps.executeQuery();
		
		
		if (!rs.next()) return null;
		
		return RequestModel.fromResultSet(rs);
		
	}
	
	//<user request requests>
	public static int requestExtension(int userId, int carId) throws SQLException, ClassNotFoundException {
		RequestModel r = getByIds(userId, carId);
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"UPDATE request SET type = ?, status = ?, time_stamp = datetime('now') WHERE id = ?;"
		);
		
		ps.setString(1, "month" );
		ps.setString(2,  "pending");
		ps.setInt(3, r.id);
		
		
		return ps.executeUpdate();
	}
	
	public static int requestRemoval(int userId, int carId) throws ClassNotFoundException, SQLException {
		RequestModel r = getByIds(userId, carId);
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"UPDATE request SET type = ?, status = ?, time_stamp = datetime('now') WHERE id = ?;"
		);
		
		ps.setString(1, "remove" );
		ps.setString(2,  "pending");
		ps.setInt(3, r.id);
		
		
		return ps.executeUpdate();
	}
	//</user reqeust requests>
	
	
	
	//<admin replies>
	public static int extendByMonth(int id) throws SQLException, ClassNotFoundException {
		RequestModel r = get(id);
		
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"UPDATE request SET end_date = ?, status = ?, time_stamp = datetime('now') WHERE id = ?;"
		);
		
		LocalDate nextMonth = LocalDate.parse(r.endDate).plusMonths(1);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		ps.setString(1, nextMonth.format(formatter) );
		ps.setString(2,  "accepted");
		ps.setInt(3, id);
		
		CarService.updateEndDate(r.carId, nextMonth.format(formatter) );
		
		
		return ps.executeUpdate();
	}
	
	public static int acceptNew(int id) throws ClassNotFoundException, SQLException {
		RequestModel r = get(id);
		CarService.own(r);
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"UPDATE request SET status = ?, time_stamp = datetime('now') WHERE id = ?;"
		);
		ps.setString(1,  "accepted");
		ps.setInt(2, id);
		
		return ps.executeUpdate();
	}
	
	public static int remove(int id) throws ClassNotFoundException, SQLException {
		RequestModel r = RequestService.get(id);
		CarService.disOwn(r.carId);
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"UPDATE request SET status = ?, time_stamp = datetime('now') WHERE id = ?;"
		);
		ps.setString(1,  "accepted");
		ps.setInt(2, id);
		
		return ps.executeUpdate();
	}

	public static int reject(int id) throws ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"UPDATE request SET status = ?, time_stamp = datetime('now') WHERE id = ?;"
		);
		ps.setString(1,  "rejected");
		ps.setInt(2, id);
		
		return ps.executeUpdate();
	}
	
//	</admin replies>
	
	public static ArrayList<RequestModel> getUserRequests(int user_id) throws SQLException, ClassNotFoundException {
		ArrayList<RequestModel> list = new ArrayList<RequestModel>();
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
				"SELECT * FROM request WHERE user_id IS ? ORDER BY time_stamp DESC;");
		
		ps.setInt(1, user_id);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			list.add(RequestModel.fromResultSet(rs));
		}
		return list;
	}

	public static ArrayList<RequestModel> getPendingRequests() throws SQLException, ClassNotFoundException {
		ArrayList<RequestModel> list = new ArrayList<RequestModel>();
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
				"SELECT * FROM request WHERE status IS ? ORDER BY time_stamp DESC;");
		
		ps.setString(1, "pending");
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			list.add(RequestModel.fromResultSet(rs));
		}
		return list;
	}


}

